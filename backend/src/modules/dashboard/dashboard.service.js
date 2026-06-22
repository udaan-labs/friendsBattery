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
}

module.exports = new DashboardService();
