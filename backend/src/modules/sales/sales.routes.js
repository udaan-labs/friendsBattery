const express = require('express');
const router = express.Router();
const salesController = require('./sales.controller');
const {
  createSaleSchema,
  createServiceBillSchema,
  createRentSchema,
  returnRentSchema,
  viewSaleSchema,
  salesHistorySchema,
  adminSalesHistorySchema,
} = require('./sales.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const {
  requireAdmin,
  requireSeller,
  requireAdminOrSeller,
  requireAdminOrSellerOrEmployee,
} = require('../../shared/middleware/role.middleware');
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
 *     summary: Create a sale (SA/Admin/Seller own units; EMPLOYEE location stock)
 *     tags: [Sales]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateSaleRequest'
 *     responses:
 *       201:
 *         description: Sale transaction created successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/CreateSaleResponse'
 *       403:
 *         description: Forbidden
 *       404:
 *         description: Serial not available in actor inventory/location
 *       409:
 *         description: Concurrent claim lost (already sold)
 */
router.post(
  '/',
  authenticate,
  // SA/Admin/Seller: own units · EMPLOYEE: AVAILABLE at own location
  requireAdminOrSellerOrEmployee,
  validateRequest(createSaleSchema),
  salesController.createSale
);

/**
 * @swagger
 * /api/sales/service:
 *   post:
 *     summary: Create a service bill (no stock move)
 *     tags: [Sales]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateServiceBillRequest'
 *     responses:
 *       201:
 *         description: Service bill created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/CreateServiceBillResponse'
 *       400:
 *         description: Validation error
 */
router.post(
  '/service',
  authenticate,
  requireAdminOrSellerOrEmployee,
  validateRequest(createServiceBillSchema),
  salesController.createServiceBill
);

/**
 * @swagger
 * /api/sales/rent:
 *   post:
 *     summary: Rent battery out with deposit (unit → RENTED)
 *     tags: [Sales]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateRentRequest'
 *     responses:
 *       201:
 *         description: Battery rented
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/CreateRentResponse'
 */
router.post(
  '/rent',
  authenticate,
  requireAdminOrSellerOrEmployee,
  validateRequest(createRentSchema),
  salesController.createRent
);

/**
 * @swagger
 * /api/sales/rent/return:
 *   post:
 *     summary: Return rented battery — fee from deposit, refund rest
 *     tags: [Sales]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/ReturnRentRequest'
 *     responses:
 *       200:
 *         description: Rent returned
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ReturnRentResponse'
 */
router.post(
  '/rent/return',
  authenticate,
  requireAdminOrSellerOrEmployee,
  validateRequest(returnRentSchema),
  salesController.returnRent
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
  requireAdminOrSeller,
  salesController.getSales
);

/**
 * @swagger
 * /api/sales/history:
 *   get:
 *     summary: Return seller's own sales history with pagination, search, and date filtering
 *     tags: [Sales]
 *     security:
 *       - bearerAuth: []
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
 *       - in: query
 *         name: filter
 *         schema:
 *           type: string
 *           enum: [today, date, all]
 *       - in: query
 *         name: date
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Seller sales history fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/SaleHistoryResponse'
 */
router.get(
  '/history',
  authenticate,
  requireSeller,
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
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AdminSaleHistoryResponse'
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
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: transactionId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Sale details fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/SaleDetailResponse'
 *       404:
 *         description: Transaction not found
 */
router.get(
  '/:transactionId',
  authenticate,
  requireAdminOrSeller,
  validateRequest(viewSaleSchema),
  salesController.getSaleById
);

module.exports = router;
