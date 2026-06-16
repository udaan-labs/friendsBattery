const express = require('express');
const router = express.Router();
const salesController = require('./sales.controller');
const { validateRequest } = require('../../shared/middleware/validation.middleware');
const validation = require('./sales.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireRole } = require('../../shared/middleware/role.middleware');
const { SELLER, SUPER_ADMIN } = require('../../shared/constants/roles');

router.use(authenticate);

// Both SUPER_ADMIN and SELLER can process sales (assuming SUPER_ADMIN is assigned to a shop)
router.post('/', validateRequest(validation.createSaleSchema), salesController.createSale);

module.exports = router;
