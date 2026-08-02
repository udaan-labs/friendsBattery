const { prisma } = require('../../config/db');
const ROLES = require('../../shared/constants/roles');

/**
 * Prisma filter for which product_units a user may see as inventory.
 *
 * - ADMIN: units owned by admin users
 * - SELLER: units where owner_id = seller
 * - EMPLOYEE: units where current_location_id = employee.location_id
 *
 * @param {number|string|bigint} userId
 * @param {string} role
 * @param {number|string|bigint|null} [locationId] - from req.user when known (skip DB)
 * @returns {Promise<object|null>}
 */
async function resolveUnitScope(userId, role, locationId = undefined) {
  if (role === ROLES.ADMIN || role === ROLES.SUPER_ADMIN) {
    return { owner: { role: ROLES.ADMIN } };
  }

  if (role === ROLES.EMPLOYEE) {
    let loc = locationId;
    if (loc === undefined) {
      const user = await prisma.user.findUnique({
        where: { id: BigInt(userId) },
        select: { locationId: true },
      });
      loc = user?.locationId ?? null;
    }
    if (loc == null) return null;
    return { currentLocationId: BigInt(loc) };
  }

  // SELLER (default non-admin ownership scope)
  return { ownerId: BigInt(userId) };
}

module.exports = { resolveUnitScope };
