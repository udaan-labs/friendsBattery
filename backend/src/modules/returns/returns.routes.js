const express = require('express');
const router = express.Router();
const returnController = require('./returns.controller');
const { validateRequest } = require('../../shared/middleware/validation.middleware');
const validation = require('./returns.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');

router.use(authenticate);

router.post('/', validateRequest(validation.createReturnSchema), returnController.createReturn);
router.patch('/:id/status', validateRequest(validation.updateReturnStatusSchema), returnController.updateReturnStatus);
router.post('/:id/replace', validateRequest(validation.replaceReturnSchema), returnController.processReplacement);

module.exports = router;
