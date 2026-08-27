# OpenAPI + Dio (FriendsBattery)

## Pipeline

```text
backend Swagger annotations
  → npm run gen (swagger export + openapi-generator dart-dio + build_runner)
  → frontend/lib/api (friends_battery_api)
  → feature repository uses *Api
```

## Client wiring

- Shared Dio: `lib/core/network/api_client.dart` (`createAppDio`)
- Provider: `lib/core/network/api_client_provider.dart`
  - `dioProvider` → shared Dio
  - `apiClientProvider` → `FriendsBatteryApi(dio:, basePathOverride:, interceptors: const [])`
- Auth on requests: app `ApiInterceptor`, not stacked OAuth interceptors from the generator

## Response shape

Backend success envelope: `{ success, message, data }`.  
Generated responses often nest as `response.data?.data` (OpenAPI wrapper + payload). Null-check and throw with `message` when payload missing.

## Errors

- Prefer repository-level mapping of `DioException` → `Exception(message)` using `e.response?.data['message']` when present.
- UI shows error via `AsyncValue.error` / snackbars already used in that feature.

## Regeneration

```bash
# repo root
npm run gen
```

If types wrong: fix backend Swagger first. Never edit generated Dart under `frontend/lib/api/`.

## Allowed non-OpenAPI models

- Hive / session maps projected from login user fields
- Form/nav/presentation helpers mapped **from** OpenAPI types
- Local-only UI state (tab index, search query string)

Not allowed: twin DTOs that re-declare API schemas with hand `fromJson`.
