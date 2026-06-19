const ROLES = require('../constants/roles');

const isAdmin = (user) => {
  return !!(user && (user.role === ROLES.ADMIN || user.role === ROLES.SUPER_ADMIN));
};

const isSeller = (user) => {
  return !!(user && user.role === ROLES.SELLER);
};

const hasRole = (user, role) => {
  return !!(user && user.role === role);
};

module.exports = {
  isAdmin,
  isSeller,
  hasRole
};
