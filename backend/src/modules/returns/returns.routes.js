const express = require('express');
const router = express.Router();
const returnsController = require('./returns.controller');
const { authenticate } = require('../../shared/middleware/auth.middleware');

// Route to submit/process a product return
router.post('/', authenticate, returnsController.processReturn);

// Route to list product returns
router.get('/', authenticate, returnsController.getReturns);

module.exports = router;
