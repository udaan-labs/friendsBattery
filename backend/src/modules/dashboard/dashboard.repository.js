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
        status: 'IN_STOCK',
        owner: {
          role: 'ADMIN'
        }
      }
    });
  }

  /**
   * Get the total number of items sold today.
   * @returns {Promise<number>}
   */
  async getTodaySales() {
    const startOfToday = new Date();
    startOfToday.setHours(0, 0, 0, 0);

    const endOfToday = new Date();
    endOfToday.setHours(23, 59, 59, 999);

    return prisma.salesTransaction.count({
      where: {
        soldAt: {
          gte: startOfToday,
          lte: endOfToday
        }
      }
    });
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
        status: 'IN_STOCK'
      }
    });
  }

  /**
   * Get the total number of items sold today by a specific seller.
   * @param {string|number|bigint} sellerId
   * @returns {Promise<number>}
   */
  async getSellerTodaySales(sellerId) {
    const startOfToday = new Date();
    startOfToday.setHours(0, 0, 0, 0);

    const endOfToday = new Date();
    endOfToday.setHours(23, 59, 59, 999);

    return prisma.salesTransaction.count({
      where: {
        sellerId: BigInt(sellerId),
        soldAt: {
          gte: startOfToday,
          lte: endOfToday
        }
      }
    });
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
   * Get the 10 most recent activities (shipments + sales combined).
   * Uses NewShipment (shipments table) — the active shipment flow.
   * @returns {Promise<Array>}
   */
  async getRecentActivity() {
    const [recentShipments, recentSales] = await Promise.all([
      prisma.newShipment.findMany({
        take: 5,
        orderBy: { createdAt: 'desc' },
        include: {
          seller: { select: { userName: true, shopName: true } },
          items: {
            take: 1,
            include: {
              product: {
                include: { productModel: true }
              }
            }
          }
        }
      }),
      prisma.salesTransaction.findMany({
        take: 5,
        orderBy: { soldAt: 'desc' },
        include: {
          seller: { select: { userName: true, shopName: true } },
          product: {
            include: { productModel: true }
          },
          customer: { select: { name: true } }
        }
      })
    ]);

    const shipmentActivities = recentShipments.map(s => ({
      type: 'shipment',
      title: `Shipment ${s.shipmentNumber} → ${s.seller?.shopName || s.seller?.userName || 'Seller'}`,
      subtitle: `${s.items.length} item(s) • Status: ${s.status}`,
      time: s.createdAt.toISOString(),
      icon: 'local_shipping'
    }));

    const salesActivities = recentSales.map(s => ({
      type: 'sale',
      title: `Sale by ${s.seller?.shopName || s.seller?.userName || 'Seller'}`,
      subtitle: `${s.product?.productModel?.name || 'Product'} • ₹${Number(s.sellPrice).toFixed(0)}`,
      time: s.soldAt.toISOString(),
      icon: 'point_of_sale'
    }));

    // Merge and sort by time descending, take top 10
    return [...shipmentActivities, ...salesActivities]
      .sort((a, b) => new Date(b.time) - new Date(a.time))
      .slice(0, 10);
  }
}

module.exports = new DashboardRepository();
