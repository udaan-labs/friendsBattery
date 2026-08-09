const appService = require('./app.service');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

class AppController {
  async getStatus(req, res) {
    try {
      const data = appService.getStatus();
      return successResponse(res, 200, 'App status retrieved successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Error in AppController.getStatus:');
    }
  }
}

module.exports = new AppController();
