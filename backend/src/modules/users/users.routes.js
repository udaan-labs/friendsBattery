const express = require('express');
const router = express.Router();
const usersController = require('./users.controller');
const { listAccountsSchema, setActiveSchema, changePasswordSchema } = require('./users.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireRole, requireSuperAdminOrAdmin } = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');
const ROLES = require('../../shared/constants/roles');

/**
 * @swagger
 * tags:
 *   name: Users
 *   description: Super Admin account list and activate / deactivate
 */

/**
 * @swagger
 * /api/users:
 *   get:
 *     summary: List admins, sellers, and employees
 *     description: Super Admin only. Filter by ADMIN, SELLER, or EMPLOYEE.
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: role
 *         required: true
 *         schema:
 *           type: string
 *           enum: [ADMIN, SELLER, EMPLOYEE]
 *     responses:
 *       200:
 *         description: Users fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AccountUsersResponse'
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Super Admin only
 */
router.get(
  '/',
  authenticate,
  requireRole(ROLES.SUPER_ADMIN),
  validateRequest(listAccountsSchema),
  usersController.listAccounts
);

/**
 * @swagger
 * /api/users/{id}/active:
 *   patch:
 *     summary: Activate or deactivate an admin, seller, or employee
 *     description: Super Admin or Admin. Inactive users cannot log in or use the API. Cannot change self or out-of-scope accounts.
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/SetAccountActiveRequest'
 *     responses:
 *       200:
 *         description: User status updated successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/SetAccountActiveResponse'
 *       400:
 *         description: Validation error
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden
 *       404:
 *         description: User not found
 */


router.patch(
  '/:id/active',
  authenticate,
  requireSuperAdminOrAdmin,
  validateRequest(setActiveSchema),
  usersController.setActive
);

/**
 * @swagger
 * /api/users/{id}/password:
 *   patch:
 *     summary: Reset or change password for a seller or employee
 *     description: Super Admin or Admin. Super Admin can reset password for any account; Admin can reset for sellers/employees under their shop.
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/ChangePasswordRequest'
 *     responses:
 *       200:
 *         description: Password updated successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ChangePasswordResponse'
 *       400:
 *         description: Validation error
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden
 *       404:
 *         description: User not found
 */
router.patch(
  '/:id/password',
  authenticate,
  requireSuperAdminOrAdmin,
  validateRequest(changePasswordSchema),
  usersController.changePassword
);

module.exports = router;
