const { prisma } = require('../../config/db');

/**
 * Sales Repository
 *
 * Handles database queries for the sales module.
 * No business logic, purely data access.
 */
class SalesRepository {
  /**
   * Find a customer by mobile number
   */
  async findCustomerByMobile(mobile) {
    return prisma.customer.findFirst({
      where: { phone: mobile }
    });
  }

  /**
   * Create a new customer
   */
  async createCustomer(data) {
    return prisma.customer.create({
      data: {
        name: data.name,
        phone: data.phone
      }
    });
  }

  /**
   * Find an available product unit by serial number and seller ID
   */
  async findAvailableProductUnit(serialNumber, sellerId) {
    return prisma.productUnit.findFirst({
      where: {
        serialNumber,
        ownerId: sellerId,
        status: 'IN_STOCK'
      }
    });
  }

  /**
   * Create sale transaction and update inventory atomically
   * Includes the immutable ledger record for inventory_transactions
   */
  async createSaleTransaction(saleData) {
    return prisma.$transaction(async (tx) => {
      // 1. Update ProductUnit status to SOLD
      await tx.productUnit.update({
        where: { id: saleData.productUnitId },
        data: { status: 'SOLD' }
      });

      // 2. Create the SalesTransaction record
      const sale = await tx.salesTransaction.create({
        data: {
          productId: saleData.productId,
          productUnitId: saleData.productUnitId,
          customerId: saleData.customerId,
          sellerId: saleData.sellerId,
          sellPrice: saleData.sellPrice,
          serialNumber: saleData.serialNumber,
          vehicleNumber: saleData.vehicleNumber
        }
      });

      // 3. Create audit log in inventory_transactions (Immutable Ledger)
      await tx.inventoryTransaction.create({
        data: {
          productUnitId: saleData.productUnitId,
          fromUserId: saleData.sellerId,
          toUserId: saleData.sellerId, // Required by schema, we set it back to seller since customer isn't a User
          action: 'SOLD'
        }
      });

      return sale;
    });
  }

  /**
   * Fetch all sales (for Admin)
   */
  async getAllSales() {
    return prisma.salesTransaction.findMany({
      include: {
        customer: true,
        seller: { select: { id: true, userName: true, shopName: true } },
        product: {
          include: {
            category: true,
            productName: true,
            productModel: true
          }
        }
      },
      orderBy: { soldAt: 'desc' }
    });
  }

  /**
   * Fetch sales for a specific seller
   */
  async getSalesBySeller(sellerId) {
    return prisma.salesTransaction.findMany({
      where: { sellerId },
      include: {
        customer: true,
        seller: { select: { id: true, userName: true, shopName: true } },
        product: {
          include: {
            category: true,
            productName: true,
            productModel: true
          }
        }
      },
      orderBy: { soldAt: 'desc' }
    });
  }

  /**
   * Fetch a single sale by its ID
   */
  async findSaleById(transactionId) {
    return prisma.salesTransaction.findUnique({
      where: { id: transactionId },
      include: {
        customer: true,
        seller: { select: { id: true, userName: true, shopName: true } },
        product: {
          include: {
            category: true,
            productName: true,
            productModel: true
          }
        }
      }
    });
  }

  /**
   * Fetch complete purchase history for a customer mobile
   */
  async getSalesByCustomerMobile(mobile) {
    return prisma.salesTransaction.findMany({
      where: {
        customer: {
          phone: mobile
        }
      },
      include: {
        customer: true,
        seller: { select: { id: true, userName: true, shopName: true } },
        product: {
          include: {
            category: true,
            productName: true,
            productModel: true
          }
        }
      },
      orderBy: { soldAt: 'desc' }
    });
  }
}

module.exports = new SalesRepository();
