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
          paymentMode: saleData.paymentMode || 'CASH',
          amountPaid: saleData.amountPaid ?? 0,
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
        paymentMode: data.paymentMode || 'CASH',
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
          paymentMode: rentData.paymentMode || 'CASH',
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
      include: { customer: { select: { name: true, phone: true } } },
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
        seller: { select: { id: true, userName: true, shopName: true, locationId: true } },
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
  _unpaidWhere(unpaid) {
    if (!unpaid) return {};
    return {
      paymentMode: 'CREDIT',
      amountPaid: { lt: prisma.salesTransaction.fields.sellPrice },
    };
  }

  async addSalePayment(transactionId, amount) {
    const amt = Number(amount);
    return prisma.$transaction(async (tx) => {
      const sale = await tx.salesTransaction.findUnique({
        where: { id: BigInt(transactionId) },
      });
      if (!sale) throw httpError(404, 'Transaction not found');
      if ((sale.paymentMode || 'CASH') !== 'CREDIT') {
        throw httpError(400, 'Only credit sales can receive a payment');
      }
      const sellPrice = Number(sale.sellPrice);
      const paid = Number(sale.amountPaid ?? 0);
      const due = Math.max(0, sellPrice - paid);
      if (due <= 0) throw httpError(400, 'This sale is already fully paid');
      if (amt > due) {
        throw httpError(400, `Amount cannot exceed remaining due (₹${due})`);
      }
      const nextPaid = Math.round((paid + amt) * 100) / 100;
      const n = await tx.salesTransaction.updateMany({
        where: {
          id: sale.id,
          paymentMode: 'CREDIT',
          amountPaid: sale.amountPaid,
        },
        data: { amountPaid: nextPaid },
      });
      if (n.count !== 1) {
        throw httpError(409, 'Payment was updated by someone else. Try again.');
      }
    });
  }

  async getSalesHistoryBySeller(sellerId, filters, pagination) {
    const { searchCustomer, searchSerial, fromDate, toDate, paymentMode, unpaid, locationId } =
      filters;
    const { skip, take } = pagination;

    const whereClause = {
      ...(locationId != null
        ? { seller: { locationId: BigInt(locationId) } }
        : { sellerId: BigInt(sellerId) }),
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
      ...(unpaid ? this._unpaidWhere(true) : paymentMode ? { paymentMode } : {}),
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
    const { search, fromDate, toDate, shipmentStatus, saleType, paymentMode } = filters;

    const where = this._sellerScopeWhere(filters);

    if (saleType && saleType !== 'SERVICE' && saleType !== 'RENT') {
      where.saleType = saleType;
    }
    if (filters.unpaid) Object.assign(where, this._unpaidWhere(true));
    else if (paymentMode) where.paymentMode = paymentMode;

    if (fromDate || toDate) {
      where.soldAt = {};
      if (fromDate) where.soldAt.gte = new Date(fromDate);
      if (toDate) where.soldAt.lte = new Date(toDate);
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

  /**
   * Fetch Service Bills for Admin history
   */
  _sellerScopeWhere(filters) {
    const { sellerId, sellerIds, locationId } = filters || {};
    const where = {};
    if (sellerId) where.sellerId = BigInt(sellerId);
    else if (sellerIds && Array.isArray(sellerIds)) {
      where.sellerId = { in: sellerIds.map((id) => BigInt(id)) };
    }
    if (locationId) {
      where.seller = { locationId: BigInt(locationId) };
    }
    return where;
  }

  /**
   * Fetch Service Bills for Admin history
   */
  async getAdminServiceBills(filters, take = 100) {
    const where = this._sellerScopeWhere(filters);
    if (filters.paymentMode) where.paymentMode = filters.paymentMode;
    if (filters.fromDate || filters.toDate) {
      where.createdAt = {};
      if (filters.fromDate) where.createdAt.gte = new Date(filters.fromDate);
      if (filters.toDate) where.createdAt.lte = new Date(filters.toDate);
    }
    if (filters.search && filters.search.trim().length > 0) {
      const clean = this._sanitizeSearch(filters.search);
      where.OR = [
        { customer: { name: { contains: clean, mode: 'insensitive' } } },
        { seller: { userName: { contains: clean, mode: 'insensitive' } } },
        { seller: { shopName: { contains: clean, mode: 'insensitive' } } },
        { vehicleNumber: { contains: clean, mode: 'insensitive' } },
        { place: { contains: clean, mode: 'insensitive' } },
      ];
    }
    return prisma.serviceBill.findMany({
      where,
      include: {
        customer: true,
        seller: { select: { id: true, userName: true, shopName: true } },
      },
      orderBy: { createdAt: 'desc' },
      take,
    });
  }

  /**
   * Fetch Battery Rents for Admin history
   */
  async getAdminBatteryRents(filters, take = 100) {
    const where = this._sellerScopeWhere(filters);
    if (filters.paymentMode) where.paymentMode = filters.paymentMode;
    const and = [];
    if (filters.fromDate || filters.toDate) {
      const range = {};
      if (filters.fromDate) range.gte = new Date(filters.fromDate);
      if (filters.toDate) range.lte = new Date(filters.toDate);
      and.push({ OR: [{ rentedAt: range }, { returnedAt: range }] });
    }
    if (filters.search && filters.search.trim().length > 0) {
      const clean = this._sanitizeSearch(filters.search);
      and.push({
        OR: [
          { customer: { name: { contains: clean, mode: 'insensitive' } } },
          { seller: { userName: { contains: clean, mode: 'insensitive' } } },
          { seller: { shopName: { contains: clean, mode: 'insensitive' } } },
          { serialNumber: { contains: clean, mode: 'insensitive' } },
        ],
      });
    }
    if (and.length) where.AND = and;
    return prisma.batteryRent.findMany({
      where,
      include: {
        customer: true,
        seller: { select: { id: true, userName: true, shopName: true } },
      },
      orderBy: { rentedAt: 'desc' },
      take,
    });
  }
}

module.exports = new SalesRepository();
