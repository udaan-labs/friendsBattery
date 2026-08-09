const express = require('express');
const router = express.Router();
const { prisma } = require('../../config/db');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin } = require('../../shared/middleware/role.middleware');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

/**
 * GET /api/users
 * Retrieve list of users. Protected: admin only.
 * Optional ?role=ADMIN|SELLER|EMPLOYEE
 */
router.get('/', authenticate, requireAdmin, async (req, res) => {
  try {
    const where = {};
    if (req.query.role) where.role = req.query.role;

    const users = await prisma.user.findMany({
      where,
      orderBy: { createdAt: 'desc' },
    });

    return successResponse(
      res,
      200,
      'Users fetched successfully',
      users.map((user) => ({
        id: Number(user.id),
        userId: user.userId,
        userName: user.userName,
        role: user.role,
        userNumber: user.userNumber,
        shopName: user.shopName,
        isActive: user.isActive,
        isVerified: user.isVerified,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
      }))
    );
  } catch (error) {
    return handleRouteError(res, error, 'Get Users Error:');
  }
});

module.exports = router;
