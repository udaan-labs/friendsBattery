const { errorResponse } = require('../utils/response');
const { isAdmin, isSeller } = require('../utils/role.util');

const requireRole = (...allowedRoles) => {
  return (req, res, next) => {
    if (!req.user || !req.user.role) {
      return errorResponse(res, 403, 'Forbidden: Role not found');
    }

    if (!allowedRoles.includes(req.user.role)) {
      return errorResponse(res, 403, 'Forbidden: Insufficient permissions');
    }

    next();
  };
};

const requireAdmin = (req, res, next) => {
  if (!req.user || !isAdmin(req.user)) {
    return errorResponse(res, 403, 'Forbidden: Admin access required');
  }
  next();
};

const requireSeller = (req, res, next) => {
  if (!req.user || !isSeller(req.user)) {
    return errorResponse(res, 403, 'Forbidden: Seller access required');
  }
  next();
};

const requireAdminOrSeller = (req, res, next) => {
  if (!req.user || (!isAdmin(req.user) && !isSeller(req.user))) {
    return errorResponse(res, 403, 'Forbidden: Admin or Seller access required');
  }
  next();
};

module.exports = { requireRole, requireAdmin, requireSeller, requireAdminOrSeller };
