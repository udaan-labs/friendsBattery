const dashboardRepository = require('./dashboard.repository');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');
const { parsePagination } = require('../../shared/utils/pagination');

class DashboardController {
  async getStats(req, res) {
    try {
      const [
        totalStock,
        todaySales,
        pendingRequests,
        totalSellers,
        pendingShipments,
        totalAdmins,
        totalLocations,
      ] = await Promise.all([
        dashboardRepository.getTotalStock(),
        dashboardRepository.getTodaySales(),
        dashboardRepository.getPendingRequests(),
        dashboardRepository.getTotalSellers(),
        dashboardRepository.getPendingShipmentsAdmin(),
        dashboardRepository.getTotalAdmins(),
        dashboardRepository.getTotalLocations(),
      ]);

      return successResponse(res, 200, 'Dashboard stats retrieved successfully', {
        totalStock,
        todaySales: todaySales.count,
        todaySalesAmount: todaySales.amount,
        pendingRequests,
        totalSellers,
        pendingShipments,
        totalAdmins,
        totalLocations,
      });
    } catch (error) {
      return handleRouteError(res, error, 'Error in DashboardController.getStats:');
    }
  }

  async getSellerStats(req, res) {
    try {
      const sellerId = req.user.id;
      const [totalStock, todaySales, pendingShipments, recentSales] = await Promise.all([
        dashboardRepository.getSellerTotalStock(sellerId),
        dashboardRepository.getSellerTodaySales(sellerId),
        dashboardRepository.getSellerPendingShipmentsCount(sellerId),
        dashboardRepository.getSellerRecentSales(sellerId),
      ]);

      return successResponse(res, 200, 'Seller dashboard stats retrieved successfully', {
        totalStock,
        todaySales: todaySales.count,
        todaySalesAmount: todaySales.amount,
        pendingShipments,
        recentSales,
      });
    } catch (error) {
      return handleRouteError(res, error, 'Error in DashboardController.getSellerStats:');
    }
  }

  async getRecentActivity(req, res) {
    try {
      const activity = await dashboardRepository.getRecentActivity();
      return successResponse(res, 200, 'Recent activity retrieved successfully', activity);
    } catch (error) {
      return handleRouteError(res, error, 'Error in DashboardController.getRecentActivity:');
    }
  }

  async getActivityHistory(req, res) {
    try {
      const { page, limit } = parsePagination(req.query, { defaultLimit: 20 });
      const { data, total } = await dashboardRepository.getActivityHistory(page, limit);

      const totalPages = Math.ceil(total / limit);
      const hasNextPage = page < totalPages;

      return res.status(200).json({
        success: true,
        data: data,
        pagination: {
          page,
          limit,
          totalItems: total,
          totalPages,
          hasNextPage,
        },
      });
    } catch (error) {
      return handleRouteError(res, error, 'Error in DashboardController.getActivityHistory:');
    }
  }
}

module.exports = new DashboardController();
