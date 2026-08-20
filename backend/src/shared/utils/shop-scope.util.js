const ROLES = require('../constants/roles');
const { isSuperAdmin, isAdmin } = require('./role.util');

/**
 * Org vs own-shop scope for Super Admin / shop Admin.
 *
 * - SUPER_ADMIN → { kind: 'org' }
 * - ADMIN → { kind: 'shop', adminId, locationId | null, locationType }
 * - other → null
 *
 * Staff tree = parent_id = admin, same location_id, or (warehouse admin)
 * sellers at shops with location.warehouse_id = warehouse.
 */
function resolveAdminShopScope(user) {
  if (!user || !user.role) return null;
  if (isSuperAdmin(user)) return { kind: 'org' };
  if (isAdmin(user)) {
    const locationId =
      user.locationId != null && user.locationId !== ''
        ? Number(user.locationId)
        : null;
    const locationType = user.location?.type || null;
    return {
      kind: 'shop',
      adminId: Number(user.id),
      locationId: Number.isFinite(locationId) ? locationId : null,
      locationType,
    };
  }
  return null;
}

/** parentId = admin, same location, or shops under warehouse */
function _shopOr(scope) {
  const or = [{ parentId: BigInt(scope.adminId) }];
  if (scope.locationId != null) {
    or.push({ locationId: BigInt(scope.locationId) });
    if (scope.locationType === 'WAREHOUSE') {
      or.push({ location: { warehouseId: BigInt(scope.locationId) } });
    }
  }
  return or;
}

/**
 * Prisma WHERE for sellers under shop admin. null = org (no filter).
 */
function sellerWhereForShopScope(scope) {
  if (!scope || scope.kind !== 'shop') return null;
  return { role: ROLES.SELLER, OR: _shopOr(scope) };
}

/** Prisma WHERE for SELLER|EMPLOYEE under shop admin. null = org. */
function staffUserWhereForShopScope(scope) {
  if (!scope || scope.kind !== 'shop') return null;
  return {
    role: { in: [ROLES.SELLER, ROLES.EMPLOYEE] },
    OR: _shopOr(scope),
  };
}

function isUserInShopScope(target, scope) {
  if (!scope || scope.kind === 'org') return true;
  if (!target || scope.kind !== 'shop') return false;
  if (Number(target.id) === Number(scope.adminId)) return true;
  const parentId = target.parentId != null ? Number(target.parentId) : null;
  if (parentId != null && parentId === Number(scope.adminId)) return true;
  if (
    scope.locationId != null &&
    target.locationId != null &&
    Number(target.locationId) === Number(scope.locationId)
  ) {
    return true;
  }
  if (
    scope.locationType === 'WAREHOUSE' &&
    scope.locationId != null &&
    target.location?.warehouseId != null &&
    Number(target.location.warehouseId) === Number(scope.locationId)
  ) {
    return true;
  }
  return false;
}

/** Own location, or (warehouse admin) a shop whose warehouse_id is this warehouse. */
function isLocationInShopScope(loc, scope) {
  if (!scope || scope.kind === 'org') return true;
  if (!loc || scope.kind !== 'shop' || scope.locationId == null) return false;
  if (Number(loc.id) === Number(scope.locationId)) return true;
  if (
    scope.locationType === 'WAREHOUSE' &&
    loc.warehouseId != null &&
    Number(loc.warehouseId) === Number(scope.locationId)
  ) {
    return true;
  }
  return false;
}

/**
 * Seller ids for sales/shipment filters. Includes admin id (self-bills).
 * null = org (no filter). Includes inactive sellers (history must stay visible).
 */
async function resolveShopSellerIds(prisma, scope) {
  if (!scope || scope.kind === 'org') return null;
  if (scope.kind !== 'shop') return [];

  const where = sellerWhereForShopScope(scope);
  const sellers = await prisma.user.findMany({
    where,
    select: { id: true },
  });
  return [...sellers.map((s) => s.id), BigInt(scope.adminId)];
}

module.exports = {
  resolveAdminShopScope,
  sellerWhereForShopScope,
  staffUserWhereForShopScope,
  isUserInShopScope,
  isLocationInShopScope,
  resolveShopSellerIds,
};

// Minimal self-check: node backend/src/shared/utils/shop-scope.util.js
if (require.main === module) {
  const assert = require('assert');
  assert.deepStrictEqual(resolveAdminShopScope({ role: 'SUPER_ADMIN', id: 1 }), {
    kind: 'org',
  });
  assert.deepStrictEqual(
    resolveAdminShopScope({ role: 'ADMIN', id: 5, locationId: 9 }),
    { kind: 'shop', adminId: 5, locationId: 9, locationType: null }
  );
  assert.deepStrictEqual(
    resolveAdminShopScope({
      role: 'ADMIN',
      id: 5,
      locationId: 9,
      location: { type: 'WAREHOUSE' },
    }),
    { kind: 'shop', adminId: 5, locationId: 9, locationType: 'WAREHOUSE' }
  );
  assert.ok(
    isUserInShopScope(
      { id: 10, parentId: 99, locationId: 2, location: { warehouseId: 9 } },
      { kind: 'shop', adminId: 5, locationId: 9, locationType: 'WAREHOUSE' }
    )
  );
  assert.strictEqual(resolveAdminShopScope({ role: 'SELLER', id: 2 }), null);
  assert.ok(
    isUserInShopScope(
      { id: 10, parentId: 5, locationId: 9 },
      { kind: 'shop', adminId: 5, locationId: 9 }
    )
  );
  assert.ok(
    !isUserInShopScope(
      { id: 10, parentId: 99, locationId: 1 },
      { kind: 'shop', adminId: 5, locationId: 9 }
    )
  );
  assert.ok(
    isLocationInShopScope(
      { id: 2, warehouseId: 9 },
      { kind: 'shop', adminId: 5, locationId: 9, locationType: 'WAREHOUSE' }
    )
  );
  assert.ok(
    !isLocationInShopScope(
      { id: 3, warehouseId: 8 },
      { kind: 'shop', adminId: 5, locationId: 9, locationType: 'WAREHOUSE' }
    )
  );
  console.log('shop-scope self-check ok');
}
