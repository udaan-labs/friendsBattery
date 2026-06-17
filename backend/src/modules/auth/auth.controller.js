const authService = require('./auth.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

class AuthController {
  async register(req, res) {
    try {
      const { user_id, username, user_number, shop_name, password } = req.body;
      const result = await authService.registerUser({ user_id, username, user_number, shop_name, password });
      return successResponse(res, 201, 'User registered successfully', result);
    } catch (error) {
      if (error.statusCode === 409) {
        return errorResponse(res, 409, error.message);
      }
      console.error('Registration Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  async login(req, res) {
    try {
      const { user_id, password } = req.body;
      const result = await authService.loginUser({ user_id, password });
      return successResponse(res, 200, 'Login successful', result);
    } catch (error) {
      if (error.statusCode === 401 || error.statusCode === 403) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Login Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  async activate(req, res) {
    try {
      const { user_id, is_active, is_verified } = req.body;
      const result = await authService.activateUser({ user_id, is_active, is_verified });
      return successResponse(res, 200, 'User status updated successfully', result);
    } catch (error) {
      if (error.statusCode === 404) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Activate Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }
}

module.exports = new AuthController();
