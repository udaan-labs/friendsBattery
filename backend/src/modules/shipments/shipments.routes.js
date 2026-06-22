const express = require('express');
const shipmentsController = require('./shipments.controller');
const { createShipmentSchema, acceptShipmentSchema } = require('./shipments.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin, requireSeller } = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

const shipmentsRouter = express.Router();
const sellerRouter = express.Router();

// Admin Route: Create Shipment
shipmentsRouter.post(
  '/',
  authenticate,
  requireAdmin,
  validateRequest(createShipmentSchema),
  shipmentsController.createShipment.bind(shipmentsController)
);

// Seller Route: Accept Shipment
shipmentsRouter.post(
  '/:shipmentId/accept',
  authenticate,
  requireSeller,
  validateRequest(acceptShipmentSchema),
  shipmentsController.acceptShipment.bind(shipmentsController)
);

// Seller Route: Pending Shipment Count
sellerRouter.get(
  '/dashboard/pending-shipments',
  authenticate,
  requireSeller,
  shipmentsController.getPendingShipmentsCount.bind(shipmentsController)
);

// Seller Route: List Shipments
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
