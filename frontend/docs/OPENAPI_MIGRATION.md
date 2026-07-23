# OpenAPI Client Migration Plan — FriendsBattery

**Status:** Nearly complete — Features 1–11 migrated (repos/screens off raw Dio; Dio only as gen-client transport)  
**Target architecture:**

```text
Flutter UI
  → Riverpod
    → Feature Repository
      → Generated OpenAPI Client (friends_battery_api)
        → Backend
```

**Hard rules:**

- No big-bang rewrite  
- One feature per PR / step  
- App must build and work after every step  
- No raw Dio in repositories when a feature is “done”  
- Never hand-edit `frontend/lib/api/`  
- Fix OpenAPI on the backend **before** regenerating the client  

---

## Current baseline (audit)

### OpenAPI (backend)

| Metric | Value |
|--------|--------|
| Documented paths | ~39 operations |
| Component schemas | ~15 |
| Export | `backend/npm run swagger:export` → `backend/openapi.json` |
| Source | JSDoc `@swagger` on routes + `swagger.schemas.js` |

Known contract issues:

- `POST /api/shipments` docs/schemas **do not match** serial-based transfer implementation  
- Several app endpoints exist in code but have incomplete request/response schemas  
- Auth headers: JWT bearer documented; app also sends `auth-id` (must be in OpenAPI security/params)  
- Enums/status values drift (e.g. unit status naming)  

### Flutter networking (today)

| Style | Where |
|-------|--------|
| **Generated client** | Auth, Shipments, Inventory, Catalog, Dashboards, Sales, Sellers, Returns, Product-units, Health |
| **Raw Dio in repositories** | Auth still catches `DioException` for messages (calls go through AuthApi) |
| **Raw Dio in providers/screens** | Error handling via `DioException` only; no path construction |

**Success criteria progress:** App feature HTTP paths use generated client. Leftover: auth response typing polish; any rarely used void endpoints.

### Generation pipeline

```text
backend swagger (JSDoc) → npm run swagger:export → openapi.json
  → openapi-generator dart-dio → frontend/lib/api
  → dart run build_runner (in api package)
```

Root: `generate_api.bat` / `npm run gen`

---

## Target layer rules

### Repositories (migrated features)

Must:

- Call only `ref.read(apiClientProvider).getXxxApi()` methods  
- Map generated DTOs → domain/UI models when needed  
- Keep feature business rules that are not pure HTTP  

Must not:

- Construct URL paths  
- Manually encode/decode JSON maps for API I/O  
- Call `Dio` / `ApiClient().dio`  

### UI / Riverpod

- UI never imports `friends_battery_api` types  
- Providers call repositories (or thin services that use repositories)  
- Prefer keeping existing provider APIs stable during each step  

### Dio

- Lives only under `core/network` as transport for `FriendsBatteryApi`  
- Interceptors (auth, perf, errors) stay on that shared Dio instance  

---

## Migration order (one feature at a time)

Order balances **risk**, **user impact**, and **dependency** (fix contracts first where transfer already broke the gen client).

| # | Feature slice | Primary endpoints | Current state | Priority |
|---|---------------|-------------------|---------------|----------|
| 0 | **Toolchain baseline** | swagger export + gen scripts + auth security scheme | Partial | First |
| 1 | **Admin stock transfer (shipments write)** | `POST /api/shipments`, available-serials, shops sellers, inventory-products, list/detail | **DONE** — `ShipmentRepository` uses generated client only | High |
| 2 | **Shared inventory** | GET inventory, GET by id | **DONE** — `SharedInventoryRepository` uses generated client only | High |
| 3 | **Shipments read + seller accept** | GET shipments, GET by id, accept | **DONE** with Feature 1 | High |
| 4 | **Inventory mutations** | update-stock, adjust | **DONE** — repo methods + screens off Dio | High |
| 5 | **Product catalog** | product-names, models, products, product-details | **DONE** — ProductCatalogRepository + forms | Medium |
| 6 | **Auth polish** | login, register | Mostly generated | Medium |
| 7 | **Admin dashboard** | stats, recent-activity, activity-history | **DONE** — DashboardApiService gen client | Medium |
| 8 | **Seller dashboard** | stats, inventory preview, shipment detail | **DONE** — providers use gen client / shared repos | Medium |
| 9 | **Sales** | create sale, history, admin history, scan-for-sale | **DONE** | Medium |
| 10 | **Sellers / shops** | sellers list, seller detail | **DONE** | Medium |
| 11 | **Returns / product-units verify** | returns, verify | **DONE** | Lower |
| 12 | **Health / leftovers** | health | **DONE** | Last |

**Do not start #N until #N−1 is merged, green, and checklist signed off.**

---

## Per-feature procedure (mandatory)

1. **Contract audit** — route handler vs `@swagger` vs Zod vs real response  
2. **Fix OpenAPI** — request/response schemas, errors, auth, enums, pagination  
3. **Export** — `npm run swagger:export` (backend)  
4. **Regenerate** — `npm run gen` / `generate_api.bat` (no hand-edits in `lib/api`)  
5. **Migrate repository** — replace Dio with generated API; map DTOs → domain  
6. **Remove duplicates** — old request maps / duplicate models for that feature only  
7. **Test** — feature manual checklist + `flutter analyze` (or build)  
8. **Deliverables** for the step (see below)  
9. **Stop** — do not start the next feature in the same change set  

---

## Deliverables template (every step)

```markdown
## Migration: <Feature name>

### Files changed
- backend: ...
- frontend: ...

### OpenAPI changes
- paths: ...
- schemas: ...

### Backend code changes
- (only if needed for correct docs or response shape)

### Generated
- regenerator run: yes/no
- notes: no manual edits under frontend/lib/api

### Removed
- raw Dio call sites for this feature
- duplicate models

### Manual test checklist
- [ ] ...

### Verification
- [ ] flutter analyze / build OK
- [ ] feature works as before
```

---

## Success criteria (program complete)

- [ ] 100% of endpoints used by the app exist in OpenAPI with correct schemas  
- [ ] 100% of repositories use the generated client  
- [ ] 0 repositories call Dio directly  
- [ ] 0 manual API request classes for network I/O  
- [ ] 0 duplicated API DTOs that shadow generated models  
- [ ] Client regenerates cleanly from OpenAPI with no hand-edits  
- [ ] App compiles and behaves as before  

---

## Relation to YAGNI / Ponytail

- **YAGNI:** Do not migrate unused endpoints or invent abstractions for “all future APIs.”  
- **Ponytail:** Per feature — work (contract correct) → clean (repo uses gen) → only then next feature.  
- **Not premature optimization:** This is maintainability / contract integrity, not micro-perf.  

---

## Next action

**Step 0** is optional tooling hygiene.  

**Step 1 (recommended first real migration):** Admin stock transfer / shipments write path — OpenAPI already wrong for serial transfer; `ShipmentRepository` is pure Dio.

When ready, start **only Feature 1** with: OpenAPI fix → gen → migrate `ShipmentRepository` + related screens → checklist.
