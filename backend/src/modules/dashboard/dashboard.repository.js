const { Prisma } = require('@prisma/client');
const { prisma } = require('../../config/db');

function encodeActivityCursor(row) {
  return `${new Date(row.time).toISOString()}|${row.type}|${row.id}`;
}

function parseActivityCursor(raw) {
  if (!raw || typeof raw !== 'string') return null;
  const parts = raw.split('|');
  if (parts.length !== 3) return null;
  const time = new Date(parts[0]);
  if (Number.isNaN(time.getTime())) return null;
  return { time, type: parts[1], id: String(parts[2]) };
}

function formatCatalogActivity(e) {
  const who = e.actor?.shopName || e.actor?.userName || 'Admin';
  const name = e.productName?.name || e.payload?.name || 'product';
  const model = e.productModel?.name || e.payload?.name;
  const after = e.payload?.after;
  const before = e.payload?.before;
  let title;
  let subtitle = '';
  if (e.action === 'NAME_CREATED') {
    title = `${who} added product name`;
    subtitle = name;
  } else if (e.action === 'MODEL_CREATED') {
    title = `${who} added model`;
    subtitle = model ? `${name} • ${model}` : name;
  } else if (e.action === 'PRODUCT_CREATED') {
    title = `${who} configured product`;
    subtitle = [name, model, after ? `min ₹${after.min_price}` : null].filter(Boolean).join(' • ');
  } else {
    title = `${who} updated product`;
    const priceBit =
      before && after && before.min_price !== after.min_price
        ? `min ₹${before.min_price} → ₹${after.min_price}`
        : after
          ? `min ₹${after.min_price}`
          : 'pricing / units';
    subtitle = [name, model, priceBit].filter(Boolean).join(' • ');
  }
  return {
    type: 'catalog',
    title,
    subtitle,
    time: e.createdAt.toISOString(),
    icon: 'inventory_2'
  };
}

