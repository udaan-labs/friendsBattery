const { prisma } = require('../../config/db');

class ReturnsRepository {
  /**
   * Find a product unit by serial number
   */
  async getProductUnitBySerialNumber(serialNumber) {
    return prisma.productUnit.findUnique({
      where: { serialNumber },
      include: { product: true }
    });
  }

  /**
   * Find the latest sales transaction for a product unit
   */
  async getLatestSalesTransaction(productUnitId) {
    return prisma.salesTransaction.findFirst({
      where: { productUnitId },
      orderBy: { soldAt: 'desc' },
      include: { customer: true }
    });
  }

  /**
   * Process the return transaction
   * Updates product unit status, creates ReturnProduct record, logs inventory transaction
   */
  async processReturn(data) {
    const { productUnitId, productId, transactionId, serialNumber, reason, sellerId } = data;

    return prisma.$transaction(async (tx) => {
      // 1. Update ProductUnit status to RETURNED
      const updatedUnit = await tx.productUnit.update({
        where: { id: productUnitId },
        data: {
          status: 'RETURNED',
          ownerId: sellerId,
          ownerType: 'SELLER'
        }
      });

      // 2. Create ReturnProduct record
      const returnRecord = await tx.returnProduct.create({
        data: {
          transactionId,
          productId,
          serialNumber,
          reason,
          returnType: 'CUSTOMER_RETURN',
          returnById: sellerId, // The seller who processed it
        }
      });

      // 3. Create InventoryTransaction to log the movement
      await tx.inventoryTransaction.create({
        data: {
          productUnitId,
          fromUserId: null, // Returned by customer (no user id)
          toUserId: sellerId,
          action: 'RETURNED'
        }
      });

      return {
        updatedUnit,
        returnRecord
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
            productModel: true
          }
        }
      }
    });
  }
}

module.exports = new ReturnsRepository();
