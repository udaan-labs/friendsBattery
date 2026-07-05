const express = require('express');
const router = express.Router();
const { verifyProduct } = require('./product-units.controller');
const { authenticate } = require('../../shared/middleware/auth.middleware');

router.post('/verify', authenticate, verifyProduct);

// Define a placeholder route
router.get('/', (req, res) => {
  res.status(200).json([]);
});

module.exports = router;
