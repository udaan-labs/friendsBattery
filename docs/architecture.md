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
3. **Roles**
   - `ADMIN` — all data, inventory, sellers, approvals
   - `SELLER` — own inventory, sales, requests only
   - `EMPLOYEE` — staff at a location; inventory by `current_location_id = user.location_id` (not owner_id). Job title is `employee_roles` via `users.employee_role_id` (Manager, Cashier, …) — separate from system `Role`.
   Auth from `req.user` (middleware). **Never** trust client-supplied seller/owner IDs for authorization.

---

## Auth & security

- Protected routes: `authenticate` + `requireAdmin` / `requireSeller` / `requireAdminOrSeller`
- JWT (`JWT_SECRET`, `JWT_EXPIRES_IN`); middleware sets `req.user`
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
