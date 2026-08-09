const { errorResponse } = require('../utils/response');
const {
  isSuperAdmin,
  isAdmin,
  isSeller,
  isEmployee,
  isSuperAdminOrAdmin,
} = require('../utils/role.util');

/**
 * Generic role gate. Pass one or more Role strings from constants/roles.
 * @example requireRole(ROLES.SUPER_ADMIN, ROLES.ADMIN)
 */
const requireRole = (...allowedRoles) => (req, res, next) => {
  if (!req.user || !allowedRoles.includes(req.user.role)) {
    const label = allowedRoles.length ? allowedRoles.join(' or ') : 'allowed role';
    return errorResponse(res, 403, `Forbidden: ${label} access required`);
  }
  next();
};

const requireSuperAdmin = (req, res, next) => {
  if (!req.user || !isSuperAdmin(req.user)) {
    return errorResponse(res, 403, 'Forbidden: Super Admin access required');
  }
  next();
};

/**
 * Management routes (current global admin tools).
 * SUPER_ADMIN included until §1/§2 split own-shop vs all-WH APIs.
 */
const requireAdmin = (req, res, next) => {
  if (!req.user || !isSuperAdminOrAdmin(req.user)) {
    return errorResponse(res, 403, 'Forbidden: Admin access required');
  }
  next();
};

/** Super Admin or shop Admin (same as requireAdmin while SA shares admin APIs). */
const requireSuperAdminOrAdmin = (req, res, next) => {
  if (!req.user || !isSuperAdminOrAdmin(req.user)) {
    return errorResponse(res, 403, 'Forbidden: Super Admin or Admin access required');
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
  if (!req.user || (!isSuperAdminOrAdmin(req.user) && !isSeller(req.user))) {
    return errorResponse(res, 403, 'Forbidden: Admin or Seller access required');
  }
  next();
};

/** Management + seller (SA, shop Admin, or Seller). */
const requireSuperAdminOrAdminOrSeller = (req, res, next) => {
  if (!req.user || (!isSuperAdminOrAdmin(req.user) && !isSeller(req.user))) {
    return errorResponse(res, 403, 'Forbidden: Super Admin, Admin or Seller access required');
  }
  next();
};

/** Any of the four system roles. */
const requireAdminOrSellerOrEmployee = (req, res, next) => {
  if (
    !req.user ||
    (!isSuperAdmin(req.user) &&
      !isAdmin(req.user) &&
      !isSeller(req.user) &&
      !isEmployee(req.user))
  ) {
    return errorResponse(res, 403, 'Forbidden: authenticated system role required');
  }
  next();
};

module.exports = {
  requireRole,
  requireSuperAdmin,
  requireAdmin,
  requireSuperAdminOrAdmin,
  requireSeller,
  requireEmployee,
  requireAdminOrSeller,
  requireSuperAdminOrAdminOrSeller,
  requireAdminOrSellerOrEmployee,
};
