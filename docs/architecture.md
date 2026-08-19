# Backend architecture

Source of truth for backend code. **Follow this.** New patterns → update this file first.

Also: repo root `AGENTS.md` (domain + Flutter OpenAPI). Stack: Node, Express 5, Prisma 6, PostgreSQL, Zod, JWT, Swagger.

---

## Request path (never skip)

```text
Route → authenticate → requireRole → Zod validate → Controller → Service → Repository → Prisma → PostgreSQL
```

| Layer | Does | Does not |
|-------|------|----------|
| **Route** | Path, middleware order, Swagger JSDoc | Business logic |
| **Controller** | `req` → service → `successResponse` / `errorResponse` | Prisma, business rules |
| **Service** | Business rules, multi-repo orchestration | `req` / `res` |
| **Repository** | Prisma only | Permissions, pricing rules |
| **Middleware** | JWT auth, RBAC, Zod | Domain writes |

**Never:** Prisma in controllers · Express objects in services · skip auth/RBAC/Zod on protected routes · trust frontend payload for identity/permission.

### Hard rule — never trust the frontend (no IDOR)

Every API: `authenticate` + `requireRole` + Zod (`*.validation.js`) + object access.

- Identity, role, owner, seller, location come from `req.user` only. Never from body / query / path / headers.
- Client ids name the *record*, never the *permission*.
- By-id: load row → missing 404 → `assertAccess` → out of scope 403. Default deny.
- Lists: SQL `WHERE` scoped to the actor. Never fetch-all-then-filter in JS.
- No protected route without a Zod schema. Frontend validation is not security.

---

## Layout

```text
backend/
├── prisma/                 # schema, migrations, seed
├── src/
│   ├── app.js              # mount /api/...
│   ├── server.js
│   ├── config/             # env, db, swagger, logger
│   ├── modules/<name>/     # *.routes, *.controller, *.service, *.repository, *.validation
│   └── shared/
│       ├── middleware/     # auth, role, validation, error
│       ├── utils/          # response, pagination, …
│       ├── constants/
│       └── events/
```

Doc: repo root `docs/architecture.md`. One domain = one module folder. Reuse existing inventory/sales services instead of copying.

---

## Critical domain rules

1. **Unit inventory** — one `product_units` row = one physical battery (serial). No shop/product stock-count columns (request `quantity` on stock requests is OK).
2. **Immutable ledger** — `inventory_transactions` is **append-only**. Never UPDATE/DELETE history. Ownership/status change = new row. Catalog setup is append-only in `product_catalog_events`. Org setup (shop / warehouse / admin / seller / employee) is append-only in `org_events`. Both feed admin Activity History.
3. **Roles** (`SUPER_ADMIN → ADMIN → SELLER → EMPLOYEE`)
   - `SUPER_ADMIN` — org root; full multi-WH/shop tools in §1. `parent_id` null. Inventory scope: units owned by `ADMIN` **or** `SUPER_ADMIN`. Stock may target any active `location_id` (warehouse).
   - `ADMIN` — shop admin under a Super Admin (`users.parent_id` → SA). **Own shop** = `users.location_id` (SHOP); staff tree = `parent_id` = admin. Inventory = units with `ownerId` = admin (not shared SA pool). Scope helper: `shared/utils/shop-scope.util.js`.
   - `SELLER` — own inventory only (`ownerId` = self); sales/returns/shipments own only; `parent_id` → Admin; staff via `GET /shops/my-staff` = same shop location **and** Admin parent chain.
   - `EMPLOYEE` — staff at a location; inventory by `current_location_id = user.location_id` (not owner_id). Job title is `employee_roles` via `users.employee_role_id` (Manager, Cashier, …) — separate from system `Role`. `parent_id` → Admin (or seller’s parent Admin).
   - **Parent links:** `users.parent_id` self-FK. Create seller (`POST /api/auth/register`) sets parent to actor; create employee sets parent to Admin chain.
   - Middleware: `requireRole(...)`, `requireSuperAdmin`, `requireAdmin` (shop Admin only), `requireSuperAdminOrAdmin`, `requireSeller`, `requireEmployee`, combos. Prefer generic `requireRole` for new routes.
   - Employee **attendance**: `POST/GET /api/employee/attendance/*` (check-in / check-out / status) on `employee_attendance` — not the same as app `employee_sessions`.
   - Employee **shipments** (read-only): `GET /api/employee/shipments` — shipments where seller shares `location_id` with the employee. No accept/transfer.
   - Admin **employee view**: `GET /api/shops/employees/:id` — profile + **only** CHECK_IN / CHECK_OUT actions (no sales/inventory).
   - **Create employee**: `POST /api/shops/employees` (admin or seller). Seller always uses own `location_id` (body `location_id` ignored). Admin must pass `location_id` (WAREHOUSE or SHOP). New employees are **active + verified**. `user_id` optional (empty → next `EMP001`). Preview next id: `GET /api/shops/employees/next-user-id`. Supporting: `GET /api/shops/employee-roles`, `GET /api/shops/locations` (admin), `GET /api/shops/my-staff` (seller).
   - **Move admin/seller/employee**: `PATCH /api/shops/employees/:id/location` `{ location_id }` (SA or shop Admin). ADMIN, SELLER, or EMPLOYEE. Shop Admin: person must be in their shop. Dest picker: shops + warehouses (seller: shops only). Employee dest must have no EMPLOYEE; reject if checked in. Admin: parent stays SA. Seller/employee parent: dest shop ADMIN else actor. Inventory does not move.
   - **Staff per location:** multiple `ADMIN`s and multiple `SELLER`s allowed. At most one `EMPLOYEE`. Create employee returns 409 if that role is already assigned.
   - **Deactivate accounts (SA):** `GET /api/users?role=ADMIN|SELLER|EMPLOYEE`, `PATCH /api/users/:id/active` `{ is_active }`. Sets `users.is_active` only (login + JWT already reject inactive). Cannot change self or SUPER_ADMIN.
   - **Locations (shop / warehouse)**: `GET /api/shops/locations?type=SHOP|WAREHOUSE` (admin list), `POST /api/shops/locations` (admin create; optional `latitude`/`longitude`/`allowed_radius` for attendance geofence), `PATCH /api/shops/locations/:locationId` (admin update name / address / geofence; SA any location, shop Admin own shop only). **SHOP** requires `warehouse_id` of an active warehouse; **WAREHOUSE** has no parent. `GET /api/shops/locations/:locationId/staff` (admin — admin + sellers + employees at that location). Sellers are assigned to **SHOP** via optional `location_id` on `POST /api/auth/register`.
   Auth from `req.user` (middleware). **Never** trust client-supplied seller/owner IDs for authorization.

