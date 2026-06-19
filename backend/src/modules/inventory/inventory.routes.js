const express = require('express');
const router = express.Router();
const inventoryController = require('./inventory.controller');
const { 
  getInventorySchema, 
  getInventoryItemSchema, 
  adjustInventorySchema, 
  transferInventorySchema, 
  getHistorySchema 
} = require('./inventory.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin } = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

/**
 * @swagger
 * tags:
 *   name: Inventory
 *   description: Inventory management
 */

/**
 * @swagger
 * /api/inventory:
 *   get:
 *     summary: Return logged-in user's inventory
 *     tags: [Inventory]
 *     parameters:
 *       - in: query
 *         name: search
 *         schema:
 *           type: string
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Inventory fetched successfully
 */
router.get(
  '/', 
  authenticate, 
  validateRequest(getInventorySchema), 
  inventoryController.getInventory
);

/**
 * @swagger
 * /api/inventory/history:
 *   get:
 *     summary: Return inventory movement history
 *     tags: [Inventory]
 *     parameters:
 *       - in: query
 *         name: from_date
 *         schema:
 *           type: string
 *           format: date
 *       - in: query
 *         name: to_date
 *         schema:
 *           type: string
 *           format: date
 *       - in: query
 *         name: product_id
 *         schema:
 *           type: integer
 *       - in: query
 *         name: seller_id
 *         schema:
 *           type: integer
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Inventory history fetched successfully
 */
router.get(
  '/history', 
  authenticate, 
  validateRequest(getHistorySchema), 
  inventoryController.getHistory
);

/**
 * @swagger
 * /api/inventory/{productId}:
 *   get:
 *     summary: Return one inventory item
 *     tags: [Inventory]
 *     parameters:
 *       - in: path
 *         name: productId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Inventory item fetched successfully
 *       404:
 *         description: Inventory item not found
 */
router.get(
  '/:productId', 
  authenticate, 
  validateRequest(getInventoryItemSchema), 
  inventoryController.getInventoryItem
);

/**
 * @swagger
 * /api/inventory/adjust:
 *   patch:
 *     summary: Adjust inventory stock levels
 *     tags: [Inventory]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - product_id
 *               - user_id
 *               - adjustment_quantity
 *             properties:
 *               product_id:
 *                 type: integer
 *               user_id:
 *                 type: integer
 *               adjustment_quantity:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Inventory adjusted successfully
 *       400:
 *         description: Not enough stock to decrease
 */
router.patch(
  '/adjust', 
  authenticate, 
  requireAdmin, 
  validateRequest(adjustInventorySchema), 
  inventoryController.adjustInventory
);

/**
 * @swagger
 * /api/inventory/transfer:
 *   post:
 *     summary: Transfer inventory from admin to seller
 *     tags: [Inventory]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - seller_id
 *               - products
 *             properties:
 *               seller_id:
 *                 type: integer
 *               products:
 *                 type: array
 *                 items:
 *                   type: object
 *                   properties:
 *                     product_id:
 *                       type: integer
 *                     quantity:
 *                       type: integer
 *     responses:
 *       200:
 *         description: Inventory transferred successfully
 *       400:
 *         description: Invalid seller or insufficient stock
 */
router.post(
  '/transfer', 
  authenticate, 
  requireAdmin, 
  validateRequest(transferInventorySchema), 
  inventoryController.transferInventory
);

module.exports = router;
