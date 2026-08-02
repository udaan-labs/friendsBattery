const shopsService = require('./shops.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

/**
 * Shops Controller
 *
 * Handles incoming shops HTTP requests.
 * Delegates business logic to ShopsService.
 * Does not contain business logic.
 */
class ShopsController {
  /**
   * Get all sellers.
   *
   * Controller responsibility:
   * - Receive HTTP request
   * - Delegate business logic to service
   * - Return standardized response
   */
  async getSellers(req, res) {
    try {
      // Call business layer
      const sellers = await shopsService.getSellers();

      // Return standardized success response
      return successResponse(res, 200, 'Sellers fetched successfully', sellers);
    } catch (error) {
      // Handle unexpected errors
      console.error('Get Sellers Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * View details of a single seller.
   *
   * Controller responsibility:
   * - Receive HTTP request
   * - Delegate business logic to service
   * - Return standardized response
   */
  async viewSeller(req, res) {
    try {
      const { sellerId } = req.params;
      const { includeOutOfStock } = req.query;

      // Call business layer
      const seller = await shopsService.viewSeller(Number(sellerId), includeOutOfStock);

      // Return standardized success response
      return successResponse(res, 200, 'Seller fetched successfully', seller);
    } catch (error) {
      // Handle unexpected errors
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('View Seller Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * GET /api/shops/sellers/:sellerId/staff
   * Sellers + employees at the same location as this seller.
   */
  async getShopStaff(req, res) {
    try {
      const { sellerId } = req.params;
      const data = await shopsService.getShopStaffBySellerId(Number(sellerId));
      return successResponse(res, 200, 'Shop staff fetched successfully', data);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Get Shop Staff Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * GET /api/shops/employees/:employeeId
   * Admin: employee profile + check-in / check-out actions only.
   */
  async viewEmployee(req, res) {
    try {
      const { employeeId } = req.params;
      const limit = req.query.limit != null ? Number(req.query.limit) : 50;
      const data = await shopsService.viewEmployee(Number(employeeId), { limit });
      return successResponse(res, 200, 'Employee fetched successfully', data);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('View Employee Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }
}

module.exports = new ShopsController();
