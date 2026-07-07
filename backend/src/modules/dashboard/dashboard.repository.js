const { prisma } = require('../../config/db');

class DashboardRepository {
  /**
   * Get the total count of stock items owned by Admin users only.
   * Seller-owned units and seller sales must NOT affect this count.
   * @returns {Promise<number>}
   */
  async getTotalStock() {
    return prisma.productUnit.count({
      where: {
        status: 'AVAILABLE',
        owner: {
          role: 'ADMIN'
        }
      }
    });
  }

  /**
   * Get the total count and revenue of items sold today.
   * @returns {Promise<{count: number, amount: number}>}
   */
  async getTodaySales() {
    const startOfToday = new Date();
    startOfToday.setHours(0, 0, 0, 0);

    const endOfToday = new Date();
    endOfToday.setHours(23, 59, 59, 999);

    const [count, sumResult] = await Promise.all([
      prisma.salesTransaction.count({
        where: {
          soldAt: {
            gte: startOfToday,
            lte: endOfToday
          }
        }
      }),
      prisma.salesTransaction.aggregate({
        _sum: { sellPrice: true },
        where: {
          soldAt: {
            gte: startOfToday,
            lte: endOfToday
          }
        }
      })
    ]);

    return {
      count,
      amount: Number(sumResult._sum.sellPrice || 0)
    };
  }

  /**
   * Count all users where isVerified = false.
   * @returns {Promise<number>}
   */
  async getPendingRequests() {
    return prisma.user.count({
      where: {
        isVerified: false
      }
    });
  }

  /**
   * Get the total number of users having the SELLER role.
   * @returns {Promise<number>}
   */
  async getTotalSellers() {
    return prisma.user.count({
      where: {
        role: 'SELLER'
      }
    });
  }

  /**
   * Get the total count of all stock items currently available in inventory for a specific seller.
   * @param {string|number|bigint} sellerId
   * @returns {Promise<number>}
   */
  async getSellerTotalStock(sellerId) {
    return prisma.productUnit.count({
      where: {
        ownerId: BigInt(sellerId),
        status: 'AVAILABLE'
      }
    });
  }

  /**
   * Get the total count and revenue of items sold today by a specific seller.
   * @param {string|number|bigint} sellerId
   * @returns {Promise<{count: number, amount: number}>}
   */
  async getSellerTodaySales(sellerId) {
    const startOfToday = new Date();
    startOfToday.setHours(0, 0, 0, 0);

    const endOfToday = new Date();
    endOfToday.setHours(23, 59, 59, 999);

    const [count, sumResult] = await Promise.all([
      prisma.salesTransaction.count({
        where: {
          sellerId: BigInt(sellerId),
          soldAt: {
            gte: startOfToday,
            lte: endOfToday
          }
        }
      }),
      prisma.salesTransaction.aggregate({
        _sum: { sellPrice: true },
        where: {
          sellerId: BigInt(sellerId),
          soldAt: {
            gte: startOfToday,
            lte: endOfToday
          }
        }
      })
    ]);

    return {
      count,
      amount: Number(sumResult._sum.sellPrice || 0)
    };
  }

  /**
   * Get the count of pending shipments for a specific seller.
   * @param {string|number|bigint} sellerId
   * @returns {Promise<number>}
   */
  async getSellerPendingShipmentsCount(sellerId) {
    return prisma.newShipment.count({
      where: {
        sellerId: BigInt(sellerId),
        status: 'PENDING'
      }
    });
  }

  /**
   * Get the 10 most recent sales made today for a specific seller.
   * @param {string|number|bigint} sellerId
   * @returns {Promise<Array>}
   */
  async getSellerRecentSales(sellerId) {
    const startOfToday = new Date();
    startOfToday.setHours(0, 0, 0, 0);
    const endOfToday = new Date();
    endOfToday.setHours(23, 59, 59, 999);

    const sales = await prisma.salesTransaction.findMany({
      where: {
        sellerId: BigInt(sellerId),
        soldAt: {
          gte: startOfToday,
          lte: endOfToday
        }
      },
      orderBy: { soldAt: 'desc' },
      take: 10,
      include: {
        customer: { select: { name: true } },
        product: { include: { productModel: true, productName: true } }
      }
    });

    return sales.map(s => ({
      id: Number(s.id),
      customerName: s.customer?.name || 'Unknown',
      productName: s.product?.productName?.name || 'Unknown',
      productModel: s.product?.productModel?.name || 'Unknown',
      serialNumber: s.serialNumber,
      sellPrice: Number(s.sellPrice),
      soldAt: s.soldAt
    }));
  }

  /**
   * Get the count of all PENDING shipments for Admin dashboard KPI.
   * Uses NewShipment (shipments table) — the active shipment flow.
   * @returns {Promise<number>}
   */
  async getPendingShipmentsAdmin() {
    return prisma.newShipment.count({
      where: { status: 'PENDING' }
    });
  }

