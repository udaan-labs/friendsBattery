const authService = require('./auth.service');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

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
        actor: req.user,
      });
      return successResponse(res, 201, 'User registered successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Registration Error:');
    }
  }

  async registerAdmin(req, res) {
    try {
      const { user_id, username, user_number, shop_name, password, location_id } = req.body;
      const result = await authService.registerAdmin({
        user_id,
        username,
        user_number,
        shop_name,
        password,
        location_id,
        actor: req.user,
      });
      return successResponse(res, 201, 'Admin created successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Register Admin Error:');
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
      return handleRouteError(res, error, 'Login Error:');
    }
  }

  async verifyLoginOtp(req, res) {
    try {
      const { challenge_id, otp } = req.body;
      const result = await authService.verifyLoginOtp({ challenge_id, otp });
      return successResponse(res, 200, 'Login successful', result);
    } catch (error) {
      return handleRouteError(res, error, 'Login OTP Error:');
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
      return handleRouteError(res, error, 'Logout Error:');
    }
  }

  async activate(req, res) {
    try {
      const { user_id, is_active, is_verified } = req.body;
      const result = await authService.activateUser({ user_id, is_active, is_verified });
      return successResponse(res, 200, 'User status updated successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Activate Error:');
    }
  }
}

module.exports = new AuthController();
