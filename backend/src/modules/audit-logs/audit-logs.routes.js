const express = require('express');
const router = express.Router();
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin } = require('../../shared/middleware/role.middleware');

// Stub — admin only
router.get('/', authenticate, requireAdmin, (req, res) => {
  res.status(200).json([]);
});

module.exports = router;
