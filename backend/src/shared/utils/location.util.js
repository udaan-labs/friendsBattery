const { prisma } = require('../../config/db');

const WAREHOUSE_CODE = 'WH001';

/**
 * Resolve default warehouse location id (WH001). Cached per process.
 * @returns {Promise<bigint|null>}
 */
let _warehouseId = undefined;
async function getDefaultWarehouseId(tx = prisma) {
  if (_warehouseId !== undefined) return _warehouseId;
  const loc = await tx.location.findUnique({ where: { code: WAREHOUSE_CODE } });
  _warehouseId = loc ? loc.id : null;
  return _warehouseId;
}

/**
 * User's location_id, or null.
 * @returns {Promise<bigint|null>}
 */
async function getUserLocationId(userId, tx = prisma) {
  if (userId == null) return null;
  const user = await tx.user.findUnique({
    where: { id: BigInt(userId) },
    select: { locationId: true },
  });
  return user?.locationId ?? null;
}

module.exports = {
  WAREHOUSE_CODE,
  getDefaultWarehouseId,
  getUserLocationId,
};
