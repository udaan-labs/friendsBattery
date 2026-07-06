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

  /**
   * Get recent activity feed (Admin only).
   */
  async getRecentActivity(req, res) {
    try {
      const activity = await dashboardService.getRecentActivity();
      return successResponse(res, 200, 'Recent activity retrieved successfully', activity);
    } catch (error) {
      console.error('Error in DashboardController.getRecentActivity:', error);
      return errorResponse(res, 500, 'Internal server error while fetching recent activity');
    }
  }

  /**
   * Get paginated activity history (Admin only).
   */
  async getActivityHistory(req, res) {
    try {
      const page = parseInt(req.query.page, 10) || 1;
      const limit = parseInt(req.query.limit, 10) || 20;

      const { data, total } = await dashboardService.getActivityHistory(page, limit);
      
      const totalPages = Math.ceil(total / limit);
      const hasNextPage = page < totalPages;

      // Returning directly to match requested structure or nested under data depending on standard
      return res.status(200).json({
        success: true,
        data: data,
        pagination: {
          page,
          limit,
          totalItems: total,
          totalPages,
          hasNextPage
        }
      });
    } catch (error) {
      console.error('Error in DashboardController.getActivityHistory:', error);
      return errorResponse(res, 500, 'Internal server error while fetching activity history');
    }
  }
}

module.exports = new DashboardController();
