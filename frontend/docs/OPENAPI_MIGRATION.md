# OpenAPI Client Migration — FriendsBattery

**Status:** Features 1–11 migrated. HTTP goes through the generated client; **API data models come from OpenAPI (`friends_battery_api`), not hand-rolled Dio maps.**

**Target architecture:**

```text
Flutter UI
  → Riverpod
    → Feature Repository
      → Generated OpenAPI Client (friends_battery_api)
        → Dio (transport + interceptors only)
          → Backend
```

---

## Models: OpenAPI vs Dio (hard rule)

| Layer | Use | Do **not** use |
|-------|-----|----------------|
| API request/response bodies | Generated types under `friends_battery_api` (`SaleRecord`, `CreateSaleRequest`, `InventoryListItem`, …) | Hand-written `fromJson` / `Map<String, dynamic>` that mirror the API |
| HTTP transport | Shared `Dio` in `core/network` wired into `FriendsBatteryApi` | Raw `dio.get/post(...)` in features for endpoints that already have a generated `*Api` method |
| Error handling | `DioException` catch is OK (Dio still throws on network/HTTP errors) | Building request URLs or decoding API JSON by hand |
| UI-only shapes | Optional thin presentation models **mapped from** OpenAPI DTOs in a repository | Duplicating the same fields as a second JSON-parsed “API model” |

**Generator:** OpenAPI Generator **dart-dio** produces the Dart package. That name means “Dart client that *uses* Dio for HTTP,” **not** “use Dio maps as your domain models.”

Correct:

```dart
final response = await _sales.apiSalesHistoryGet(...);
final rows = response.data?.data?.data?.toList() ?? []; // List<SaleRecord>
```

Wrong:

```dart
final res = await dio.get('/api/sales/history');
final list = (res.data['data']['data'] as List).map((e) => MySale.fromJson(e)).toList();
```

---

## Hard rules

- No big-bang rewrite of unrelated code  
- App must build and work after each change  
- **Never hand-edit** `frontend/lib/api/` — regenerate only  
- Fix OpenAPI on the backend **before** regenerating the client  
- No parallel raw Dio implementation for an endpoint once the generated API exists  

---

## Generation pipeline

```text
backend swagger (JSDoc) → npm run swagger:export → openapi.json
  → openapi-generator dart-dio → frontend/lib/api
  → dart run build_runner (in api package)
```

Root: `generate_api.bat` / `npm run gen`

---

## Layer rules

### Repositories

Must:

- Call only `ref.read(apiClientProvider).getXxxApi()` methods  
- Prefer returning **OpenAPI types**, or map them once to a UI presentation model  
- Keep feature business rules that are not pure HTTP  

Must not:

- Construct URL paths for API I/O  
- Manually encode/decode JSON maps for request/response bodies  
- Call `ApiClient().dio.get/post` when a generated method exists  

### UI / Riverpod

- Prefer OpenAPI models (or thin mapped presentation models) — **never** invent Dio-style `Map`/`fromJson` twins of OpenAPI schemas  
- Providers call repositories (or thin services that use the generated client)  
- `DioException` may be caught for user-facing messages; that does not mean “use Dio models”  

### Dio

- Lives only under `core/network` as transport for `FriendsBatteryApi`  
- Interceptors (auth, perf, errors) stay on that shared Dio instance  

---

## Migration status

| # | Feature slice | State |
|---|---------------|--------|
| 0 | Toolchain (export + gen) | Done |
| 1 | Admin stock transfer / shipments write | Done |
| 2 | Shared inventory | Done |
| 3 | Shipments read + seller accept | Done |
| 4 | Inventory mutations | Done |
| 5 | Product catalog | Done |
| 6 | Auth | Done — `LoginResponse` / `RegisterResponse` typed; session stores Hive-safe map from `LoginUser` |
| 7 | Admin dashboard | Done |
| 8 | Seller dashboard | Done |
| 9 | Sales | Done — repos map `SaleRecord` / `AdminSaleRecord` → UI models |
| 10 | Sellers / shops | Done |
| 11 | Returns | Done — POST + GET via `ReturnsApi` (`ReturnListItem`) |
| 12 | Health | Done |

---

## Residual debt (OpenAPI models first)

1. **Local session user** — Hive still stores a plain map projected from `LoginUser` (storage, not API I/O).  
2. **UI presentation models** — e.g. `SaleSuccessData`, shipment list cards; OK when mapped from OpenAPI or pure local nav state.  
3. **Activate auth** — still `Response<void>` until needed typed.
4. **UI importing `friends_battery_api`** — allowed for pure DTO display; keep network calls out of widgets (use providers/repos).  

---

## Success criteria

- [x] Feature repositories use the generated client for their endpoints  
- [x] Dio is transport-only under `core/network` (plus temporary residual call sites listed above)  
- [x] Sales history maps OpenAPI records, not hand-parsed JSON  
- [ ] 100% of endpoints the app calls exist in OpenAPI with correct schemas  
- [ ] 0 raw Dio feature call sites  
- [ ] 0 duplicate API DTOs with `fromJson` shadowing generated models  
- [x] Client regenerates cleanly; no hand-edits under `frontend/lib/api/`  

---

## Per-feature procedure (if new endpoints land)

1. Contract audit — handler vs `@swagger` vs Zod vs real response  
2. Fix OpenAPI schemas  
3. `npm run swagger:export`  
4. `npm run gen` / `generate_api.bat`  
5. Repository uses generated `*Api` + OpenAPI models  
6. Remove any temporary Dio/map parsing for that feature  
7. `flutter analyze` + manual check  
