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
    const warehouseId =
      user.location?.warehouseId != null ? Number(user.location.warehouseId) : null;
    return {
      kind: 'shop',
      adminId: Number(user.id),
      locationId: Number.isFinite(locationId) ? locationId : null,
      locationType,
      warehouseId: Number.isFinite(warehouseId) ? warehouseId : null,
    };
  }
  return null;
}

/** parentId = admin, same location, or shops under warehouse network */
function _shopOr(scope) {
  const or = [{ parentId: BigInt(scope.adminId) }];
  if (scope.locationId != null) {
    or.push({ locationId: BigInt(scope.locationId) });
  }

  const effectiveWarehouseId =
    scope.locationType === 'WAREHOUSE' ? scope.locationId : scope.warehouseId;

  if (effectiveWarehouseId != null) {
    const whId = BigInt(effectiveWarehouseId);
    or.push({ locationId: whId });
    or.push({ location: { warehouseId: whId } });
  }
  return or;
}

async function _resolveEffectiveScope(prisma, scope) {
  if (!scope || scope.kind !== 'shop' || scope.locationId == null) {
    return scope;
  }
  if (!scope.locationType || (scope.locationType === 'SHOP' && scope.warehouseId == null)) {
    const loc = await prisma.location.findUnique({
      where: { id: BigInt(scope.locationId) },
      select: { type: true, warehouseId: true },
    });
    if (loc) {
      return {
        ...scope,
        locationType: loc.type,
        warehouseId: loc.warehouseId != null ? Number(loc.warehouseId) : scope.warehouseId,
      };
    }
  }
  return scope;
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
  const effectiveWarehouseId =
    scope.locationType === 'WAREHOUSE' ? scope.locationId : scope.warehouseId;
  if (effectiveWarehouseId != null) {
    if (
      target.locationId != null &&
      Number(target.locationId) === Number(effectiveWarehouseId)
    ) {
      return true;
    }
    // Shop staff: callers must include location.warehouseId (parent_id may be SA).
    if (
      target.location?.warehouseId != null &&
      Number(target.location.warehouseId) === Number(effectiveWarehouseId)
    ) {
      return true;
    }
  }
  return false;
}

