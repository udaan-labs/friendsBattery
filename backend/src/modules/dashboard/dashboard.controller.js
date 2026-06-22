const dashboardService = require('./dashboard.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

class DashboardController {
  /**
   * Get all dashboard stats.
   */
  async getStats(req, res) {
    try {
      const stats = await dashboardService.getStats();
      return successResponse(res, 200, 'Dashboard stats retrieved successfully', stats);
    } catch (error) {
      console.error('Error in DashboardController.getStats:', error);
      return errorResponse(res, 500, 'Internal server error while fetching dashboard stats');
    }
  }

  /**
   * Get seller dashboard stats.
   */
  async getSellerStats(req, res) {
    try {
      const stats = await dashboardService.getSellerStats(req.user.id);
      return successResponse(res, 200, 'Seller dashboard stats retrieved successfully', stats);
    } catch (error) {
      console.error('Error in DashboardController.getSellerStats:', error);
      return errorResponse(res, 500, 'Internal server error while fetching seller dashboard stats');
    }
  }
}

module.exports = new DashboardController();
