const { errorResponse } = require('../utils/response');
const { isAdmin, isSeller, isEmployee } = require('../utils/role.util');

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

/** Any of the three system roles. */
const requireAdminOrSellerOrEmployee = (req, res, next) => {
  if (!req.user || (!isAdmin(req.user) && !isSeller(req.user) && !isEmployee(req.user))) {
    return errorResponse(res, 403, 'Forbidden: Admin, Seller or Employee access required');
  }
  next();
};

module.exports = {
  requireAdmin,
  requireSeller,
  requireEmployee,
  requireAdminOrSeller,
  requireAdminOrSellerOrEmployee,
};
