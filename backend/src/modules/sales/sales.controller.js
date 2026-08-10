const salesService = require('./sales.service');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

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
      return handleRouteError(res, error, 'Create Sale Error:');
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
      return handleRouteError(res, error, 'Get Sales Error:');
    }
  }

  /**
   * Get sale details by transaction ID
   */
  async getSaleById(req, res) {
    try {
      const { transactionId } = req.params;
      const sale = await salesService.getSaleById(Number(transactionId), req.user);
      return successResponse(res, 200, 'Sale details fetched successfully', sale);
    } catch (error) {
      return handleRouteError(res, error, 'Get Sale By ID Error:');
    }
  }

  /**
   * Get sales history for a specific customer mobile
   */

  async getSalesHistory(req, res) {
    try {
      const sellerId = req.user.id;
      const query = req.query;
      const history = await salesService.getSalesHistory(sellerId, query);
      return successResponse(res, 200, 'Seller sales history fetched successfully', history);
    } catch (error) {
      return handleRouteError(res, error, 'Get Sales History Error:');
    }
  }

  /**
   * Get paginated sales history for Admin — all sellers, with shipment tracing
   */
  async getAdminSalesHistory(req, res) {
    try {
      const query = req.query;
      const history = await salesService.getAdminSalesHistory(query, req.user);
      return successResponse(res, 200, 'Admin sales history fetched successfully', history);
    } catch (error) {
      return handleRouteError(res, error, 'Get Admin Sales History Error:');
    }
  }
}

module.exports = new SalesController();
