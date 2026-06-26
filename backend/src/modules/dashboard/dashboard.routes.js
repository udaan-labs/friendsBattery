const express = require('express');
const router = express.Router();
const dashboardController = require('./dashboard.controller');

// Import middlewares
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin } = require('../../shared/middleware/role.middleware');

// GET /api/dashboard/stats
/**
 * @swagger
 * /api/dashboard/stats:
 *   get:
 *     summary: Get dashboard statistics
 *     description: Retrieves total available stock, today's sales, pending seller requests, and total sellers. Only accessible by Admin users.
 *     tags: [Dashboard]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Dashboard statistics retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 message:
 *                   type: string
 *                   example: Dashboard stats retrieved successfully
 *                 data:
 *                   type: object
 *                   properties:
 *                     totalStock:
 *                       type: integer
 *                       example: 120
 *                     todaySales:
 *                       type: integer
 *                       example: 35
 *                     pendingRequests:
 *                       type: integer
 *                       example: 8
 *                     totalSellers:
 *                       type: integer
 *                       example: 12
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden (Admin access required)
 *       500:
 *         description: Internal server error
 */
router.get(
  '/stats',
  authenticate,
  requireAdmin,
  dashboardController.getStats.bind(dashboardController)
);

/**
 * @swagger
 * /api/dashboard/recent-activity:
 *   get:
 *     summary: Get recent activity feed (Admin only)
 *     tags: [Dashboard]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Recent activity retrieved successfully
 */
router.get(
  '/recent-activity',
  authenticate,
  requireAdmin,
  dashboardController.getRecentActivity.bind(dashboardController)
);

module.exports = router;

