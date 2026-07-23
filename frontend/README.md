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

**OpenAPI:** [docs/OPENAPI.md](./docs/OPENAPI.md) · **Steps:** [instructions/frontend_guidelines.md](./instructions/frontend_guidelines.md) Part 2 · **Agents:** [../AGENTS.md](../AGENTS.md)

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
