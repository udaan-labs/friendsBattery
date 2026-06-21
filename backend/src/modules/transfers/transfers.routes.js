const express = require('express');
const router = express.Router();
const transfersController = require('./transfers.controller');
const {
  createTransferSchema,
  viewTransferSchema,
  receiveTransferSchema,
  cancelTransferSchema
} = require('./transfers.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin, requireSeller } = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

/**
 * @swagger
 * tags:
 *   name: Transfers
 *   description: Shipment / Transfer management APIs
 */

/**
 * @swagger
 * /api/transfers:
 *   post:
 *     summary: Create a new shipment from Admin to Seller
 *     tags: [Transfers]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               seller_id:
 *                 type: integer
 *               items:
 *                 type: array
 *                 items:
 *                   type: object
 *                   properties:
 *                     product_id:
 *                       type: integer
 *                     quantity:
 *                       type: integer
 *                     price_per_piece:
 *                       type: number
 *     responses:
 *       201:
 *         description: Shipment created successfully
 *       403:
 *         description: Admin access required
 */
router.post(
  '/',
  authenticate,
  requireAdmin,
  validateRequest(createTransferSchema),
  transfersController.createTransfer
);

/**
 * @swagger
 * /api/transfers:
 *   get:
 *     summary: Return all shipments (Admin gets all, Seller gets own)
 *     tags: [Transfers]
 *     responses:
 *       200:
 *         description: Shipments fetched successfully
 */
router.get(
  '/',
  authenticate,
  transfersController.getTransfers
);

/**
 * @swagger
 * /api/transfers/{shipmentId}:
 *   get:
 *     summary: Return complete shipment details by ID
 *     tags: [Transfers]
 *     parameters:
 *       - in: path
 *         name: shipmentId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Shipment details fetched successfully
 *       403:
 *         description: Unauthorized access
 *       404:
 *         description: Shipment not found
 */
router.get(
  '/:shipmentId',
  authenticate,
  validateRequest(viewTransferSchema),
  transfersController.getTransferById
);

/**
 * @swagger
 * /api/transfers/{shipmentId}/receive:
 *   patch:
 *     summary: Seller receives and confirms a shipment delivery
 *     tags: [Transfers]
 *     parameters:
 *       - in: path
 *         name: shipmentId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Shipment received successfully
 *       400:
 *         description: Shipment is not in PENDING status
 *       403:
 *         description: Seller access required or shipment not assigned
 *       404:
 *         description: Shipment not found
 */
router.patch(
  '/:shipmentId/receive',
  authenticate,
  requireSeller,
  validateRequest(receiveTransferSchema),
  transfersController.receiveTransfer
);

/**
 * @swagger
 * /api/transfers/{shipmentId}/cancel:
 *   patch:
 *     summary: Admin cancels a pending shipment
 *     tags: [Transfers]
 *     parameters:
 *       - in: path
 *         name: shipmentId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Shipment cancelled successfully
 *       400:
 *         description: Shipment is not in PENDING status
 *       403:
 *         description: Admin access required
 *       404:
 *         description: Shipment not found
 */
router.patch(
  '/:shipmentId/cancel',
  authenticate,
  requireAdmin,
  validateRequest(cancelTransferSchema),
  transfersController.cancelTransfer
);

module.exports = router;
