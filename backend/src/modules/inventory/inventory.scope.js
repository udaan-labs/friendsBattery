const { prisma } = require('../../config/db');
const ROLES = require('../../shared/constants/roles');

/**
 * Prisma filter for which product_units a user may see as inventory.
 *
 * - SUPER_ADMIN: units owned by ADMIN or SUPER_ADMIN (org admin stock)
 * - ADMIN: units owned by this admin only (own shop stock)
 * - SELLER: units where owner_id = seller
 * - EMPLOYEE: units where current_location_id = employee.location_id
 *
 * @param {number|string|bigint} userId
 * @param {string} role
 * @param {number|string|bigint|null} [locationId] - from req.user when known (skip DB)
 * @returns {Promise<object|null>}
 */
async function resolveUnitScope(userId, role, locationId = undefined) {
  if (role === ROLES.SUPER_ADMIN) {
    return { owner: { role: { in: [ROLES.ADMIN, ROLES.SUPER_ADMIN] } } };
  }

  if (role === ROLES.ADMIN) {
    return { ownerId: BigInt(userId) };
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

  // Only real sellers get owner scope — never fall through unknown roles → ownerId
  if (role === ROLES.SELLER) {
    return { ownerId: BigInt(userId) };
  }

  return null;
}

module.exports = { resolveUnitScope };
