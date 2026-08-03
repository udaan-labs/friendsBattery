const express = require('express');
const router = express.Router();
const { authenticate } = require('../../shared/middleware/auth.middleware');

// Stub — auth only (feature not built)
router.get('/', authenticate, (req, res) => {
  res.status(200).json([]);
});

module.exports = router;
