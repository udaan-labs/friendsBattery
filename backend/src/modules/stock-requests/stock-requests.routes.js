const express = require('express');
const router = express.Router();
const controller = require('./stock-requests.controller');
const { validateRequest } = require('../../shared/middleware/validation.middleware');
const validation = require('./stock-requests.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireRole } = require('../../shared/middleware/role.middleware');
const { SUPER_ADMIN, SELLER } = require('../../shared/constants/roles');

router.use(authenticate);

router.post('/', requireRole(SELLER, SUPER_ADMIN), validateRequest(validation.createStockRequestSchema), controller.createStockRequest);
router.get('/', controller.getStockRequests);
router.patch('/:id', requireRole(SUPER_ADMIN), validateRequest(validation.updateStockRequestSchema), controller.updateStockRequestStatus);

module.exports = router;
