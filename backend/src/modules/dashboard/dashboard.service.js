const dashboardRepository = require('./dashboard.repository');

class DashboardService {
  /**
   * Get all dashboard stats concurrently.
   * @returns {Promise<Object>}
   */
  async getStats() {
    const [totalStock, todaySales, pendingRequests, totalSellers] = await Promise.all([
      dashboardRepository.getTotalStock(),
      dashboardRepository.getTodaySales(),
      dashboardRepository.getPendingRequests(),
      dashboardRepository.getTotalSellers()
    ]);

    return {
      totalStock,
      todaySales,
      pendingRequests,
      totalSellers
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
}

module.exports = new DashboardService();
