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
      todaySales: todaySales.count,
      todaySalesAmount: todaySales.amount,
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
    const [totalStock, todaySales, pendingShipments, recentSales] = await Promise.all([
      dashboardRepository.getSellerTotalStock(sellerId),
      dashboardRepository.getSellerTodaySales(sellerId),
      dashboardRepository.getSellerPendingShipmentsCount(sellerId),
      dashboardRepository.getSellerRecentSales(sellerId)
    ]);

    return {
      totalStock,
      todaySales: todaySales.count,
      todaySalesAmount: todaySales.amount,
      pendingShipments,
      recentSales
    };
  }

  /**
   * Get recent activity feed.
   * @returns {Promise<Array>}
   */
  async getRecentActivity() {
    return dashboardRepository.getRecentActivity();
  }

  /**
   * Get paginated activity history.
   * @param {number} page
   * @param {number} limit
   * @returns {Promise<{data: Array, total: number}>}
   */
  async getActivityHistory(page, limit) {
    return dashboardRepository.getActivityHistory(page, limit);
  }
}

module.exports = new DashboardService();
