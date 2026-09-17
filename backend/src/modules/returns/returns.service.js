const returnsRepository = require('./returns.repository');
const { httpError } = require('../../shared/utils/http-error');
const ROLES = require('../../shared/constants/roles');
const {
  resolveAdminShopScope,
  resolveShopSellerIds,
  isUserInShopScope,
} = require('../../shared/utils/shop-scope.util');
const { prisma } = require('../../config/db');

class ReturnsService {
  /**
   * Shop seller/admin may return sales by self, employee, or other shop staff.
   */
  async _assertCanReturnSale(actor, sale) {
    if (Number(sale.sellerId) === Number(actor.id)) return;

    const saleSeller = await prisma.user.findUnique({
      where: { id: BigInt(sale.sellerId) },
      select: {
        id: true,
        parentId: true,
        locationId: true,
        location: { select: { warehouseId: true } },
      },
    });
    if (!saleSeller) {
      throw httpError(403, 'You cannot return a product that you did not sell');
    }

    if (actor.role === ROLES.SUPER_ADMIN) return;

    if (actor.role === ROLES.ADMIN) {
      const scope = resolveAdminShopScope(actor);
      if (scope && isUserInShopScope(saleSeller, scope)) return;
      throw httpError(403, 'You cannot return a product outside your shop');
    }

    if (actor.role === ROLES.SELLER) {
      if (
        actor.locationId != null &&
        saleSeller.locationId != null &&
        Number(actor.locationId) === Number(saleSeller.locationId)
      ) {
        return;
      }
      if (
        actor.parentId != null &&
        saleSeller.parentId != null &&
        Number(actor.parentId) === Number(saleSeller.parentId)
      ) {
        return;
      }
      throw httpError(403, 'You cannot return a product that you did not sell');
    }

    throw httpError(403, 'You cannot return a product that you did not sell');
  }

  /**
   * Process a product return. Restocks AVAILABLE (default) or DEFECTIVE.
   * @param {Object} data - serial_number, reason, restock_as?
   * @param {object} actor - req.user
   */
  async processReturn(data, actor) {
    const { serial_number: serialNumber, reason, restock_as: restockAs } = data;
    const restockStatus = restockAs === 'DEFECTIVE' ? 'DEFECTIVE' : 'AVAILABLE';

    if (!serialNumber || !reason) {
      throw httpError(400, 'serial_number and reason are required');
    }

    const productUnit = await returnsRepository.getProductUnitBySerialNumber(serialNumber);

    if (!productUnit) {
      throw httpError(404, `Product unit with serial number ${serialNumber} not found`);
    }

    if (productUnit.status !== 'SOLD') {
      throw httpError(400, `Product unit is not in SOLD status. Current status: ${productUnit.status}`);
    }

    const latestSale = await returnsRepository.getLatestSalesTransaction(productUnit.id);

    if (!latestSale) {
      throw httpError(400, 'No sales transaction found for this product unit');
    }

    await this._assertCanReturnSale(actor, latestSale);

    const ownerType =
      actor.role === ROLES.SELLER ? 'SELLER' : actor.role === ROLES.SUPER_ADMIN ? 'SUPER_ADMIN' : 'ADMIN';

    const result = await returnsRepository.processReturn({
      productUnitId: productUnit.id,
      productId: productUnit.productId,
      transactionId: latestSale.id,
      serialNumber,
      reason,
      actorId: BigInt(actor.id),
      ownerType,
      restockStatus,
      actorLocationId: actor.locationId ?? null,
    });

    return {
      message: 'Return processed successfully',
      returnRecordId: result.returnRecord.id.toString(),
      productUnitId: result.updatedUnit.id.toString(),
      status: result.updatedUnit.status,
    };
  }

  /**
   * Get return history based on user role.
   * SA: all · shop Admin: own shop sellers · Seller: own only
   */
  async getReturns(user) {
    const where = {};

    if (user.role === ROLES.SUPER_ADMIN) {
      // all
    } else if (user.role === ROLES.ADMIN) {
      const scope = resolveAdminShopScope(user);
      const sellerIds = await resolveShopSellerIds(prisma, scope);
      where.returnById = {
        in: (sellerIds || []).map((id) => BigInt(id)),
      };
    } else {
      where.returnById = user.id;
    }

    const returns = await returnsRepository.getReturns(where);

    return returns.map((r) => ({
      ...r,
      id: r.id.toString(),
      transactionId: r.transactionId ? r.transactionId.toString() : null,
      productId: r.productId ? r.productId.toString() : null,
      returnById: r.returnById ? r.returnById.toString() : null,
      returnToId: r.returnToId ? r.returnToId.toString() : null,
      product: r.product
        ? {
            ...r.product,
            id: r.product.id.toString(),
            productNameId: r.product.productNameId.toString(),
            productModelId: r.product.productModelId.toString(),
            productName: r.product.productName
              ? {
                  ...r.product.productName,
                  id: r.product.productName.id.toString(),
                }
              : null,
            productModel: r.product.productModel
              ? {
                  ...r.product.productModel,
                  id: r.product.productModel.id.toString(),
                  productNameId: r.product.productModel.productNameId.toString(),
                }
              : null,
          }
        : null,
    }));
  }
}

module.exports = new ReturnsService();
