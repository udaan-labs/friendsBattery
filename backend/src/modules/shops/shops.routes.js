const express = require('express');
const router = express.Router();
const shopsController = require('./shops.controller');
const { viewSellerSchema } = require('./shops.validation');
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
router.get(
  '/sellers/:sellerId',
  authenticate,
  requireAdmin,
  validateRequest(viewSellerSchema),
  shopsController.viewSeller
);

module.exports = router;
