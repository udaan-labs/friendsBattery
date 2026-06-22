const express = require('express');
const shipmentsController = require('./shipments.controller');
const { createShipmentSchema, acceptShipmentSchema } = require('./shipments.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin, requireSeller } = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

const shipmentsRouter = express.Router();
const sellerRouter = express.Router();

/**
 * @swagger
 * tags:
 *   name: Shipments
 *   description: New Shipment Management APIs
 */

/**
 * @swagger
 * /api/shipments:
 *   post:
 *     summary: Create a new shipment (Admin only)
 *     tags: [Shipments]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - sellerId
 *               - items
 *             properties:
 *               sellerId:
 *                 type: integer
 *               items:
 *                 type: array
 *                 items:
 *                   type: object
 *                   required:
 *                     - productCategoryId
 *                     - productNameId
 *                     - productModelId
 *                     - quantity
 *                   properties:
 *                     productCategoryId:
 *                       type: integer
 *                     productNameId:
 *                       type: integer
 *                     productModelId:
 *                       type: integer
 *                     quantity:
 *                       type: integer
 *     responses:
 *       201:
 *         description: Shipment created successfully
 *       400:
 *         description: Invalid input or product combo not found
 *       403:
 *         description: Admin access required
 */
shipmentsRouter.post(
  '/',
  authenticate,
  requireAdmin,
  validateRequest(createShipmentSchema),
  shipmentsController.createShipment.bind(shipmentsController)
);

/**
 * @swagger
 * /api/shipments/{shipmentId}/accept:
 *   post:
 *     summary: Accept a pending shipment (Seller only)
 *     tags: [Shipments]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: shipmentId
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: false
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *     responses:
 *       200:
 *         description: Shipment accepted successfully
 *       400:
 *         description: Shipment not in PENDING status
 *       403:
 *         description: Forbidden (Seller does not own shipment)
 *       404:
 *         description: Shipment not found
 */
shipmentsRouter.post(
  '/:shipmentId/accept',
  authenticate,
  requireSeller,
  validateRequest(acceptShipmentSchema),
  shipmentsController.acceptShipment.bind(shipmentsController)
);

/**
 * @swagger
 * /api/seller/dashboard/pending-shipments:
 *   get:
 *     summary: Get pending shipments count (Seller only)
 *     tags: [Shipments]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Successfully retrieved pending count
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
 *                     pendingShipments:
 *                       type: integer
 */
sellerRouter.get(
  '/dashboard/pending-shipments',
  authenticate,
  requireSeller,
  shipmentsController.getPendingShipmentsCount.bind(shipmentsController)
);

/**
 * @swagger
 * /api/seller/shipments:
 *   get:
 *     summary: List shipments for seller (Seller only)
 *     tags: [Shipments]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Successfully retrieved shipments
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
 *                     type: object
 *                     properties:
 *                       shipmentId:
 *                         type: integer
 *                       shipmentNumber:
 *                         type: string
 *                       status:
 *                         type: string
 *                       createdAt:
 *                         type: string
 *                       items:
 *                         type: array
 *                         items:
 *                           type: object
 *                           properties:
 *                             productModel:
 *                               type: string
 *                             quantity:
 *                               type: integer
 */
sellerRouter.get(
  '/shipments',
  authenticate,
  requireSeller,
  shipmentsController.getShipments.bind(shipmentsController)
);

module.exports = {
  shipments: shipmentsRouter,
  seller: sellerRouter
};
