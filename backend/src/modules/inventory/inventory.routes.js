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
const {
  requireAdmin,
  requireAdminOrSeller,
  requireAdminOrSellerOrEmployee,
} = require('../../shared/middleware/role.middleware');
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
 *     description: |
 *       Scope by role (unit inventory):
 *       - ADMIN: units owned by admin users
 *       - SELLER: units where owner_id = seller
 *       - EMPLOYEE: units where current_location_id = employee.location_id
 *       Employee with no location_id gets an empty list.
 *       Optional `location_id` (SUPER_ADMIN / ADMIN only): available units at that
 *       location (`current_location_id`). Seller/Employee query is ignored.
 *     tags: [Inventory]
 *     security:
 *       - bearerAuth: []
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
 *       - in: query
 *         name: includeOutOfStock
 *         schema:
 *           type: boolean
 *       - in: query
 *         name: location_id
 *         description: SA/Admin only. Physical stock at this shop or warehouse.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Inventory fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/InventoryListResponse'
 *       401:
 *         description: Unauthorized
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
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
 *     summary: Return a complete inventory summary grouped by Product Name and Product Model
 *     tags: [Inventory]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: product_name_id
 *         schema:
 *           type: integer
 *         description: Filter by Product Name ID
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
 *                 message:
 *                   type: string
 *                 data:
 *                   type: object
 *                   properties:
 *                     categories:
 *                       type: array
 *                       items:
 *                         type: object
 *                         properties:
 *                           categoryId: { type: 'string' }
 *                           categoryName: { type: 'string' }
 *                           subcategories:
 *                             type: array
 *                             items:
 *                               type: object
 *                               properties:
 *                                 subcategoryName: { type: 'string' }
 *                                 products:
 *                                   type: array
 *                                   items:
 *                                     type: object
 *                                     properties:
 *                                       productName: { type: 'string' }
 *                                       totalQuantity: { type: 'integer' }
 *                                       soldQuantity: { type: 'integer' }
 *                                       remainingQuantity: { type: 'integer' }
 *                     pagination:
 *                       type: object
 *                       properties:
 *                         total: { type: 'integer' }
 *                         page: { type: 'integer' }
 *                         limit: { type: 'integer' }
 *                         totalPages: { type: 'integer' }
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
 *     summary: Fetch details of a product (stock count & min sell price) by product name and model IDs
 *     tags: [Inventory]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: product_name_id
 *         required: true
 *         schema:
 *           type: integer
 *       - in: query
 *         name: product_model_id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Product details fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ProductStockDetailsResponse'
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
 *     summary: Fetch available serial numbers for a product owned by the authenticated user
 *     tags: [Inventory]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: product_name_id
 *         required: true
 *         schema:
 *           type: integer
 *       - in: query
 *         name: product_model_id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Available serials fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AvailableSerialsResponse'
 *       401:
 *         description: Unauthorized
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.get(
  '/available-serials',
  authenticate,
  validateRequest(getAvailableSerialsSchema),
  inventoryController.getAvailableSerials
);

/**
 * @swagger
 * /api/inventory/scan-for-sale:
 *   get:
 *     summary: Scan serial for sale (owner stock; EMPLOYEE = location stock)
 *     tags: [Inventory]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: serial_number
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Product found successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ScanForSaleResponse'
 *       400:
 *         description: Employee has no shop location
 *       404:
 *         description: Product not found in available inventory
 */
router.get(
  '/scan-for-sale',
  authenticate,
  requireAdminOrSellerOrEmployee,
  inventoryController.scanForSale.bind(inventoryController)
);

/**
 * @swagger
 * /api/inventory/{productId}:
 *   get:
 *     summary: Return one inventory item
 *     tags: [Inventory]
 *     security:
 *       - bearerAuth: []
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
 *               $ref: '#/components/schemas/InventoryItemDetailResponse'
 *       401:
 *         description: Unauthorized
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       404:
 *         description: Inventory item not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
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
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/AdjustInventoryRequest'
 *     responses:
 *       200:
 *         description: Inventory adjusted successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AdjustInventoryResponse'
 *       400:
 *         description: Not enough stock to decrease
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       401:
 *         description: Unauthorized
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
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
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UpdateStockRequest'
 *     responses:
 *       200:
 *         description: Stock updated successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/UpdateStockResponse'
 *       400:
 *         description: Invalid request payload
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       404:
 *         description: Product name or product model not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.post(
  '/update-stock',
  authenticate,
  requireAdmin,
  validateRequest(updateStockSchema),
  inventoryController.updateStock
);
module.exports = router;
