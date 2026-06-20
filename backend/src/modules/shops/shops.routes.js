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
 *     responses:
 *       200:
 *         description: Sellers fetched successfully
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
 *     parameters:
 *       - in: path
 *         name: sellerId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Seller fetched successfully
 *       404:
 *         description: Seller not found
 */
router.get(
  '/sellers/:sellerId',
  authenticate,
  requireAdmin,
  validateRequest(viewSellerSchema),
  shopsController.viewSeller
);

module.exports = router;
