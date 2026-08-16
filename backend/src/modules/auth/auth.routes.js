const express = require('express');
const router = express.Router();
const authController = require('./auth.controller');
const {
  validateRegister,
  validateLogin,
  validateActivate,
  validateVerifyLoginOtp,
} = require('./auth.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const {
  requireSuperAdminOrAdmin,
  requireRole,
} = require('../../shared/middleware/role.middleware');
const ROLES = require('../../shared/constants/roles');

/**
 * @swagger
 * /api/auth/register:
 *   post:
 *     summary: Register a new seller
 *     tags: [Auth]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - user_id
 *               - username
 *               - user_number
 *               - shop_name
 *               - password
 *             properties:
 *               user_id:
 *                 type: string
 *                 example: SELLER001
 *               username:
 *                 type: string
 *                 example: seller123
 *               user_number:
 *                 type: string
 *                 pattern: '^\\d{10}$'
 *                 description: Exactly 10 digits
 *                 example: "9876543210"
 *               shop_name:
 *                 type: string
 *                 example: ABC Battery Store
 *               password:
 *                 type: string
 *                 format: password
 *                 example: password123
 *               location_id:
 *                 type: integer
 *                 description: Optional SHOP location id (assign seller to a shop)
 *                 example: 2
 *     responses:
 *       201:
 *         description: User registered successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/RegisterResponse'
 *       400:
 *         description: Username, password and shop name are required
 *       409:
 *         description: Username already exists
 */
// Super Admin or Admin: no open self-register of active sellers
router.post('/register', authenticate, requireSuperAdminOrAdmin, validateRegister, authController.register);

/**
 * @swagger
 * /api/auth/register-admin:
 *   post:
 *     summary: Super Admin creates a shop or warehouse Admin
 *     description: |
 *       SUPER_ADMIN only. Creates role ADMIN with parent_id = Super Admin.
 *       New admin is active and verified (can log in immediately).
 *       Optional location_id must be an active SHOP or WAREHOUSE.
 *     tags: [Auth]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - user_id
 *               - username
 *               - user_number
 *               - shop_name
 *               - password
 *             properties:
 *               user_id:
 *                 type: string
 *                 example: ADMIN001
 *               username:
 *                 type: string
 *                 example: shop_admin
 *               user_number:
 *                 type: string
 *                 pattern: '^\\d{10}$'
 *                 description: Exactly 10 digits
 *                 example: "9876543211"
 *               shop_name:
 *                 type: string
 *                 example: Main Shop Admin
 *               password:
 *                 type: string
 *                 format: password
 *               location_id:
 *                 type: integer
 *                 description: Optional SHOP or WAREHOUSE location for this admin
 *                 example: 2
 *     responses:
 *       201:
 *         description: Admin created successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/RegisterResponse'
 *       403:
 *         description: Only Super Admin
 *       409:
 *         description: User id / username / number already exists
 */
router.post(
  '/register-admin',
  authenticate,
  requireRole(ROLES.SUPER_ADMIN),
  validateRegister,
  authController.registerAdmin
);

/**
 * @swagger
 * /api/auth/login:
 *   post:
 *     summary: Login with User ID and password
 *     description: |
 *       Password login for SUPER_ADMIN, ADMIN, SELLER, EMPLOYEE. Returns JWT.
 *       OTP step is deferred.
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - user_id
 *               - password
 *             properties:
 *               user_id:
 *                 type: string
 *                 example: EMP001
 *               password:
 *                 type: string
 *                 format: password
 *                 example: password123
 *               device_id:
 *                 type: string
 *                 description: Optional — stored on employee_sessions for EMPLOYEE
 *               ip_address:
 *                 type: string
 *               app_version:
 *                 type: string
 *               firebase_token:
 *                 type: string
 *     responses:
 *       200:
 *         description: Login successful
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/LoginResponse'
 *       400:
 *         description: Validation Error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       401:
 *         description: Invalid Credentials
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       403:
 *         description: Inactive / Unverified Account
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.post('/login', validateLogin, authController.login);

/**
 * @swagger
 * /api/auth/verify-otp:
 *   post:
 *     summary: Complete login with OTP
 *     description: Exchange login OTP challenge for auth_id / auth_key.
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [challenge_id, otp]
 *             properties:
 *               challenge_id:
 *                 type: string
 *               otp:
 *                 type: string
 *                 example: "123456"
 *     responses:
 *       200:
 *         description: Login successful
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/LoginResponse'
 *       401:
 *         description: Invalid / expired OTP
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.post('/verify-otp', validateVerifyLoginOtp, authController.verifyLoginOtp);

/**
 * @swagger
 * /api/auth/logout:
 *   post:
 *     summary: End session (closes employee_sessions for EMPLOYEE)
 *     tags: [Auth]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Logout successful
 *       401:
 *         description: Unauthorized
 */
router.post('/logout', authenticate, authController.logout);

/**
 * @swagger
 * /api/auth/activate:
 *   put:
 *     summary: Activate and verify a user account
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - user_id
 *               - is_active
 *               - is_verified
 *             properties:
 *               user_id:
 *                 type: string
 *                 example: SELLER001
 *               is_active:
 *                 type: boolean
 *                 example: true
 *               is_verified:
 *                 type: boolean
 *                 example: true
 *     responses:
 *       200:
 *         description: User status updated successfully
 *       400:
 *         description: Validation Error
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden
 *       404:
 *         description: Invalid User ID
 */
router.put('/activate', authenticate, requireSuperAdminOrAdmin, validateActivate, authController.activate);

module.exports = router;
