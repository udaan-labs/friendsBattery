const { errorResponse } = require('../../shared/utils/response');
const { z } = require('zod');
const { strongPassword } = require('../../shared/utils/password');

// To match exact validation requirements while using Zod:
const registerSchema = z.object({
  user_id: z
    .string()
    .min(1)
    .refine((s) => !/\s/.test(s.trim()), { message: 'User ID cannot contain spaces' }),
  username: z.string().min(1),
  user_number: z.string().regex(/^\d{10}$/, 'Mobile number must be exactly 10 digits'),
  shop_name: z.string().min(1),
  password: strongPassword,
  /** Optional shop location — assign seller to an existing SHOP */
  location_id: z.coerce.number().int().positive().optional().nullable(),
});

const loginSchema = z.object({
  user_id: z.string().min(1),
  password: z.string().min(1),
  // Optional — used for employee_sessions on EMPLOYEE login
  device_id: z.string().optional(),
  app_version: z.string().optional(),
});

const activateSchema = z.object({
  user_id: z.string().min(1),
  is_active: z.boolean(),
  is_verified: z.boolean()
});

const registerSuperAdminSchema = z.object({
  user_id: z
    .string()
    .min(1)
    .refine((s) => !/\s/.test(s.trim()), { message: 'User ID cannot contain spaces' }),
  username: z.string().min(1),
  user_number: z.string().regex(/^\d{10}$/, 'Mobile number must be exactly 10 digits'),
  shop_name: z.string().optional().nullable(),
  password: strongPassword,
});

const validateRegister = (req, res, next) => {
  try {
    registerSchema.parse(req.body);
    next();
  } catch (error) {
    const msg = error.issues?.[0]?.message;
    return errorResponse(
      res,
      400,
      msg && (msg.includes('digits') || msg.includes('Password'))
        ? msg
        : 'user_id, username, user_number, shop_name and password are required',
    );
  }
};

const validateRegisterSuperAdmin = (req, res, next) => {
  try {
    registerSuperAdminSchema.parse(req.body);
    next();
  } catch (error) {
    const msg = error.issues?.[0]?.message;
    return errorResponse(
      res,
      400,
      msg && (msg.includes('digits') || msg.includes('Password') || msg.includes('spaces'))
        ? msg
        : 'user_id, username, user_number and password are required',
    );
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
  validateRegisterSuperAdmin,
  validateLogin,
  validateActivate,
};
