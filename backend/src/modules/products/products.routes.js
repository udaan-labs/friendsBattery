const express = require('express');
const productController = require('./products.controller');
const { validateRequest } = require('../../shared/middleware/validation.middleware');
const validation = require('./products.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireRole } = require('../../shared/middleware/role.middleware');
const { SUPER_ADMIN } = require('../../shared/constants/roles');

// Product Groups
const productGroupRouter = express.Router();
productGroupRouter.use(authenticate);
productGroupRouter.post('/', requireRole(SUPER_ADMIN), validateRequest(validation.createProductGroupSchema), productController.createProductGroup);
productGroupRouter.get('/', productController.getProductGroups);

// Product Subgroups
const productSubgroupRouter = express.Router();
productSubgroupRouter.use(authenticate);
productSubgroupRouter.post('/', requireRole(SUPER_ADMIN), validateRequest(validation.createProductSubgroupSchema), productController.createProductSubgroup);
productSubgroupRouter.get('/', productController.getProductSubgroups);

// Products
const productRouter = express.Router();
productRouter.use(authenticate);
productRouter.post('/', requireRole(SUPER_ADMIN), validateRequest(validation.createProductSchema), productController.createProduct);
productRouter.get('/', productController.getProducts);
productRouter.get('/:id', validateRequest(validation.productIdParamSchema), productController.getProductById);
productRouter.patch('/:id', requireRole(SUPER_ADMIN), validateRequest(validation.updateProductSchema), productController.updateProduct);

module.exports = {
  productGroupRouter,
  productSubgroupRouter,
  productRouter
};
