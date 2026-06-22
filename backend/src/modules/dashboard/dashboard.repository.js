const { prisma } = require('../../config/db');

class DashboardRepository {
  /**
   * Get the total count of all stock items currently available in inventory.
   * @returns {Promise<number>}
   */
  async getTotalStock() {
    return prisma.productUnit.count({
      where: {
        status: 'IN_STOCK'
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
}

module.exports = new DashboardRepository();
