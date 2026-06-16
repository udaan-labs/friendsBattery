const express = require('express');
const router = express.Router();
const controller = require('./product-units.controller');
const { validateRequest } = require('../../shared/middleware/validation.middleware');
const validation = require('./product-units.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireRole } = require('../../shared/middleware/role.middleware');
const { SUPER_ADMIN } = require('../../shared/constants/roles');

router.use(authenticate);

router.post('/', requireRole(SUPER_ADMIN), validateRequest(validation.createProductUnitSchema), controller.createProductUnit);
router.get('/', validateRequest(validation.getProductUnitsSchema), controller.getProductUnits);
router.get('/:id', validateRequest(validation.productUnitIdParamSchema), controller.getProductUnitById);
router.get('/serial/:serialNumber', validateRequest(validation.serialNumberParamSchema), controller.getProductUnitBySerialNumber);
router.patch('/:id', requireRole(SUPER_ADMIN), validateRequest(validation.updateProductUnitSchema), controller.updateProductUnit);

module.exports = router;
