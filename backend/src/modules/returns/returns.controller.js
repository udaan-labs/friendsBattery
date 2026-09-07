const returnsService = require('./returns.service');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

class ReturnsController {
  async processReturn(req, res) {
    try {
      const result = await returnsService.processReturn(req.body, req.user);
      return successResponse(res, 201, 'Return processed successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Process Return Error:');
    }
  }

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