4. **IDOR** — `shared/utils/access.util.js` (`assertAccess`). Role ≠ row access. Load by id, then assert. Default deny. Lists filter in SQL.

---

## Auth & security

- Protected routes: `authenticate` + `requireRole` / `requireSuperAdmin` / `requireAdmin` / `requireSuperAdminOrAdmin` / `requireSeller` / combos
- JWT (`JWT_SECRET`, `JWT_EXPIRES_IN`); middleware sets `req.user` (includes `role`)
- Never expose password hashes
- Always check seller ownership on seller-scoped data

### IDOR (hard rules)

`requireRole` answers “may this role call this URL?”. It does **not** answer “may this user see *this* sale / unit / seller?”.

| Rule | Do |
|------|----|
| Subject | Only `req.user` from `authenticate` (loaded from DB). |
| Object | Path/query/body ids name the *record*, never the *permission*. |
| By-id | `find` → if missing 404 → `assertAccess(actor, { kind, ... })` → 403 if out of scope. |
| Default | Deny unknown `kind` or missing fields. |
| Lists | `WHERE owner_id / seller_id / location_id` in the repository. No unscoped `findMany` then JS filter. |
| SA | Org-wide. |
| Admin | Shop: `resolveAdminShopScope` + `isUserInShopScope` / `resolveShopSellerIds`. Not another admin’s shop. |
| Seller | `ownerId` or `sellerId` or `userId` === `actor.id`. |
| Employee | Self, or units/shipments at `actor.locationId`. |

```js
const { assertAccess } = require('../../shared/utils/access.util');
// after load:
assertAccess(actor, { kind: 'sale', sellerId: sale.sellerId, inShop });
assertAccess(actor, { kind: 'owned', ownerId: unit.ownerId });
assertAccess(actor, { kind: 'user', target: staffUser });
assertAccess(actor, { kind: 'self', userId: attendance.userId });
assertAccess(actor, { kind: 'location', locationId: unit.currentLocationId });
```

New endpoint checklist: auth + role + **assertAccess (or scoped WHERE)** before return/update.

---

---

## Validation & responses

- Zod schemas in `*.validation.js` on **every** protected route; run **before** controller
- Frontend checks are UX only. Backend Zod + `req.user` + `assertAccess` are the real gate.
- Success: `{ success: true, message, data }`
- Error: `{ success: false, message, error_code? }`
- Helpers: `shared/utils/response` (`successResponse` / `errorResponse`)

---

## OpenAPI (Flutter contract)

Swagger = contract for generated client `friends_battery_api`.

| Step | Action |
|------|--------|
| 1 | `@swagger` on routes + schemas in `config/swagger.schemas.js` as needed |
| 2 | Match real handler (body, `{ success, message, data }`, errors, auth) |
| 3 | `npm run swagger:export` or repo root **`npm run gen`** (also regenerates Flutter) |
| 4 | Docs: `/api-docs`, `/swagger.json` |

No frontend-facing route without accurate OpenAPI. Frontend: `docs/OPENAPI.md`.

---

## New endpoint checklist

1. Module files under `src/modules/<name>/` (match neighbors)
2. Mount in `app.js` under `/api/...`
3. Auth + role + Zod + **IDOR** (`assertAccess` or scoped `WHERE`)
4. Controller thin → service → repository
5. Swagger complete
6. `npm run swagger:export` (or `npm run gen` if Flutter needs types)

---

## Commands

```bash
cd backend
npm run dev              # nodemon
npm start
npm run migrate          # prisma migrate dev
npm run prisma:generate
npm run swagger:export   # openapi.json
```

Env: `PORT`, `DATABASE_URL`, `JWT_SECRET`, `JWT_EXPIRES_IN` (+ `DIRECT_URL` if Prisma needs it).

---

## Inventory mental model

```text
Admin stock → (shipment/transfer) → Seller stock → sale → customer
                 every move: UPDATE unit status/owner + INSERT ledger row
```

Ledger is the history; units are current state. Do not invent parallel quantity tables for MVP stock.

`GET /api/inventory?location_id=` (SA/Admin): available units with `current_location_id` = that location. Seller/Employee ignore the query.

---

## Agent rules (short)

1. Read this file + `AGENTS.md` before coding  
2. Same layers as existing modules — no new architecture  
3. Reuse services/repos; no duplicate business logic  
4. No middleware bypass  
5. Swagger before claiming the API “done” for Flutter  
6. Soft-delete only where the schema already uses it — don’t invent global `is_deleted` if the model doesn’t have it  
