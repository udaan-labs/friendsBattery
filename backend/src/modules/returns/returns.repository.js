const { prisma } = require('../../config/db');
const { httpError } = require('../../shared/utils/http-error');

class ReturnsRepository {
  /**
   * Find a product unit by serial number
   */
  async getProductUnitBySerialNumber(serialNumber) {
    return prisma.productUnit.findUnique({
      where: { serialNumber },
      include: { product: true },
    });
  }

  /**
   * Find the latest sales transaction for a product unit
   */
  async getLatestSalesTransaction(productUnitId) {
    return prisma.salesTransaction.findFirst({
      where: { productUnitId },
      orderBy: { soldAt: 'desc' },
      include: { customer: true },
    });
  }

  /**
   * Process return: claim SOLD → restockStatus, ReturnProduct row, ledger.
   */
  async processReturn(data) {
    const {
      productUnitId,
      productId,
      transactionId,
      serialNumber,
      reason,
      actorId,
      ownerType,
      restockStatus,
    } = data;

    return prisma.$transaction(async (tx) => {
      const claimed = await tx.productUnit.updateMany({
        where: {
          id: productUnitId,
          status: 'SOLD',
        },
        data: {
          status: restockStatus,
          ownerId: actorId,
          ownerType,
        },
      });
      if (claimed.count !== 1) {
        throw httpError(409,
          'Product is no longer in SOLD status (already returned or sold again).'
        );
      }

      const updatedUnit = await tx.productUnit.findUnique({
        where: { id: productUnitId },
      });

      const returnRecord = await tx.returnProduct.create({
        data: {
          transactionId,
          productId,
          serialNumber,
          reason,
          returnType: 'CUSTOMER_RETURN',
          returnById: actorId,
        },
      });

      // Clear due without inventing cash: write sellPrice down to amountPaid.
      const sale = await tx.salesTransaction.findUnique({
        where: { id: transactionId },
        select: { sellPrice: true, amountPaid: true },
      });
      if (sale) {
        const paid = Number(sale.amountPaid ?? 0);
        if (paid < Number(sale.sellPrice)) {
          await tx.salesTransaction.update({
            where: { id: transactionId },
            data: { sellPrice: sale.amountPaid ?? 0 },
          });
        }
      }

      await tx.inventoryTransaction.create({
        data: {
          productUnitId,
          fromUserId: null,
          toUserId: actorId,
          action: 'RETURNED',
        },
      });

      return {
        updatedUnit,
        returnRecord,
      };
    });
  }

  /**
   * Get all returns based on optional filter (e.g. sellerId)
   */
  async getReturns(where = {}) {
    return prisma.returnProduct.findMany({
      where,
      orderBy: { createdAt: 'desc' },
      include: {
        product: {
          include: {
            productName: true,
            productModel: true,
          },
        },
      },
    });
  }
}

module.exports = new ReturnsRepository();