/** Own location, or (warehouse admin) a shop whose warehouse_id is this warehouse. */
function isLocationInShopScope(loc, scope) {
  if (!scope || scope.kind === 'org') return true;
  if (!loc || scope.kind !== 'shop' || scope.locationId == null) return false;
  if (Number(loc.id) === Number(scope.locationId)) return true;
  const effectiveWarehouseId =
    scope.locationType === 'WAREHOUSE' ? scope.locationId : scope.warehouseId;
  if (
    effectiveWarehouseId != null &&
    loc.warehouseId != null &&
    Number(loc.warehouseId) === Number(effectiveWarehouseId)
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
  return resolveShopActorIds(prisma, scope);
}

/** Self + ADMIN/SELLER/EMPLOYEE in shop/warehouse tree. null = org. */
async function resolveShopActorIds(prisma, scope) {
  if (!scope || scope.kind === 'org') return null;
  if (scope.kind !== 'shop') return [];

  const effectiveScope = await _resolveEffectiveScope(prisma, scope);

  const users = await prisma.user.findMany({
    where: {
      role: { in: [ROLES.ADMIN, ROLES.SELLER, ROLES.EMPLOYEE] },
      OR: _shopOr(effectiveScope),
    },
    select: { id: true },
  });
  const ids = users.map((u) => u.id);
  ids.push(BigInt(effectiveScope.adminId));
  return [...new Set(ids)];
}

/** Own location + shops under warehouse. null = org. */
async function resolveShopLocationIds(prisma, scope) {
  if (!scope || scope.kind === 'org') return null;
  if (scope.kind !== 'shop') return [];
  if (scope.locationId == null) return [];

  const effectiveScope = await _resolveEffectiveScope(prisma, scope);
  const locId = BigInt(effectiveScope.locationId);
  const ids = [locId];
  if (effectiveScope.locationType === 'WAREHOUSE') {
    const shops = await prisma.location.findMany({
      where: { warehouseId: locId },
      select: { id: true },
    });
    for (const s of shops) ids.push(s.id);
  }
  return ids;
}

/** null = not admin. { filter: null } = org-wide. Else SQL scope for activity feed. */
async function resolveActivityScopeFilter(prisma, user) {
  const scope = resolveAdminShopScope(user);
  if (!scope) return null;
  if (scope.kind === 'org') return { filter: null };
  const [actorIds, locationIds] = await Promise.all([
    resolveShopActorIds(prisma, scope),
    resolveShopLocationIds(prisma, scope),
  ]);
  return {
    filter: {
      actorIds: actorIds || [],
      locationIds: locationIds || [],
      adminId: BigInt(scope.adminId),
    },
  };
}

module.exports = {
  resolveAdminShopScope,
  sellerWhereForShopScope,
  staffUserWhereForShopScope,
  isUserInShopScope,
  isLocationInShopScope,
  resolveShopSellerIds,
  resolveShopActorIds,
  resolveShopLocationIds,
  resolveActivityScopeFilter,
};

// Minimal self-check: node backend/src/shared/utils/shop-scope.util.js
if (require.main === module) {
  const assert = require('assert');
  assert.deepStrictEqual(resolveAdminShopScope({ role: 'SUPER_ADMIN', id: 1 }), {
    kind: 'org',
  });
  assert.deepStrictEqual(
    resolveAdminShopScope({ role: 'ADMIN', id: 5, locationId: 9 }),
    { kind: 'shop', adminId: 5, locationId: 9, locationType: null, warehouseId: null }
  );
  assert.deepStrictEqual(
    resolveAdminShopScope({
      role: 'ADMIN',
      id: 5,
      locationId: 9,
      location: { type: 'WAREHOUSE' },
    }),
    { kind: 'shop', adminId: 5, locationId: 9, locationType: 'WAREHOUSE', warehouseId: null }
  );
  assert.ok(
    isUserInShopScope(
      { id: 10, parentId: 99, locationId: 2, location: { warehouseId: 9 } },
      { kind: 'shop', adminId: 5, locationId: 9, locationType: 'WAREHOUSE' }
    )
  );
  assert.ok(
    isUserInShopScope(
      { id: 11, parentId: 99, locationId: 9 },
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
  (async () => {
    const fakePrisma = {
      user: {
        findMany: async ({ where }) => {
          assert.ok(where.role.in.includes('ADMIN'));
          assert.ok(where.role.in.includes('SELLER'));
          assert.ok(where.role.in.includes('EMPLOYEE'));
          return [{ id: 99n }, { id: 10n }];
        },
      },
      location: {
        findMany: async () => [{ id: 2n }],
      },
    };
    const whScope = {
      kind: 'shop',
      adminId: 5,
      locationId: 9,
      locationType: 'WAREHOUSE',
    };
    assert.strictEqual(await resolveShopActorIds(fakePrisma, { kind: 'org' }), null);
    const actors = await resolveShopActorIds(fakePrisma, whScope);
    assert.ok(actors.some((id) => id === 5n));
    assert.ok(actors.some((id) => id === 99n));
    const locs = await resolveShopLocationIds(fakePrisma, whScope);
    assert.ok(locs.some((id) => id === 9n) && locs.some((id) => id === 2n));
    const org = await resolveActivityScopeFilter(fakePrisma, { role: 'SUPER_ADMIN', id: 1 });
    assert.deepStrictEqual(org, { filter: null });
    const wh = await resolveActivityScopeFilter(fakePrisma, {
      role: 'ADMIN',
      id: 5,
      locationId: 9,
      location: { type: 'WAREHOUSE' },
    });
    assert.ok(wh.filter.actorIds.some((id) => id === 99n));
    assert.ok(wh.filter.actorIds.some((id) => id === 5n));
    console.log('shop-scope self-check ok');
  })();
}
