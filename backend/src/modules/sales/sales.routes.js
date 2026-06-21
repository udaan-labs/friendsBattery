const express = require('express');
const router = express.Router();
const salesController = require('./sales.controller');
const {
  createSaleSchema,
  viewSaleSchema,
  customerSalesSchema
} = require('./sales.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
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

/**
 * @swagger
 * /api/sales/customer/{mobile}:
 *   get:
 *     summary: Return complete purchase history for a customer mobile
 *     tags: [Sales]
 *     parameters:
 *       - in: path
 *         name: mobile
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Customer history fetched successfully
 */
router.get(
  '/customer/:mobile',
  authenticate,
  validateRequest(customerSalesSchema),
  salesController.getCustomerHistory
);

module.exports = router;
