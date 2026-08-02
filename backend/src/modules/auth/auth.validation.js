const { errorResponse } = require('../../shared/utils/response');
const { z } = require('zod');

// To match exact validation requirements while using Zod:
const registerSchema = z.object({
  user_id: z.string().min(1),
  username: z.string().min(1),
  user_number: z.string().min(1),
  shop_name: z.string().min(1),
  password: z.string().min(1)
});

const loginSchema = z.object({
  user_id: z.string().min(1),
  password: z.string().min(1),
  // Optional — used for employee_sessions on EMPLOYEE login
  device_id: z.string().optional(),
  app_version: z.string().optional(),
  firebase_token: z.string().optional(),
});

const activateSchema = z.object({
  user_id: z.string().min(1),
  is_active: z.boolean(),
  is_verified: z.boolean()
});

const validateRegister = (req, res, next) => {
  try {
    registerSchema.parse(req.body);
    next();
  } catch (error) {
    return errorResponse(res, 400, 'user_id, username, user_number, shop_name and password are required');
  }
};

const validateLogin = (req, res, next) => {
  try {
    loginSchema.parse(req.body);
    next();
  } catch (error) {
    return errorResponse(res, 400, 'user_id and password are required');
  }
};

const validateActivate = (req, res, next) => {
  try {
    activateSchema.parse(req.body);
    next();
  } catch (error) {
    return errorResponse(res, 400, 'user_id, is_active (boolean), and is_verified (boolean) are required');
  }
};

module.exports = {
  validateRegister,
  validateLogin,
  validateActivate
};
