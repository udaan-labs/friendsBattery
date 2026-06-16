const express = require('express');
const router = express.Router();
const controller = require('./audit-logs.controller');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireRole } = require('../../shared/middleware/role.middleware');
const { SUPER_ADMIN } = require('../../shared/constants/roles');

router.use(authenticate);

// Only SUPER_ADMIN can view audit logs
router.get('/', requireRole(SUPER_ADMIN), controller.getAuditLogs);

module.exports = router;
