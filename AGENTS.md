# FriendsBattery — Agent Instructions

Inventory and stock management for batteries: admin (wholesaler) and seller roles. Serial-number unit tracking with an immutable inventory ledger.

## Development philosophy (YAGNI + Ponytail)

**Lead rule:** simplest production-ready change that ships the current MVP need. If a proposal violates YAGNI or Ponytail, reject it and offer a simpler path.

### YAGNI

- Do **not** build future-only features, speculative architecture, unused services/providers/repos/APIs/tables, or generic abstractions “just in case.”
- Prefer clean extension points + a short TODO/comment over scaffolding unused code.
- Avoid: over-engineering, premature optimization, extra tables/APIs, dead Flutter screens/providers/widgets.

### Ponytail (layers — never skip ahead)

1. **Make it work** — smallest working version for this feature only  
2. **Make it clean** — naming, structure, remove mess  
3. **Make it reusable** — only after a second real use appears  
4. **Optimize** — only after profiling shows a real bottleneck  

### Feature flow

One feature at a time: smallest slice → test fully → refactor if needed → next feature. Never juggle multiple unfinished features.

### Architecture (simple + modular)

- Feature-first folders; small files; single responsibility; clear names  
- Backend: existing controller → service → repository → Prisma (no new layers)  
- Repository only where DB access exists; service for business logic  
- Flutter: only screens / providers / models / widgets that are used today  
- No folders/classes “for later”

### Database & API

- Schema/migrations only for current MVP use  
- No tables for future reports, analytics, notifications, product types, integrations (TODO comments OK)  
- Only APIs the Flutter app actually calls; no unused CRUD

### Performance

- No premature optimization. Optimize only when profiling, query cost, API latency, or jank is measured.

### Before every change

1. Required for MVP **now**?  
2. Is there a simpler solution?  
3. Will this code be used **today**?  
4. Can it be added later without a big rewrite?  

If any answer is no → do not implement.

### Pre-submit checklist

- No duplicate logic, unused imports, dead code, or unnecessary abstractions  
- No premature optimization  
- Consistent naming, small focused functions, proper error handling  
- Existing tests / critical paths still work  

## Networking architecture (OpenAPI models + Dio transport)

```text
Flutter UI → Riverpod → Feature Repository → Generated OpenAPI Client (friends_battery_api)
  → Dio (transport + interceptors only) → Backend
```

### Models (OpenAPI — not Dio maps)

- **API request/response types** come from the generated package `friends_battery_api` (e.g. `SaleRecord`, `CreateSaleRequest`, `VerifyProductPayload`).
- The generator is **dart-dio**: Dio is the **HTTP engine**, not the place to invent `Map`/`fromJson` API models.
- **Do not** hand-write parallel API DTOs with `fromJson` that mirror OpenAPI schemas.
- Thin **UI presentation models** are OK only when mapped **from** OpenAPI types in a repository (field projection / display helpers).
- Prefer returning or displaying OpenAPI types over `Map<String, dynamic>` for API data.

### Dio (transport only)

- Shared Dio lives under `frontend/lib/core/network` (base URL, auth interceptor, perf, timeouts).
- Wire that Dio into `FriendsBatteryApi` via `apiClientProvider`.
- Catching `DioException` for messages is fine; building URLs or parsing API JSON with Dio in feature code is not (once a generated method exists).

### Other rules

- **OpenAPI is the contract source of truth.** Fix backend Swagger **before** regenerating the client.
- **Never hand-edit** `frontend/lib/api/` (generated). Regenerate via `generate_api.bat` / `npm run gen`.
- Repositories call generated `*Api` classes only — no raw `dio.get/post` for documented endpoints.
- Keep network I/O out of pure widgets; use providers/repositories.
- No parallel raw-Dio implementation after a feature’s generated API is wired.
- Prefer not adding new raw Dio call sites for endpoints that already have a generated method.

Full roadmap and residual debt: `frontend/docs/OPENAPI_MIGRATION.md`.  
Frontend API workflow: `frontend/instructions/frontend_guidelines.md` (Part 2).

## Stack

| Area | Tech |
|------|------|
| Backend | Node.js, Express 5, Prisma 6, PostgreSQL, Zod, JWT, Swagger |
| Frontend | Flutter (Dart 3.9+), Riverpod, go_router, Dio (**HTTP transport only**) |
| API models | OpenAPI-generated types in `friends_battery_api` — not hand-rolled Dio/JSON maps |
| API client | OpenAPI-generated package at `frontend/lib/api/` (`friends_battery_api`) |
| API tests | OpenCollection YAML under `apiTesting/` |
| Deploy notes | Backend on Railway; DB is PostgreSQL (Prisma `DATABASE_URL` / `DIRECT_URL`) |

## Repository layout

```
FriendsBattery/
├── backend/           # Express API
│   ├── src/
│   │   ├── modules/   # Domain modules (auth, sales, inventory, …)
│   │   ├── shared/    # middleware, utils, constants, events
│   │   ├── config/    # env, db, swagger, logger
│   │   ├── app.js
│   │   └── server.js
│   ├── prisma/        # schema + migrations + seed
│   └── docs/architecture.md
├── frontend/          # Flutter app
│   ├── lib/
│   │   ├── api/       # GENERATED — do not edit by hand
│   │   ├── features/  # admin/, seller/, auth/, shared/
│   │   ├── core/      # network, storage, theme
│   │   └── app/       # app shell + router
│   └── instructions/frontend_guidelines.md
├── apiTesting/        # OpenCollection API tests
├── generate_api.bat   # OpenAPI → Flutter client
└── package.json       # workspace scripts (gen, build-*, tunnel)
```

