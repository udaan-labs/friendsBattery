const express = require('express');
const router = express.Router();
const dashboardController = require('./dashboard.controller');

// Import middlewares
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireSeller } = require('../../shared/middleware/role.middleware');

// GET /api/seller/dashboard/stats
/**
 * @swagger
 * /api/seller/dashboard/stats:
 *   get:
 *     summary: Get seller dashboard statistics
 *     description: Retrieves total available stock and today's sales for the authenticated seller. Only accessible by Seller users.
 *     tags: [Dashboard]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Seller dashboard statistics retrieved successfully
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
 *                   example: Seller dashboard stats retrieved successfully
 *                 data:
 *                   type: object
 *                   properties:
 *                     totalStock:
 *                       type: integer
 *                       example: 1284
 *                     todaySales:
 *                       type: integer
 *                       example: 14
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden (Seller access required)
 *       500:
 *         description: Internal server error
 */
router.get(
  '/stats',
  authenticate,
  requireSeller,
  dashboardController.getSellerStats.bind(dashboardController)
);

module.exports = router;