  /**
   * Helper to fetch activity details given a list of raw activities (id and type).
   * @param {Array<{id: bigint, type: string, time: Date}>} rawActivities
   * @returns {Promise<Array>}
   */
  async _fetchActivityDetails(rawActivities) {
    if (!rawActivities || rawActivities.length === 0) return [];

    const shipmentIds = rawActivities.filter(a => a.type === 'shipment').map(a => BigInt(a.id));
    const saleIds = rawActivities.filter(a => a.type === 'sale').map(a => BigInt(a.id));
    const returnIds = rawActivities.filter(a => a.type === 'return').map(a => BigInt(a.id));

    const [shipments, sales, returns] = await Promise.all([
      shipmentIds.length > 0 ? prisma.newShipment.findMany({
        where: { id: { in: shipmentIds } },
        include: {
          seller: { select: { userName: true, shopName: true } },
          items: {
            take: 1,
            include: { product: { include: { productModel: true } } }
          }
        }
      }) : Promise.resolve([]),
      saleIds.length > 0 ? prisma.salesTransaction.findMany({
        where: { id: { in: saleIds } },
        include: {
          seller: { select: { userName: true, shopName: true } },
          product: { include: { productModel: true } },
          customer: { select: { name: true } }
        }
      }) : Promise.resolve([]),
      returnIds.length > 0 ? prisma.returnProduct.findMany({
        where: { id: { in: returnIds } },
        include: {
          returnBy: { select: { userName: true, shopName: true } },
          product: { include: { productModel: true } }
        }
      }) : Promise.resolve([])
    ]);

    // Map to rich activity objects
    const activities = [];

    // Map Shipments
    const shipmentsMap = new Map(shipments.map(s => [s.id.toString(), s]));
    // Map Sales
    const salesMap = new Map(sales.map(s => [s.id.toString(), s]));
    // Map Returns
    const returnsMap = new Map(returns.map(r => [r.id.toString(), r]));

    for (const raw of rawActivities) {
      if (raw.type === 'shipment') {
        const s = shipmentsMap.get(raw.id.toString());
        if (s) {
          activities.push({
            type: 'shipment',
            title: `Shipment ${s.shipmentNumber} → ${s.seller?.shopName || s.seller?.userName || 'Seller'}`,
            subtitle: `${s.items.length} item(s) • Status: ${s.status}`,
            time: s.createdAt.toISOString(),
            icon: 'local_shipping'
          });
        }
      } else if (raw.type === 'sale') {
        const s = salesMap.get(raw.id.toString());
        if (s) {
          activities.push({
            type: 'sale',
            title: `Sale by ${s.seller?.shopName || s.seller?.userName || 'Seller'}`,
            subtitle: `${s.product?.productModel?.name || 'Product'} • ₹${Number(s.sellPrice).toFixed(0)}`,
            time: s.soldAt.toISOString(),
            icon: 'point_of_sale'
          });
        }
      } else if (raw.type === 'return') {
        const r = returnsMap.get(raw.id.toString());
        if (r) {
          activities.push({
            type: 'return',
            title: `Return by ${r.returnBy?.shopName || r.returnBy?.userName || 'Seller'}`,
            subtitle: `${r.product?.productModel?.name || 'Product'} • Serial: ${r.serialNumber || 'N/A'}`,
            time: r.createdAt.toISOString(),
            icon: 'assignment_return'
          });
        }
      }
    }

    // Since rawActivities was already sorted by time DESC, returning them in the same order
    return activities;
  }

  /**
   * Get the 10 most recent activities (shipments, sales, returns combined).
   * @returns {Promise<Array>}
   */
  async getRecentActivity() {
    const rawActivities = await prisma.$queryRaw`
      SELECT 'shipment' AS type, id, created_at AS time FROM shipments
      UNION ALL
      SELECT 'sale' AS type, id, sold_at AS time FROM sales_transactions
      UNION ALL
      SELECT 'return' AS type, id, created_at AS time FROM return_products
      ORDER BY time DESC
      LIMIT 10 OFFSET 0
    `;

    return this._fetchActivityDetails(rawActivities);
  }

  /**
   * Get paginated activities.
   * @param {number} page
   * @param {number} limit
   * @returns {Promise<{data: Array, total: number}>}
   */
  async getActivityHistory(page = 1, limit = 20) {
    const offset = (page - 1) * limit;

    const [rawActivities, countResult] = await Promise.all([
      prisma.$queryRaw`
        SELECT 'shipment' AS type, id, created_at AS time FROM shipments
        UNION ALL
        SELECT 'sale' AS type, id, sold_at AS time FROM sales_transactions
        UNION ALL
        SELECT 'return' AS type, id, created_at AS time FROM return_products
        ORDER BY time DESC
        LIMIT ${limit} OFFSET ${offset}
      `,
      prisma.$queryRaw`
        SELECT COUNT(*) as total FROM (
          SELECT id FROM shipments
          UNION ALL
          SELECT id FROM sales_transactions
          UNION ALL
          SELECT id FROM return_products
        ) AS combined
      `
    ]);

    const data = await this._fetchActivityDetails(rawActivities);
    const total = countResult.length > 0 ? Number(countResult[0].total) : 0;

    return { data, total };
  }
}

module.exports = new DashboardRepository();
