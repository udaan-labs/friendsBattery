const usersService = require('./users.service');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

class UsersController {
  async listAccounts(req, res) {
    try {
      const data = await usersService.listAccounts(req.query.role);
      return successResponse(res, 200, 'Users fetched successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'List Accounts Error:');
    }
  }

  async setActive(req, res) {
    try {
      const data = await usersService.setActive(req.user, req.params.id, req.body.is_active);
      return successResponse(res, 200, 'User status updated successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Set Account Active Error:');
    }
  }
}

module.exports = new UsersController();
