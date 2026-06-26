const express = require('express');
const router = express.Router();
const salesController = require('./sales.controller');
const {
  createSaleSchema,
  viewSaleSchema,
  customerSalesSchema,
  salesHistorySchema,
  adminSalesHistorySchema
} = require('./sales.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin } = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

/**
 * @swagger
 * tags:
 *   name: Sales
 *   description: Sales management APIs
 */

/**
 * @swagger
 * /api/sales:
 *   post:
 *     summary: Create a new sale transaction
 *     tags: [Sales]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               product_id:
 *                 type: integer
 *               serial_number:
 *                 type: string
 *               customer_name:
 *                 type: string
 *               customer_number:
 *                 type: string
 *               vehicle_number:
 *                 type: string
 *               sell_price:
 *                 type: number
 *     responses:
 *       201:
 *         description: Sale transaction created successfully
 */
router.post(
  '/',
  authenticate,
  validateRequest(createSaleSchema),
  salesController.createSale
);

/**
 * @swagger
 * /api/sales:
 *   get:
 *     summary: Return all sales based on role (Admin sees all, Seller sees own)
 *     tags: [Sales]
 *     responses:
 *       200:
 *         description: Sales fetched successfully
 */
router.get(
  '/',
  authenticate,
  salesController.getSales
);

/**
 * @swagger
 * /api/sales/history:
 *   get:
 *     summary: Return seller's own sales history with pagination, search, and date filtering
 *     tags: [Sales]
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           default: 1
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 10
 *       - in: query
 *         name: searchCustomer
 *         schema:
 *           type: string
 *       - in: query
 *         name: searchSerial
 *         schema:
 *           type: string
 *       - in: query
 *         name: fromDate
 *         schema:
 *           type: string
 *           format: date-time
 *       - in: query
 *         name: toDate
 *         schema:
 *           type: string
 *           format: date-time
 *     responses:
 *       200:
 *         description: Seller sales history fetched successfully
 */
router.get(
  '/history',
  authenticate,
  validateRequest(salesHistorySchema),
  salesController.getSalesHistory
);

/**
 * @swagger
 * /api/sales/admin/history:
 *   get:
 *     summary: Return all sales across all sellers with pagination, search, filters, and shipment tracing (Admin only)
 *     tags: [Sales]
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           default: 1
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 10
 *       - in: query
 *         name: search
 *         schema:
 *           type: string
 *         description: Search by customer name, seller name, shop name, product name, or serial number
 *       - in: query
 *         name: sellerId
 *         schema:
 *           type: integer
 *         description: Filter by specific seller ID
 *       - in: query
 *         name: fromDate
 *         schema:
 *           type: string
 *           format: date-time
 *       - in: query
 *         name: toDate
 *         schema:
 *           type: string
 *           format: date-time
 *       - in: query
 *         name: shipmentStatus
 *         schema:
 *           type: string
 *           enum: [PENDING, ACCEPTED, REJECTED]
 *     responses:
 *       200:
 *         description: Admin sales history fetched successfully
 *       403:
 *         description: Forbidden — Admin access required
 */
router.get(
  '/admin/history',
  authenticate,
  requireAdmin,
  validateRequest(adminSalesHistorySchema),
  salesController.getAdminSalesHistory
);

/**
 * @swagger
 * /api/sales/{transactionId}:
 *   get:
 *     summary: Return a single sale's details by ID
 *     tags: [Sales]
 *     parameters:
 *       - in: path
 *         name: transactionId
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Sale details fetched successfully
 *       404:
 *         description: Transaction not found
 */
router.get(
  '/:transactionId',
  authenticate,
  validateRequest(viewSaleSchema),
  salesController.getSaleById
);

module.exports = router;
