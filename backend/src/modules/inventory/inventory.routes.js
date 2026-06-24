const express = require('express');
const router = express.Router();
const inventoryController = require('./inventory.controller');
const { 
  getInventorySchema, 
  getInventoryItemSchema, 
  adjustInventorySchema, 
  transferInventorySchema, 
  getHistorySchema,
  updateStockSchema,
  getProductDetailsSchema,
  getAvailableSerialsSchema,
  getInventoryDetailsSchema
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
 * /api/inventory/details:
 *   get:
 *     summary: Return a complete inventory summary grouped by Category, Subcategory, and Product Name
 *     tags: [Inventory]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: category_id
 *         schema:
 *           type: integer
 *         description: Filter by Category ID
 *       - in: query
 *         name: subcategory_id
 *         schema:
 *           type: integer
 *         description: Filter by Subcategory (Product Name) ID
 *       - in: query
 *         name: search
 *         schema:
 *           type: string
 *         description: Search by Product Model Name or Product Name
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           default: 1
 *         description: Page number for pagination
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 10
 *         description: Number of items per page
 *     responses:
 *       200:
 *         description: Inventory details summary fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 message:
 *                   type: string
 *                   example: Inventory details fetched successfully
 *                 data:
 *                   type: object
 *                   properties:
 *                     categories:
 *                       type: array
 *                       items:
 *                         type: object
 *                         properties:
 *                           categoryId:
 *                             type: integer
 *                           categoryName:
 *                             type: string
 *                           totalProducts:
 *                             type: integer
 *                           totalInventory:
 *                             type: integer
 *                           subcategories:
 *                             type: array
 *                             items:
 *                               type: object
 *                               properties:
 *                                 subcategoryId:
 *                                   type: integer
 *                                 subcategoryName:
 *                                   type: string
 *                                 totalProducts:
 *                                   type: integer
 *                                 totalInventory:
 *                                   type: integer
 *                                 products:
 *                                   type: array
 *                                   items:
 *                                     type: object
 *                                     properties:
 *                                       productId:
 *                                         type: integer
 *                                       productName:
 *                                         type: string
 *                                       totalQuantity:
 *                                         type: integer
 *                                       soldQuantity:
 *                                         type: integer
 *                                       remainingQuantity:
 *                                         type: integer
 *                     pagination:
 *                       type: object
 *                       properties:
 *                         total:
 *                           type: integer
 *                         page:
 *                           type: integer
 *                         limit:
 *                           type: integer
 *                         total_pages:
 *                           type: integer
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Internal server error
 */
router.get(
  '/details',
  authenticate,
  validateRequest(getInventoryDetailsSchema),
  inventoryController.getInventoryDetails
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
 * /api/inventory/product-details:
 *   get:
 *     summary: Fetch details of a product (stock count & min sell price) by category, product name, and model IDs
 *     tags: [Inventory]
 *     parameters:
 *       - in: query
 *         name: category_id
 *         required: true
 *         schema:
 *           type: string
 *       - in: query
 *         name: product_name_id
 *         required: true
 *         schema:
 *           type: string
 *       - in: query
 *         name: product_model_id
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Product details fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 data:
 *                   type: object
 *                   properties:
 *                     productId:
 *                       type: integer
 *                     currentStock:
 *                       type: integer
 *                     minSellPrice:
 *                       type: number
 */
router.get(
  '/product-details',
  authenticate,
  validateRequest(getProductDetailsSchema),
  inventoryController.getProductDetails
);

/**
 * @swagger
 * /api/inventory/available-serials:
 *   get:
 *     summary: Fetch available serial numbers for a product owned by the logged-in seller
 *     tags: [Inventory]
 *     parameters:
 *       - in: query
 *         name: category_id
 *         required: true
 *         schema:
 *           type: string
 *       - in: query
 *         name: product_name_id
 *         required: true
 *         schema:
 *           type: string
 *       - in: query
 *         name: product_model_id
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Available serials fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 data:
 *                   type: array
 *                   items:
 *                     type: string
 */
router.get(
  '/available-serials',
  authenticate,
  validateRequest(getAvailableSerialsSchema),
  inventoryController.getAvailableSerials
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
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 data:
 *                   type: object
 *                   properties:
 *                     product_id:
 *                       type: integer
 *                     category:
 *                       type: string
 *                     brand:
 *                       type: string
 *                     model:
 *                       type: string
 *                     quantity:
 *                       type: integer
 *                     min_price:
 *                       type: number
 *                     offer_price:
 *                       type: number
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

/**
 * @swagger
 * /api/inventory/update-stock:
 *   post:
 *     summary: Update admin's own inventory stock (Admin only)
 *     tags: [Inventory]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - productCategoryId
 *               - productNameId
 *               - productModelId
 *               - quantity
 *             properties:
 *               productCategoryId:
 *                 type: integer
 *                 example: 1
 *               productNameId:
 *                 type: integer
 *                 example: 10
 *               productModelId:
 *                 type: integer
 *                 example: 25
 *               quantity:
 *                 type: integer
 *                 example: 50
 *               minSellPrice:
 *                 type: number
 *                 example: 1200
 *     responses:
 *       200:
 *         description: Stock updated successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 message:
 *                   type: string
 *                   example: Stock updated successfully
 *                 data:
 *                   type: object
 *                   properties:
 *                     productCategoryId:
 *                       type: integer
 *                       example: 1
 *                     productNameId:
 *                       type: integer
 *                       example: 10
 *                     productModelId:
 *                       type: integer
 *                       example: 25
 *                     quantity:
 *                       type: integer
 *                       example: 125
 *                     minSellPrice:
 *                       type: number
 *                       example: 1200
 *       400:
 *         description: Invalid request payload
 *       404:
 *         description: Category, product name, or product model not found
 */
router.post(
  '/update-stock',
  authenticate,
  requireAdmin,
  validateRequest(updateStockSchema),
  inventoryController.updateStock
);
module.exports = router;
