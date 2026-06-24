const express = require('express');
const router = express.Router();
const usersController = require('./users.controller');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin } = require('../../shared/middleware/role.middleware');

/**
 * GET /api/users
 * Retrieve list of users. Protected: admin only.
 */
router.get('/', authenticate, requireAdmin, usersController.getUsers);

module.exports = router;
