const express = require('express');
const router = express.Router();
const shopController = require('./shops.controller');
const { validateRequest } = require('../../shared/middleware/validation.middleware');
const { createShopSchema, updateShopSchema, shopIdParamSchema } = require('./shops.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireRole } = require('../../shared/middleware/role.middleware');
const { SUPER_ADMIN } = require('../../shared/constants/roles');

// Apply authentication to all shop routes
router.use(authenticate);

router.post('/', requireRole(SUPER_ADMIN), validateRequest(createShopSchema), shopController.createShop);
router.get('/', shopController.getShops);
router.get('/:id', validateRequest(shopIdParamSchema), shopController.getShopById);
router.patch('/:id', requireRole(SUPER_ADMIN), validateRequest(updateShopSchema), shopController.updateShop);
router.delete('/:id', requireRole(SUPER_ADMIN), validateRequest(shopIdParamSchema), shopController.deleteShop);

module.exports = router;
