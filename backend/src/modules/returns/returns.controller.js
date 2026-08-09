const returnsService = require('./returns.service');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

class ReturnsController {
  /**
   * Process a return request
   */
  async processReturn(req, res) {
    try {
      // Securely extract the seller ID from the authenticated user
      const sellerId = req.user.id;
      
      const result = await returnsService.processReturn(req.body, sellerId);
      
      return successResponse(res, 201, 'Return processed successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Process Return Error:');
    }
  }

  /**
   * Get return records
   */
  async getReturns(req, res) {
    try {
      const returns = await returnsService.getReturns(req.user);
      return successResponse(res, 200, 'Returns fetched successfully', returns);
    } catch (error) {
      return handleRouteError(res, error, 'Get Returns Error:');
    }
  }
}

module.exports = new ReturnsController();
