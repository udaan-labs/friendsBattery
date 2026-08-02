const { errorResponse } = require('../utils/response');
const { isAdmin, isSeller, isEmployee } = require('../utils/role.util');

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

const requireEmployee = (req, res, next) => {
  if (!req.user || !isEmployee(req.user)) {
    return errorResponse(res, 403, 'Forbidden: Employee access required');
  }
  next();
};

const requireAdminOrSeller = (req, res, next) => {
  if (!req.user || (!isAdmin(req.user) && !isSeller(req.user))) {
    return errorResponse(res, 403, 'Forbidden: Admin or Seller access required');
  }
  next();
};

/** Seller or employee (e.g. shared inventory reads later). */
const requireSellerOrEmployee = (req, res, next) => {
  if (!req.user || (!isSeller(req.user) && !isEmployee(req.user))) {
    return errorResponse(res, 403, 'Forbidden: Seller or Employee access required');
  }
  next();
};

/** Any of the three system roles. */
const requireAdminOrSellerOrEmployee = (req, res, next) => {
  if (!req.user || (!isAdmin(req.user) && !isSeller(req.user) && !isEmployee(req.user))) {
    return errorResponse(res, 403, 'Forbidden: Admin, Seller or Employee access required');
  }
  next();
};

module.exports = {
  requireRole,
  requireAdmin,
  requireSeller,
  requireEmployee,
  requireAdminOrSeller,
  requireSellerOrEmployee,
  requireAdminOrSellerOrEmployee,
};
