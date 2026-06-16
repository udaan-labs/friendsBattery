const express = require('express');
const router = express.Router();
const controller = require('./inventory.controller');
const { validateRequest } = require('../../shared/middleware/validation.middleware');
const validation = require('./inventory.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireRole } = require('../../shared/middleware/role.middleware');
const { SUPER_ADMIN, SELLER } = require('../../shared/constants/roles');

router.use(authenticate);

// Depending on rules, transfers might be restricted to SUPER_ADMIN
router.post('/transfer', requireRole(SUPER_ADMIN), validateRequest(validation.transferSchema), controller.transferInventory);

router.get('/history/:productUnitId', validateRequest(validation.getHistorySchema), controller.getHistoryByProductUnitId);
router.get('/history/serial/:serialNumber', validateRequest(validation.getHistoryBySerialSchema), controller.getHistoryBySerialNumber);

module.exports = router;