## Critical domain rules (never violate)

1. **Unit-based inventory**  
   One `product_units` row = one physical battery (serial number). Do not invent shop/product `quantity` / `stock_count` columns. Exception: request quantities on stock requests.

2. **Immutable ledger**  
   `inventory_transactions` is append-only. Never UPDATE or DELETE ledger rows after insert. Ownership/status changes must insert a new transaction.

3. **Roles**  
   - `ADMIN`: all data, inventory, sellers, approvals  
   - `SELLER`: only own inventory, sales, and requests  
   Never trust client-supplied seller/owner IDs for authorization; use `req.user` from auth middleware.

4. **Layered backend**  
   ```
   Route → authenticate → requireRole → Zod validation → Controller → Service → Repository → Prisma → PostgreSQL
   ```
   - Controllers: HTTP only (no Prisma, no business rules)  
   - Services: business logic (no `req`/`res`)  
   - Repositories: only layer that uses Prisma  

## Backend conventions

- Modules live under `backend/src/modules/<name>/` with  
  `*.routes.js`, `*.controller.js`, `*.service.js`, `*.repository.js`, `*.validation.js` as needed.
- Mount routes in `backend/src/app.js` under `/api/...`.
- Use shared helpers: `successResponse` / `errorResponse` from `shared/utils/response`.
- Auth: `authenticate` + `requireAdmin` / `requireSeller` / `requireAdminOrSeller` from shared middleware.
- Response shape:
  - Success: `{ success: true, message, data }`
  - Error: `{ success: false, message, error_code? }`
- Env (required): `PORT`, `DATABASE_URL`, `JWT_SECRET`, `JWT_EXPIRES_IN`. Prisma may also need `DIRECT_URL`.
- Swagger: annotated in routes; serve at `/api-docs` and `/swagger.json`.
- Prefer reusing existing services over duplicating inventory/sales logic.
- Source of truth for architecture detail: `backend/docs/architecture.md`.

### Common backend commands

```bash
cd backend
npm install
npm run dev              # nodemon
npm start
npm run migrate          # prisma migrate dev
npm run prisma:generate
npm run swagger:export   # writes openapi.json
```

## Frontend conventions

- State: **flutter_riverpod only** (no flutter_hooks).
- Screens: `ConsumerWidget` / `ConsumerStatefulWidget` + `ref.watch`.
- Feature structure: `screens/`, `providers/`, `repository/` (or `repositories/`), `widgets/`, `models/` as needed.
- Network path: **UI → Provider → Feature Repository → generated OpenAPI client → Dio transport**.  
  Do not call Dio/raw HTTP from UI or providers when a generated method exists.
- **API data models:** OpenAPI types from `friends_battery_api` (or thin UI models mapped from them). Not Dio maps / hand-rolled API `fromJson`.
- **Never hand-edit** `frontend/lib/api/`. Regenerate after API changes.

### After backend API changes (required order)

1. Update backend **Swagger** (request/response schemas, errors, auth) so OpenAPI matches the real handler.
2. Export + regenerate OpenAPI client from repo root:
   - `cd backend && npm run swagger:export`
   - `generate_api.bat` or `npm run gen`
3. Update feature **repository** to call **generated** APIs only and use **OpenAPI models** (no raw Dio / map parse for that endpoint).
4. Add/update **Riverpod** providers if needed (prefer stable provider APIs).
5. Wire **UI** through providers/repos; display OpenAPI fields or presentation models mapped from them.

### Common frontend commands

```bash
cd frontend
flutter pub get
flutter run
# APKs from repo root:
npm run build-local
npm run build-prod
```

Env files via `--dart-define=ENV_FILE=.env.local` (or `.env.production`). Design notes: `frontend/instructions/frontend_guidelines.md`.

## Workspace scripts (repo root)

| Script | Purpose |
|--------|---------|
| `npm run gen` | Export swagger + generate Flutter API client |
| `npm run build-models` | `build_runner` for API package only |
| `npm run build-local` / `build-prod` | Release APKs with env file |
| `npm run tunnel` | ngrok tunnel to local API |

## What not to do

- Do not put Prisma in controllers or Express objects in services.
- Do not skip auth/RBAC/Zod on protected routes.
- Do not mutate `inventory_transactions` history.
- Do not edit generated OpenAPI Dart under `frontend/lib/api/`.
- Do not commit secrets (`.env`, tokens, service keys).
- Do not expand scope beyond the task (no drive-by refactors).

## When implementing features

1. Read the relevant module(s) and Prisma models first.  
2. Match existing naming and file patterns in that module.  
3. Keep inventory and sales paths unit + ledger correct.  
4. If the API contract changes, regenerate the Flutter client and update repositories/providers.  
5. Prefer small, focused diffs; update architecture docs only when introducing a new pattern.
