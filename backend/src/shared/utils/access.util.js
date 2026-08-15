const { httpError } = require('./http-error');
const { isSuperAdmin, isAdmin, isSeller, isEmployee } = require('./role.util');
const { resolveAdminShopScope, isUserInShopScope } = require('./shop-scope.util');

/**
 * IDOR hard rules (enforce in services after loading the row).
 *
 * 1. Authorize only from `actor` = req.user (auth middleware / DB). Never from
 *    body, query, path, or headers for owner/seller/user/location ids.
 * 2. Role middleware ≠ object access. Every by-id read/write loads the row,
 *    then assertAccess. Missing row → 404. Out of scope → 403.
 * 3. Default deny. Unknown kind or missing fields → 403.
 * 4. SUPER_ADMIN: org (all objects).
 *    ADMIN: shop only (own location + staff parent_id = admin + own ownerId).
 *    SELLER: only rows where ownerId / sellerId / userId === self.
 *    EMPLOYEE: self rows, or same locationId (never another shop’s units).
 * 5. Lists filter in SQL (WHERE), not “fetch all then drop”.
 */

function deny(message = 'Forbidden') {
  throw httpError(403, message);
}

function sameId(a, b) {
  if (a == null || b == null) return false;
  return Number(a) === Number(b);
}

/**
 * @param {object} actor  req.user
 * @param {{
 *   kind: 'self' | 'owned' | 'sale' | 'user' | 'location',
 *   userId?: number,
 *   ownerId?: number,
 *   sellerId?: number,
 *   locationId?: number,
 *   target?: { id?: number, parentId?: number, locationId?: number },
 * }} claim
 */
function assertAccess(actor, claim) {
  if (!actor || actor.id == null) {
    throw httpError(401, 'Unauthorized');
  }
  if (!claim || !claim.kind) deny();
  if (isSuperAdmin(actor)) return;

  switch (claim.kind) {
    case 'self':
      if (!sameId(claim.userId, actor.id)) deny();
      return;

    case 'owned':
      if (sameId(claim.ownerId, actor.id)) return;
      if (isAdmin(actor) && claim.inShop === true) return;
      deny();
      return;

    case 'sale':
      if ((isSeller(actor) || isEmployee(actor)) && sameId(claim.sellerId, actor.id)) {
        return;
      }
      if (isAdmin(actor) && claim.inShop === true) return;
      deny('Forbidden: You cannot view this sale');
      return;

    case 'user': {
      const target = claim.target;
      if (!target) deny();
      if (sameId(target.id, actor.id)) return;
      if (isAdmin(actor)) {
        const scope = resolveAdminShopScope(actor);
        if (scope && isUserInShopScope(target, scope)) return;
      }
      deny();
      return;
    }

    case 'location':
      if (actor.locationId != null && sameId(claim.locationId, actor.locationId)) {
        return;
      }
      if (isAdmin(actor) && claim.inShop === true) return;
      deny();
      return;

    default:
      deny();
  }
}

module.exports = { assertAccess, sameId };

if (require.main === module) {
  const assert = require('assert');
  const seller = { id: 10, role: 'SELLER', locationId: 3 };
  const other = { id: 11, role: 'SELLER', locationId: 3 };
  const admin = { id: 5, role: 'ADMIN', locationId: 3 };
  const sa = { id: 1, role: 'SUPER_ADMIN' };

  assertAccess(sa, { kind: 'sale', sellerId: 99 });
  assertAccess(seller, { kind: 'sale', sellerId: 10 });
  assertAccess(seller, { kind: 'owned', ownerId: 10 });
  assertAccess(seller, { kind: 'self', userId: 10 });
  assertAccess(admin, {
    kind: 'user',
    target: { id: 10, parentId: 5, locationId: 3 },
  });

  assert.throws(() => assertAccess(seller, { kind: 'sale', sellerId: 11 }));
  assert.throws(() => assertAccess(other, { kind: 'owned', ownerId: 10 }));
  assert.throws(() => assertAccess(seller, { kind: 'self', userId: 1 }));
  assert.throws(() =>
    assertAccess(admin, {
      kind: 'user',
      target: { id: 99, parentId: 1, locationId: 1 },
    })
  );
  console.log('access.util self-check ok');
}
