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

**Never:** Prisma in controllers · Express objects in services · skip auth/RBAC/Zod on protected routes.

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
2. **Immutable ledger** — `inventory_transactions` is **append-only**. Never UPDATE/DELETE history. Ownership/status change = new row.
3. **Roles** (`SUPER_ADMIN → ADMIN → SELLER → EMPLOYEE`)
   - `SUPER_ADMIN` — org root; full multi-WH/shop tools in §1. `parent_id` null. Inventory scope: units owned by `ADMIN` **or** `SUPER_ADMIN`. Stock may target any active `location_id` (warehouse).
   - `ADMIN` — shop admin under a Super Admin (`users.parent_id` → SA). Today many APIs still use global admin scope until §2 re-scopes to own shop.
   - `SELLER` — own inventory, sales, requests; `parent_id` → Admin.
   - `EMPLOYEE` — staff at a location; inventory by `current_location_id = user.location_id` (not owner_id). Job title is `employee_roles` via `users.employee_role_id` (Manager, Cashier, …) — separate from system `Role`. `parent_id` → Admin (or seller’s parent Admin).
   - **Parent links:** `users.parent_id` self-FK. Create seller (`POST /api/auth/register`) sets parent to actor; create employee sets parent to Admin chain.
   - Middleware: `requireRole(...)`, `requireSuperAdmin`, `requireAdmin` (shop Admin only), `requireSuperAdminOrAdmin`, `requireSeller`, `requireEmployee`, combos. Prefer generic `requireRole` for new routes.
   - Employee **attendance**: `POST/GET /api/employee/attendance/*` (check-in / check-out / status) on `employee_attendance` — not the same as app `employee_sessions`.
   - Employee **shipments** (read-only): `GET /api/employee/shipments` — shipments where seller shares `location_id` with the employee. No accept/transfer.
   - Admin **employee view**: `GET /api/shops/employees/:id` — profile + **only** CHECK_IN / CHECK_OUT actions (no sales/inventory).
   - **Create employee**: `POST /api/shops/employees` (admin or seller). Seller always uses own `location_id` (body `location_id` ignored). Admin must pass `location_id` (WAREHOUSE or SHOP). New employees are **active + verified**. Supporting: `GET /api/shops/employee-roles`, `GET /api/shops/locations` (admin), `GET /api/shops/my-staff` (seller).
   - **Locations (shop / warehouse)**: `GET /api/shops/locations?type=SHOP|WAREHOUSE` (admin list), `POST /api/shops/locations` (admin create; optional `latitude`/`longitude`/`allowed_radius` for attendance geofence), `GET /api/shops/locations/:locationId/staff` (admin — sellers + employees at that location). Sellers are assigned to **SHOP** via optional `location_id` on `POST /api/auth/register`.
   Auth from `req.user` (middleware). **Never** trust client-supplied seller/owner IDs for authorization.

---

## Auth & security

- Protected routes: `authenticate` + `requireRole` / `requireSuperAdmin` / `requireAdmin` / `requireSuperAdminOrAdmin` / `requireSeller` / combos
- JWT (`JWT_SECRET`, `JWT_EXPIRES_IN`); middleware sets `req.user` (includes `role`)
- Never expose password hashes
- Always check seller ownership on seller-scoped data

---

## Validation & responses

- Zod schemas in `*.validation.js`; run **before** controller
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
3. Auth + role + Zod
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

---

## Agent rules (short)

1. Read this file + `AGENTS.md` before coding  
2. Same layers as existing modules — no new architecture  
3. Reuse services/repos; no duplicate business logic  
4. No middleware bypass  
5. Swagger before claiming the API “done” for Flutter  
6. Soft-delete only where the schema already uses it — don’t invent global `is_deleted` if the model doesn’t have it  
