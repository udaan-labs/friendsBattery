const express = require('express');
const router = express.Router();
const customerController = require('./customers.controller');
const { validateRequest } = require('../../shared/middleware/validation.middleware');
const validation = require('./customers.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');

router.use(authenticate);

router.post('/', validateRequest(validation.createCustomerSchema), customerController.createCustomer);
router.get('/', validateRequest(validation.getCustomersSchema), customerController.getCustomers);
router.get('/:id', validateRequest(validation.customerIdParamSchema), customerController.getCustomerById);
router.patch('/:id', validateRequest(validation.updateCustomerSchema), customerController.updateCustomer);

module.exports = router;
