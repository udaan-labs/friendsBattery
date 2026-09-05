const express = require('express');
const shipmentsController = require('./shipments.controller');
const {
  createShipmentSchema,
  acceptShipmentSchema,
  viewShipmentSchema,
} = require('./shipments.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const {
  requireAdmin,
  requireSeller,
  requireAdminOrSeller,
  requireAdminOrSellerOrEmployee,
  requireEmployee,
} = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

const shipmentsRouter = express.Router();
const sellerRouter = express.Router();
const employeeRouter = express.Router();

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
 *     summary: Transfer stock serials from admin to seller (Admin only)
 *     description: |
 *       Body is sellerId + serial_numbers only. Product name/model are resolved from each unit.
 *       Marks existing AVAILABLE admin-owned product units as IN_SHIPMENT.
 *       Creates shipment record (status PENDING) and inventory_transactions (SHIPPED).
 *       Ownership moves to seller when seller accepts the shipment.
 *     tags: [Shipments]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateShipmentRequest'
 *     responses:
 *       201:
 *         description: Units transferred successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/CreateShipmentResponse'
 *       400:
 *         description: Invalid serials or payload
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       403:
 *         description: Admin access required
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       404:
 *         description: Seller not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       409:
 *         description: Serial no longer available (race)
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
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
 * /api/shipments:
 *   get:
 *     summary: List all shipments (Admin only)
 *     tags: [Shipments]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: All shipments retrieved
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
 *                       acceptedAt:
 *                         type: string
 *                         nullable: true
 *                       seller:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: integer
 *                           userName:
 *                             type: string
 *                           shopName:
 *                             type: string
 *                       totalProducts:
 *                         type: integer
 *                       totalQuantity:
 *                         type: integer
 */
shipmentsRouter.get(
  '/',
  authenticate,
  requireAdmin,
  shipmentsController.getAllShipments.bind(shipmentsController)
);

/**
 * @swagger
 * /api/shipments/{id}:
 *   get:
 *     summary: Get shipment details by ID (Admin or Seller)
 *     tags: [Shipments]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Shipment ID
 *     responses:
 *       200:
 *         description: Shipment details retrieved
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
 *                     shipmentId:
 *                       type: integer
 *                     shipmentNumber:
 *                       type: string
 *                     status:
 *                       type: string
 *                     createdAt:
 *                       type: string
 *                     acceptedAt:
 *                       type: string
 *                       nullable: true
 *                     seller:
 *                       type: object
 *                       properties:
 *                         id:
 *                           type: integer
 *                         userName:
 *                           type: string
 *                         shopName:
 *                           type: string
 *                         userNumber:
 *                           type: string
 *                           nullable: true
 *                     totalProducts:
 *                       type: integer
 *                     totalQuantity:
 *                       type: integer
 *                     items:
 *                       type: array
 *                       items:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: integer
 *                           category:
 *                             type: string
 *                           productGroup:
 *                             type: string
 *                           productName:
 *                             type: string
 *                           productModel:
 *                             type: string
 *                           quantity:
 *                             type: integer
 *                           serialNumber:
 *                             type: string
 *                             nullable: true
 *       403:
 *         description: Forbidden
 *       404:
 *         description: Shipment not found
 */
shipmentsRouter.get(
  '/:id',
  authenticate,
  requireAdminOrSellerOrEmployee,
  validateRequest(viewShipmentSchema),
  shipmentsController.getShipmentById.bind(shipmentsController)
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

/**
 * @swagger
 * /api/employee/shipments:
 *   get:
 *     summary: List shipments for sellers at the employee's shop location (read-only)
 *     description: |
 *       EMPLOYEE only. Returns NewShipment rows where the seller shares
 *       users.location_id with the employee. Does not allow accept/transfer.
 *     tags: [Shipments]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Shop shipments list (same shape as seller list)
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/SellerShipmentsListResponse'
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Employee only
 */
employeeRouter.get(
  '/shipments',
  authenticate,
  requireEmployee,
  shipmentsController.getEmployeeShipments.bind(shipmentsController)
);

module.exports = {
  shipments: shipmentsRouter,
  seller: sellerRouter,
  employee: employeeRouter,
};
