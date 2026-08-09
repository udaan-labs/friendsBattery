const ROLES = require('../constants/roles');

const isSuperAdmin = (user) => !!(user && user.role === ROLES.SUPER_ADMIN);
const isAdmin = (user) => !!(user && user.role === ROLES.ADMIN);
const isSeller = (user) => !!(user && user.role === ROLES.SELLER);
const isEmployee = (user) => !!(user && user.role === ROLES.EMPLOYEE);

/** Shop admin or super admin. */
const isSuperAdminOrAdmin = (user) => isSuperAdmin(user) || isAdmin(user);

/**
 * Role string check — SUPER_ADMIN shares global admin power until §1/§2 re-scope.
 * Use for service/controller branches that today treat ADMIN as “management”.
 */
const isAdminLikeRole = (role) =>
  role === ROLES.SUPER_ADMIN || role === ROLES.ADMIN;

module.exports = {
  isSuperAdmin,
  isAdmin,
  isSeller,
  isEmployee,
  isSuperAdminOrAdmin,
  isAdminLikeRole,
};
