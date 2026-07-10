const returnsService = require('./returns.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

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
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Process Return Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }
}

module.exports = new ReturnsController();
