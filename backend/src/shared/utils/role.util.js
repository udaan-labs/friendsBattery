const ROLES = require('../constants/roles');

const isAdmin = (user) => !!(user && user.role === ROLES.ADMIN);
const isSeller = (user) => !!(user && user.role === ROLES.SELLER);
const isEmployee = (user) => !!(user && user.role === ROLES.EMPLOYEE);

module.exports = {
  isAdmin,
  isSeller,
  isEmployee,
};
