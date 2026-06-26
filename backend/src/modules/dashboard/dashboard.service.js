const dashboardRepository = require('./dashboard.repository');

class DashboardService {
  /**
   * Get all dashboard stats concurrently.
   * @returns {Promise<Object>}
   */
  async getStats() {
    const [totalStock, todaySales, pendingRequests, totalSellers, pendingShipments] = await Promise.all([
      dashboardRepository.getTotalStock(),
      dashboardRepository.getTodaySales(),
      dashboardRepository.getPendingRequests(),
      dashboardRepository.getTotalSellers(),
      dashboardRepository.getPendingShipmentsAdmin()
    ]);

    return {
      totalStock,
      todaySales,
      pendingRequests,
      totalSellers,
      pendingShipments
    };
  }

  /**
   * Get seller dashboard stats concurrently.
   * @param {string|number|bigint} sellerId
   * @returns {Promise<Object>}
   */
  async getSellerStats(sellerId) {
    const [totalStock, todaySales, pendingShipments] = await Promise.all([
      dashboardRepository.getSellerTotalStock(sellerId),
      dashboardRepository.getSellerTodaySales(sellerId),
      dashboardRepository.getSellerPendingShipmentsCount(sellerId)
    ]);

    return {
      totalStock,
      todaySales,
      pendingShipments
    };
  }

  /**
   * Get recent activity feed.
   * @returns {Promise<Array>}
   */
  async getRecentActivity() {
    return dashboardRepository.getRecentActivity();
  }
}

module.exports = new DashboardService();
