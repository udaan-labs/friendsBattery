const express = require('express');
const router = express.Router();
const authController = require('./auth.controller');
const { validateRegister, validateLogin, validateActivate } = require('./auth.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin } = require('../../shared/middleware/role.middleware');

/**
 * @swagger
 * /api/auth/register:
 *   post:
 *     summary: Register a new user
 *     tags: [Auth]
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
 *                 example: "9876543210"
 *               shop_name:
 *                 type: string
 *                 example: ABC Battery Store
 *               password:
 *                 type: string
 *                 format: password
 *                 example: password123
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
// Admin-only: no open self-register of active sellers
router.post('/register', authenticate, requireAdmin, validateRegister, authController.register);

/**
 * @swagger
 * /api/auth/login:
 *   post:
 *     summary: Authenticate user and return token
 *     description: |
 *       Works for ADMIN, SELLER, and EMPLOYEE.
 *       EMPLOYEE login may include location / employee_role on user and session_id (employee_sessions).
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
router.put('/activate', authenticate, requireAdmin, validateActivate, authController.activate);

module.exports = router;