function formatOrgActivity(e) {
  const who = e.actor?.shopName || e.actor?.userName || 'Admin';
  const name = e.payload?.name || e.payload?.username || e.payload?.user_id || 'record';
  const place = e.payload?.location_name || e.payload?.shop_name;
  const job = e.payload?.job_title;
  const map = {
    SHOP_CREATED: { title: `${who} added shop`, subtitle: name, icon: 'store' },
    WAREHOUSE_CREATED: { title: `${who} added warehouse`, subtitle: name, icon: 'store' },
    SHOP_UPDATED: { title: `${who} updated shop`, subtitle: name, icon: 'store' },
    WAREHOUSE_UPDATED: { title: `${who} updated warehouse`, subtitle: name, icon: 'store' },
    ADMIN_CREATED: {
      title: `${who} created shop admin`,
      subtitle: [name, place].filter(Boolean).join(' • '),
      icon: 'person_add',
    },
    SELLER_CREATED: {
      title: `${who} added seller`,
      subtitle: [name, place].filter(Boolean).join(' • '),
      icon: 'person_add',
    },
    EMPLOYEE_CREATED: {
      title: `${who} added employee`,
      subtitle: [name, job, place].filter(Boolean).join(' • '),
      icon: 'person_add',
    },
    EMPLOYEE_TRANSFERRED: {
      title: `${who} moved employee`,
      subtitle: [name, place].filter(Boolean).join(' • '),
      icon: 'person_add',
    },
    ADMIN_TRANSFERRED: {
      title: `${who} moved admin`,
      subtitle: [name, place].filter(Boolean).join(' • '),
      icon: 'person_add',
    },
    USER_DEACTIVATED: { title: `${who} deactivated account`, subtitle: name, icon: 'person_off' },
    USER_ACTIVATED: { title: `${who} activated account`, subtitle: name, icon: 'person_add' },
  };
  const row = map[e.action] || {
    title: `${who} updated org`,
    subtitle: name,
    icon: 'person_add',
  };
  return {
    type: 'org',
    title: row.title,
    subtitle: row.subtitle,
    time: e.createdAt.toISOString(),
    icon: row.icon,
  };
}

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

    const soldToday = {
      soldAt: { gte: startOfToday, lte: endOfToday },
    };

    const [count, sumResult] = await Promise.all([
      prisma.salesTransaction.count({ where: soldToday }),
      prisma.salesTransaction.aggregate({
        _sum: { sellPrice: true },
        where: soldToday,
      }),
    ]);

    return {
      count,
      amount: Number(sumResult._sum.sellPrice || 0),
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
   * Shop admins under Super Admin hierarchy (role ADMIN).
   * @returns {Promise<number>}
   */
  async getTotalAdmins() {
    return prisma.user.count({
      where: {
        role: 'ADMIN',
      },
    });
  }

  /**
   * Active shops + warehouses.
   * @returns {Promise<number>}
   */
  async getTotalLocations() {
    return prisma.location.count({
      where: {
        isActive: true,
      },
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
    const catalogIds = rawActivities.filter(a => a.type === 'catalog').map(a => BigInt(a.id));
    const orgIds = rawActivities.filter(a => a.type === 'org').map(a => BigInt(a.id));

    const [shipments, sales, returns, catalogEvents, orgEvents] = await Promise.all([
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
      }) : Promise.resolve([]),
      catalogIds.length > 0 ? prisma.productCatalogEvent.findMany({
        where: { id: { in: catalogIds } },
        include: {
          actor: { select: { userName: true, shopName: true } },
          productName: { select: { name: true } },
          productModel: { select: { name: true } }
        }
      }) : Promise.resolve([]),
      orgIds.length > 0 ? prisma.orgEvent.findMany({
        where: { id: { in: orgIds } },
        include: {
          actor: { select: { userName: true, shopName: true } },
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
    const catalogMap = new Map(catalogEvents.map(e => [e.id.toString(), e]));
    const orgMap = new Map(orgEvents.map(e => [e.id.toString(), e]));

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
      } else if (raw.type === 'catalog') {
        const e = catalogMap.get(raw.id.toString());
        if (e) {
          activities.push(formatCatalogActivity(e));
        }
      } else if (raw.type === 'org') {
        const e = orgMap.get(raw.id.toString());
        if (e) {
          activities.push(formatOrgActivity(e));
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
      UNION ALL
      SELECT 'catalog' AS type, id, created_at AS time FROM product_catalog_events
      UNION ALL
      SELECT 'org' AS type, id, created_at AS time FROM org_events
      ORDER BY time DESC
      LIMIT 10 OFFSET 0
    `;

    return this._fetchActivityDetails(rawActivities);
  }

  /**
   * Cursor-paginated activities (newest first).
   * Cursor is opaque: `${isoTime}|${type}|${id}`
   * @param {{ cursor?: string|null, limit?: number, fromDate?: Date|null, toDate?: Date|null }} opts
   * @returns {Promise<{data: Array, nextCursor: string|null, hasNextPage: boolean}>}
   */
  async getActivityHistory({ cursor = null, limit = 20, fromDate = null, toDate = null } = {}) {
    const take = limit + 1;
    const parsed = parseActivityCursor(cursor);
    const feed = Prisma.sql`
      SELECT 'shipment' AS type, id, created_at AS time FROM shipments
      UNION ALL
      SELECT 'sale' AS type, id, sold_at AS time FROM sales_transactions
      UNION ALL
      SELECT 'return' AS type, id, created_at AS time FROM return_products
      UNION ALL
      SELECT 'catalog' AS type, id, created_at AS time FROM product_catalog_events
      UNION ALL
      SELECT 'org' AS type, id, created_at AS time FROM org_events
    `;
    const clauses = [];
    if (fromDate) clauses.push(Prisma.sql`time >= ${fromDate}`);
    if (toDate) clauses.push(Prisma.sql`time <= ${toDate}`);
    if (parsed) {
      clauses.push(Prisma.sql`(
        time < ${parsed.time}
        OR (time = ${parsed.time} AND (type, id::text) < (${parsed.type}, ${parsed.id}))
      )`);
    }
    const where = clauses.length
      ? Prisma.sql`WHERE ${Prisma.join(clauses, ' AND ')}`
      : Prisma.empty;

    const rawActivities = await prisma.$queryRaw`
      SELECT type, id, time FROM (${feed}) AS combined
      ${where}
      ORDER BY time DESC, type DESC, id DESC
      LIMIT ${take}
    `;

    const hasNextPage = rawActivities.length > limit;
    const pageRows = hasNextPage ? rawActivities.slice(0, limit) : rawActivities;
    const last = pageRows[pageRows.length - 1];
    const nextCursor = hasNextPage && last ? encodeActivityCursor(last) : null;
    const data = await this._fetchActivityDetails(pageRows);

    return { data, nextCursor, hasNextPage };
  }
}

module.exports = new DashboardRepository();
