# FriendsBattery — Flutter frontend

Admin + seller inventory app. State: **Riverpod**. Routing: **go_router**.

## Networking (hard rule)

```text
UI → Riverpod → Feature Repository → friends_battery_api → Dio (core/network) → Backend
```

| Use | Do not |
|-----|--------|
| Generated OpenAPI models in `lib/api/` (`friends_battery_api`) | Hand-written API `fromJson` twins |
| Shared Dio only under `lib/core/network` | Feature/UI raw `dio.get/post` for app APIs |
| `npm run gen` after backend swagger changes | Hand-edit anything under `lib/api/` |

**Docs (repo root):** [OPENAPI](../docs/OPENAPI.md) · [frontend guidelines](../docs/frontend-guidelines.md) · [AGENTS](../AGENTS.md)

## Setup

```bash
flutter pub get
flutter run
# env: --dart-define=ENV_FILE=.env.local
```

From **repo root** after API/swagger changes:

```bash
npm run gen
```

APKs (repo root): `npm run build-local` / `npm run build-prod`.
