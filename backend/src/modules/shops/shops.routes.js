const express = require('express');
const router = express.Router();
const shopsController = require('./shops.controller');
const { viewSellerSchema, shopStaffSchema, viewEmployeeSchema } = require('./shops.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin } = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

/**
 * @swagger
 * tags:
 *   name: Shops
 *   description: Shops management
 */

/**
 * @swagger
 * /api/shops/sellers:
 *   get:
 *     summary: Return all sellers
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Sellers fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/SellersListResponse'
 *       401:
 *         description: Unauthorized
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       403:
 *         description: Admin only
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.get(
  '/sellers',
  authenticate,
  requireAdmin,
  shopsController.getSellers
);

/**
 * @swagger
 * /api/shops/sellers/{sellerId}:
 *   get:
 *     summary: Return one seller
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: sellerId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: query
 *         name: includeOutOfStock
 *         schema:
 *           type: boolean
 *     responses:
 *       200:
 *         description: Seller fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/SellerDetailResponse'
 *       404:
 *         description: Seller not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
/**
 * @swagger
 * /api/shops/sellers/{sellerId}/staff:
 *   get:
 *     summary: Sellers and employees at the same shop location as this seller
 *     description: |
 *       Admin only. Uses the seller's users.location_id.
 *       Returns only SELLER and EMPLOYEE users assigned to that location.
 *       Empty lists if seller has no location.
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: sellerId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Shop staff fetched
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ShopStaffResponse'
 *       404:
 *         description: Seller not found
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin only
 */
router.get(
  '/sellers/:sellerId/staff',
  authenticate,
  requireAdmin,
  validateRequest(shopStaffSchema),
  shopsController.getShopStaff
);

/**
 * @swagger
 * /api/shops/employees/{employeeId}:
 *   get:
 *     summary: Admin view one employee (profile + check-in/check-out only)
 *     description: |
 *       Admin only. Returns EMPLOYEE user profile and an `actions` timeline
 *       limited to CHECK_IN and CHECK_OUT (from employee_attendance).
 *       Does not include sales, inventory, or seller data.
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: employeeId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 50
 *           maximum: 100
 *         description: Max attendance rows to expand into actions
 *     responses:
 *       200:
 *         description: Employee profile + attendance actions
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AdminEmployeeDetailResponse'
 *       404:
 *         description: Employee not found (or user is not EMPLOYEE)
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin only
 */
router.get(
  '/employees/:employeeId',
  authenticate,
  requireAdmin,
  validateRequest(viewEmployeeSchema),
  shopsController.viewEmployee
);

router.get(
  '/sellers/:sellerId',
  authenticate,
  requireAdmin,
  validateRequest(viewSellerSchema),
  shopsController.viewSeller
);

module.exports = router;
