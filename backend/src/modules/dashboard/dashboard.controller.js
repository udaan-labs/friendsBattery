const dashboardRepository = require('./dashboard.repository');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

function parseQueryDate(value) {
  if (typeof value !== 'string' || !value) return null;
  const d = new Date(value);
  return Number.isNaN(d.getTime()) ? null : d;
}

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
      const limit = Math.min(50, Math.max(1, parseInt(req.query.limit, 10) || 20));
      const cursor = typeof req.query.cursor === 'string' ? req.query.cursor : null;
      const fromDate = parseQueryDate(req.query.from_date);
      const toDate = parseQueryDate(req.query.to_date);
      const { data, nextCursor, hasNextPage } = await dashboardRepository.getActivityHistory({
        cursor,
        limit,
        fromDate,
        toDate,
      });

      return res.status(200).json({
        success: true,
        message: 'Activity history retrieved successfully',
        data,
        pagination: {
          limit,
          nextCursor,
          hasNextPage,
        },
      });
    } catch (error) {
      return handleRouteError(res, error, 'Error in DashboardController.getActivityHistory:');
    }
  }
}

module.exports = new DashboardController();
