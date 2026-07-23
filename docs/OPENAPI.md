# OpenAPI networking (frontend)

**Standard — migration done.** Do not restructure folders for this.

```text
UI → Riverpod → Feature Repository → friends_battery_api (*Api)
  → Dio (lib/core/network only) → Backend
```

## Rules

| Do | Don't |
|----|--------|
| API models = generated `friends_battery_api` | Hand-written `fromJson` twins of API schemas |
| Dio only under `core/network` (transport + interceptors) | Feature/UI `dio.get/post` for app APIs |
| Regenerate with `npm run gen` | Hand-edit `frontend/lib/api/` |
| Fix **backend Swagger** first if types wrong | Patch generated Dart |

`dart-dio` = client uses Dio for HTTP, **not** “use Dio maps as models.”

```dart
// OK
final rows = (await _sales.apiSalesHistoryGet(...)).data?.data?.data?.toList() ?? [];

// Not OK
final res = await dio.get('/api/sales/history');
MySale.fromJson(...);
```

## New / changed API

1. Backend route + **Swagger** matching real `{ success, message, data }` / errors / auth  
2. Repo root: **`npm run gen`**  
3. Feature **repository** → generated `*Api` + OpenAPI types (optional thin UI map once)  
4. Riverpod provider → UI  

## Allowed local (not API DTOs)

- Hive / session maps projected from OpenAPI user types  
- Nav / form / presentation models mapped **from** OpenAPI or pure local  
- Catching `DioException` for messages  

## Pipeline

```text
backend @swagger → swagger:export → openapi.json
  → openapi-generator dart-dio → frontend/lib/api → build_runner
```

Also: `AGENTS.md`, `docs/frontend-guidelines.md` (API section).
