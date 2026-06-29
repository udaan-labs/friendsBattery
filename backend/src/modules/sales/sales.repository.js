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
        ownerId: BigInt(sellerId),
        status: 'AVAILABLE'
      },
      include: {
        product: true
      }
    });
  }

  /**
   * Find an available product unit by product ID and seller ID
   */
  async findAvailableProductUnitByProductId(productId, sellerId) {
    return prisma.productUnit.findFirst({
      where: {
        productId: productId,
        ownerId: BigInt(sellerId),
        status: 'AVAILABLE'
      }
    });
  }

  /**
   * Check if a serial number is already in use by any product unit
   */
  async checkSerialNumberExists(serialNumber) {
    return prisma.productUnit.findUnique({
      where: { serialNumber }
    });
  }

  /**
   * Create sale transaction and update inventory atomically
   * Includes the immutable ledger record for inventory_transactions
   */
  async createSaleTransaction(saleData) {
    return prisma.$transaction(async (tx) => {
      // 1. Update ProductUnit status to SOLD and update serialNumber
      await tx.productUnit.update({
        where: { id: saleData.productUnitId },
        data: { 
          status: 'SOLD',
          soldDate: new Date()
          // serialNumber doesn't change since we are scanning the actual serial
        }
      });

      // 2. Create the SalesTransaction record
      const sale = await tx.salesTransaction.create({
        data: {
          productId: saleData.productId,
          productUnitId: saleData.productUnitId,
          customerId: saleData.customerId,
          sellerId: BigInt(saleData.sellerId),
          sellPrice: saleData.sellPrice,
          serialNumber: saleData.serialNumber,
          vehicleNumber: saleData.vehicleNumber
        }
      });

      // 3. Create audit log in inventory_transactions (Immutable Ledger)
      await tx.inventoryTransaction.create({
        data: {
          productUnitId: saleData.productUnitId,
          fromUserId: BigInt(saleData.sellerId),
          toUserId: BigInt(saleData.sellerId), // Required by schema, we set it back to seller since customer isn't a User
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
      where: { sellerId: BigInt(sellerId) },
      include: {
        customer: true,
        seller: { select: { id: true, userName: true, shopName: true } },
        product: {
          include: {
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
  async getSalesHistoryBySeller(sellerId, filters, pagination) {
    const { searchCustomer, searchSerial, fromDate, toDate } = filters;
    const { skip, take } = pagination;

    const whereClause = {
      sellerId: BigInt(sellerId),
      ...(searchCustomer && {
        customer: {
          name: {
            contains: searchCustomer,
            mode: 'insensitive',
          },
        },
      }),
      ...(searchSerial && {
        serialNumber: {
          contains: searchSerial,
          mode: 'insensitive',
        },
      }),
      ...(fromDate &&
        toDate && {
          soldAt: {
            gte: new Date(fromDate),
            lte: new Date(toDate),
          },
        }),
    };

    return prisma.salesTransaction.findMany({
      where: whereClause,
      include: {
        customer: true,
        seller: { select: { id: true, userName: true, shopName: true } },
        product: {
          include: {
            productName: true,
            productModel: true,
          },
        },
      },
      orderBy: { soldAt: 'desc' },
      skip,
      take,
    });
  }

  async countSalesHistoryBySeller(sellerId, filters) {
    const { searchCustomer, searchSerial, fromDate, toDate } = filters;

    const whereClause = {
      sellerId: BigInt(sellerId),
      ...(searchCustomer && {
        customer: {
          name: {
            contains: searchCustomer,
            mode: 'insensitive',
          },
        },
      }),
      ...(searchSerial && {
        serialNumber: {
          contains: searchSerial,
          mode: 'insensitive',
        },
      }),
      ...(fromDate &&
        toDate && {
          soldAt: {
            gte: new Date(fromDate),
            lte: new Date(toDate),
          },
        }),
    };

    return prisma.salesTransaction.count({
      where: whereClause,
    });
  }

  /**
   * Build WHERE clause for admin sales history queries
   */
  _buildAdminWhereClause(filters) {
    const { search, sellerId, fromDate, toDate, shipmentStatus } = filters;

    const where = {};

    if (sellerId) {
      where.sellerId = BigInt(sellerId);
    }

    if (fromDate && toDate) {
      where.soldAt = {
        gte: new Date(fromDate),
        lte: new Date(toDate),
      };
    }

    if (search) {
      where.OR = [
        {
          customer: {
            name: { contains: search, mode: 'insensitive' },
          },
        },
        {
          seller: {
            userName: { contains: search, mode: 'insensitive' },
          },
        },
        {
          seller: {
            shopName: { contains: search, mode: 'insensitive' },
          },
        },
        {
          product: {
            productName: {
              name: { contains: search, mode: 'insensitive' },
            },
          },
        },
        {
          serialNumber: { contains: search, mode: 'insensitive' },
        },
      ];
    }

    if (shipmentStatus) {
      where.productUnit = {
        newShipmentItems: {
          some: {
            shipment: {
              status: shipmentStatus,
            },
          },
        },
      };
    }

    return where;
  }

  /**
   * Fetch all sales for Admin with full details (seller, customer, product, shipment)
   */
  async getAdminSalesHistory(filters, pagination) {
    const { skip, take } = pagination;
    const where = this._buildAdminWhereClause(filters);

    return prisma.salesTransaction.findMany({
      where,
      include: {
        customer: true,
        seller: {
          select: { id: true, userName: true, shopName: true },
        },
        product: {
          include: {
            productName: true,
            productModel: true,
          },
        },
        productUnit: {
          include: {
            newShipmentItems: {
              include: {
                shipment: true,
              },
              take: 1,
            },
          },
        },
      },
      orderBy: { soldAt: 'desc' },
      skip,
      take,
    });
  }

  /**
   * Count all admin sales (mirrors getAdminSalesHistory filters)
   */
  async countAdminSalesHistory(filters) {
    const where = this._buildAdminWhereClause(filters);
    return prisma.salesTransaction.count({ where });
  }
}

module.exports = new SalesRepository();
