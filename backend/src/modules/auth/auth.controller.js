const authService = require('./auth.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

class AuthController {
  async register(req, res) {
    try {
      const { user_id, username, user_number, shop_name, password, location_id } = req.body;
      const result = await authService.registerUser({
        user_id,
        username,
        user_number,
        shop_name,
        password,
        location_id,
      });
      return successResponse(res, 201, 'User registered successfully', result);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Registration Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  async login(req, res) {
    try {
      const { user_id, password, device_id, app_version, firebase_token } = req.body;
      const ip_address =
        req.headers['x-forwarded-for']?.toString().split(',')[0]?.trim() ||
        req.ip ||
        req.socket?.remoteAddress ||
        null;

      const result = await authService.loginUser({
        user_id,
        password,
        device_id,
        ip_address,
        app_version,
        firebase_token,
      });
      return successResponse(res, 200, 'Login successful', result);
    } catch (error) {
      if (error.statusCode === 401 || error.statusCode === 403) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Login Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  async logout(req, res) {
    try {
      const result = await authService.logoutUser({
        userId: req.user.id,
        role: req.user.role,
        sessionId: req.user.sessionId || req.body?.session_id,
      });
      return successResponse(res, 200, 'Logout successful', result);
    } catch (error) {
      console.error('Logout Error:', error);
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
