const authService = require('./auth.service');
const { loginSchema } = require('./auth.validation');
const { successResponse, errorResponse } = require('../../shared/utils/response');

const login = async (req, res) => {
  try {
    const parsedBody = loginSchema.safeParse(req.body);
    if (!parsedBody.success) {
      return errorResponse(res, 400, 'Validation Error', parsedBody.error.errors);
    }

    const { email, password } = parsedBody.data;
    const result = await authService.login(email, password);
    
    return successResponse(res, 200, 'Login successful', result);
  } catch (error) {
    if (error.message === 'Invalid email or password') {
      return errorResponse(res, 401, error.message);
    }
    console.error('Login error:', error);
    return errorResponse(res, 500, 'Internal server error');
  }
};

module.exports = { login };
