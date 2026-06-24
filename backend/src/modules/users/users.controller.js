const userService = require('./users.service');
const { successResponse } = require('../../shared/utils/response');

/**
 * Get list of users with optional role filtering.
 */
const getUsers = async (req, res, next) => {
  try {
    const { role } = req.query;
    const users = await userService.getAllUsers(role);
    return successResponse(res, 200, 'Users fetched successfully', users);
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getUsers
};
