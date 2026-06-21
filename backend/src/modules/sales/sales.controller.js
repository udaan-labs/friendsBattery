const salesService = require('./sales.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

/**
 * Sales Controller
 *
 * Handles HTTP requests for the sales module.
 * Delegates all business logic to the service layer.
 */
class SalesController {
  /**
   * Create a new sale transaction
   */
  async createSale(req, res) {
    try {
      // Pass the authenticated user ID safely
      // Never trust frontend seller id, always use req.user.id
      const sellerId = req.user.id;
      const result = await salesService.createSale(req.body, sellerId);
      
      return successResponse(res, 201, 'Sale transaction created successfully', result);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Create Sale Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Get all sales
   * Filters automatically based on authenticated user role (Admin vs Seller)
   */
  async getSales(req, res) {
    try {
      const sales = await salesService.getSales(req.user);
      return successResponse(res, 200, 'Sales fetched successfully', sales);
    } catch (error) {
      console.error('Get Sales Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Get sale details by transaction ID
   */
  async getSaleById(req, res) {
    try {
      const { transactionId } = req.params;
      const sale = await salesService.getSaleById(Number(transactionId));
      return successResponse(res, 200, 'Sale details fetched successfully', sale);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Get Sale By ID Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Get sales history for a specific customer mobile
   */
  async getCustomerHistory(req, res) {
    try {
      const { mobile } = req.params;
      const history = await salesService.getCustomerHistory(mobile);
      return successResponse(res, 200, 'Customer history fetched successfully', history);
    } catch (error) {
      console.error('Get Customer History Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }
}

module.exports = new SalesController();
