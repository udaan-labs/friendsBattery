const { prisma } = require('../../config/db');
const { httpError } = require('../../shared/utils/http-error');

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
   * AVAILABLE unit for sale: owner stock OR shop location stock.
   * @param {string} serialNumber
   * @param {{ ownerId?: number|bigint, locationId?: number|bigint }} scope
   */
  async findAvailableProductUnit(serialNumber, scope) {
    const clean = serialNumber != null ? String(serialNumber).trim() : '';
    const where = {
      serialNumber: { equals: clean, mode: 'insensitive' },
      status: 'AVAILABLE',
    };
    if (scope.locationId != null) {
      where.currentLocationId = BigInt(scope.locationId);
    } else {
      where.ownerId = BigInt(scope.ownerId);
    }
    return prisma.productUnit.findFirst({
      where,
      include: { product: true },
    });
  }

  /** Atomic sale + unit claim + ledger row. */
  async createSaleTransaction(saleData) {
    return prisma.$transaction(async (tx) => {
      const claimWhere = {
        id: saleData.productUnitId,
        status: 'AVAILABLE',
      };
      if (saleData.claimByLocationId != null) {
        claimWhere.currentLocationId = BigInt(saleData.claimByLocationId);
      } else {
        claimWhere.ownerId = BigInt(saleData.ownerId ?? saleData.sellerId);
      }

      const claimed = await tx.productUnit.updateMany({
        where: claimWhere,
        data: { status: 'SOLD', soldDate: new Date() },
      });
      if (claimed.count !== 1) {
        throw httpError(409, 'The scanned serial number is not available in your inventory.');
      }

      const sale = await tx.salesTransaction.create({
        data: {
          productId: saleData.productId,
          productUnitId: saleData.productUnitId,
          customerId: saleData.customerId,
          sellerId: BigInt(saleData.sellerId),
          sellPrice: saleData.sellPrice,
          serialNumber: saleData.serialNumber,
          vehicleNumber: saleData.vehicleNumber,
          saleType: saleData.saleType,
          scrapSerial: saleData.scrapSerial ?? null,
        },
      });

      const ownerId = BigInt(saleData.ownerId ?? saleData.sellerId);
      await tx.inventoryTransaction.create({
        data: {
          productUnitId: saleData.productUnitId,
          fromUserId: ownerId,
          toUserId: ownerId,
          action: 'SOLD',
        },
      });

      return sale;
    });
  }

  async findProductUnitById(id) {
    return prisma.productUnit.findUnique({ where: { id: BigInt(id) } });
  }

  /** Service bill row — no unit / ledger write. */
  async createServiceBill(data) {
    return prisma.serviceBill.create({
      data: {
        sellerId: BigInt(data.sellerId),
        customerId: data.customerId != null ? BigInt(data.customerId) : null,
        serviceType: data.serviceType,
        amount: data.amount,
        vehicleNumber: data.vehicleNumber ?? null,
        place: data.place ?? null,
      },
    });
  }

  /** Atomic rent-out: unit AVAILABLE → RENTED + rent row + ledger. */
  async createRentOut(rentData) {
    return prisma.$transaction(async (tx) => {
      const claimWhere = {
        id: rentData.productUnitId,
        status: 'AVAILABLE',
      };
      if (rentData.claimByLocationId != null) {
        claimWhere.currentLocationId = BigInt(rentData.claimByLocationId);
      } else {
        claimWhere.ownerId = BigInt(rentData.ownerId ?? rentData.sellerId);
      }

      const claimed = await tx.productUnit.updateMany({
        where: claimWhere,
        data: { status: 'RENTED' },
      });
      if (claimed.count !== 1) {
        throw httpError(409, 'Serial is not available for rent in your inventory.');
      }

      const rent = await tx.batteryRent.create({
        data: {
          productUnitId: rentData.productUnitId,
          sellerId: BigInt(rentData.sellerId),
          customerId: rentData.customerId != null ? BigInt(rentData.customerId) : null,
          serialNumber: rentData.serialNumber,
          deposit: rentData.deposit,
          status: 'OUT',
        },
      });

      const ownerId = BigInt(rentData.ownerId ?? rentData.sellerId);
      await tx.inventoryTransaction.create({
        data: {
          productUnitId: rentData.productUnitId,
          fromUserId: ownerId,
          toUserId: ownerId,
          action: 'RENTED',
        },
      });

      return rent;
    });
  }

  async findOpenRentBySerial(serialNumber) {
    const clean = serialNumber != null ? String(serialNumber).trim() : '';
    return prisma.batteryRent.findFirst({
      where: {
        serialNumber: { equals: clean, mode: 'insensitive' },
        status: 'OUT',
      },
      orderBy: { rentedAt: 'desc' },
    });
  }

  /** Atomic rent return: unit RENTED → AVAILABLE + fee/refund + ledger. */
  async returnRent(returnData) {
    return prisma.$transaction(async (tx) => {
      const updated = await tx.batteryRent.updateMany({
        where: { id: returnData.rentId, status: 'OUT' },
        data: {
          status: 'RETURNED',
          rentFee: returnData.rentFee,
          refundAmount: returnData.refundAmount,
          returnedAt: new Date(),
        },
      });
      if (updated.count !== 1) {
        throw httpError(409, 'This rent is already returned or not found.');
      }

      const unitOk = await tx.productUnit.updateMany({
        where: { id: returnData.productUnitId, status: 'RENTED' },
        data: { status: 'AVAILABLE' },
      });
      if (unitOk.count !== 1) {
        throw httpError(409, 'Unit is not currently marked as rented.');
      }

      const ownerId = BigInt(returnData.ownerId);
      await tx.inventoryTransaction.create({
        data: {
          productUnitId: returnData.productUnitId,
          fromUserId: ownerId,
          toUserId: ownerId,
          action: 'RENT_RETURNED',
        },
      });

      return tx.batteryRent.findUnique({ where: { id: returnData.rentId } });
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
   * Fetch sales for multiple sellers (shop Admin scope).
   * @param {bigint[]|number[]} sellerIds
   */
  async getSalesBySellerIds(sellerIds) {
    if (!sellerIds || sellerIds.length === 0) return [];
    return prisma.salesTransaction.findMany({
      where: { sellerId: { in: sellerIds.map((id) => BigInt(id)) } },
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

  _sanitizeSearch(str) {
    if (!str || typeof str !== 'string') return str;
    return str.trim().replace(/[%_]/g, '\\$&');
  }

  /**
   * Build WHERE clause for admin sales history queries
   */
  _buildAdminWhereClause(filters) {
    const { search, sellerId, sellerIds, fromDate, toDate, shipmentStatus } = filters;

    const where = {};

    if (sellerId) {
      where.sellerId = BigInt(sellerId);
    } else if (sellerIds && Array.isArray(sellerIds)) {
      if (sellerIds.length === 0) {
        // No sellers in shop → empty result
        where.sellerId = { in: [] };
      } else {
        where.sellerId = { in: sellerIds.map((id) => BigInt(id)) };
      }
    }

    if (fromDate && toDate) {
      where.soldAt = {
        gte: new Date(fromDate),
        lte: new Date(toDate),
      };
    }

    if (search && search.trim().length > 0) {
      const cleanSearch = this._sanitizeSearch(search);
      where.OR = [
        {
          customer: {
            name: { contains: cleanSearch, mode: 'insensitive' },
          },
        },
        {
          seller: {
            userName: { contains: cleanSearch, mode: 'insensitive' },
          },
        },
        {
          seller: {
            shopName: { contains: cleanSearch, mode: 'insensitive' },
          },
        },
        {
          product: {
            productName: {
              name: { contains: cleanSearch, mode: 'insensitive' },
            },
          },
        },
        {
          serialNumber: { contains: cleanSearch, mode: 'insensitive' },
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
