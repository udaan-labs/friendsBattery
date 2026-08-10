const express = require('express');
const router = express.Router();
const { prisma } = require('../../config/db');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin } = require('../../shared/middleware/role.middleware');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');
const {
  resolveAdminShopScope,
  staffUserWhereForShopScope,
} = require('../../shared/utils/shop-scope.util');

/**
 * GET /api/users
 * SA: all users. Shop Admin: staff under parent/location only.
 * Optional ?role=ADMIN|SELLER|EMPLOYEE
 */
router.get('/', authenticate, requireAdmin, async (req, res) => {
  try {
    const where = {};
    if (req.query.role) where.role = req.query.role;

    const scope = resolveAdminShopScope(req.user);
    if (scope?.kind === 'shop') {
      const staffWhere = staffUserWhereForShopScope(scope);
      if (req.query.role) {
        where.role = req.query.role;
        where.OR = staffWhere.OR;
      } else {
        Object.assign(where, staffWhere);
      }
    }

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
