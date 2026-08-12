# Feature checklist (copy this order)

## Before coding

- [ ] Required for MVP **now**? (YAGNI)
- [ ] Similar feature exists? Copy its folder shape.
- [ ] Endpoint already in generated `*Api`? If no → backend Swagger + `npm run gen` first.

## Implement

- [ ] `repository/` — generated `*Api` only; return OpenAPI types
- [ ] `providers/` — `Provider` for repo; `FutureProvider` / notifier for data/actions
- [ ] `screens/` — `ConsumerWidget` + loading/error/empty
- [ ] `widgets/` — only if reused or screen would be huge
- [ ] `models/` — only thin UI projection if OpenAPI type is awkward
- [ ] `go_router` entry if new route; role-correct placement
- [ ] Theme via `AppTheme`; shared widgets if already exist

## Done

- [ ] No raw Dio in feature
- [ ] No hand-edit of `lib/api/`
- [ ] No admin actions on seller/employee UI
- [ ] Inventory UIs respect **serial units**
- [ ] `flutter analyze` clean for touched files

## Reference features

| Pattern | Look at |
|---------|---------|
| Simple list + create | `features/admin/locations/` |
| Auth + session | `features/auth/` |
| Shared Dio client | `core/network/api_client_provider.dart` |
| Router | `app/router/app_router.dart` |
