const express = require('express');
const router = express.Router();
const usersController = require('./users.controller');
const { listAccountsSchema, setActiveSchema } = require('./users.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireRole } = require('../../shared/middleware/role.middleware');
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
 *     description: Super Admin only. Inactive users cannot log in or use the API. Cannot change self or SUPER_ADMIN.
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
  requireRole(ROLES.SUPER_ADMIN),
  validateRequest(setActiveSchema),
  usersController.setActive
);

module.exports = router;
