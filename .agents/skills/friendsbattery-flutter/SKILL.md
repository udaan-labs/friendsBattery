---
name: friendsbattery-flutter
description: >
  FriendsBattery Flutter skill: feature-first Riverpod UI, OpenAPI-generated
  friends_battery_api models, Dio transport only under core/network, go_router,
  AppTheme, serial-unit inventory UX. Use when building or changing Flutter
  screens, providers, repositories, widgets, routing, or networking in
  frontend/. Triggers: /friendsbattery-flutter, Flutter feature, Riverpod,
  provider, Dio, OpenAPI client, go_router, frontend screen, repository.
---

# FriendsBattery Flutter

**Read before inventing patterns.** This skill is the Flutter playbook for this
repo. Project docs win if anything conflicts:

| Topic | Source |
|-------|--------|
| Networking / models | `docs/OPENAPI.md` |
| UI / structure / theme | `docs/frontend-guidelines.md` |
| Global + domain rules | `AGENTS.md` |

YAGNI + Ponytail: smallest working change for **this** feature only.

---

## Stack (locked)

| Concern | Choice | Never |
|---------|--------|--------|
| State | **flutter_riverpod only** | flutter_hooks, Bloc, package Provider |
| Screens | `ConsumerWidget` / `ConsumerStatefulWidget` + `ref.watch` | StatefulWidget that bypasses Riverpod for app data |
| Network path | UI → provider → **feature repository** → generated `*Api` → Dio | Feature/UI `dio.get/post` for app APIs |
| API models | OpenAPI types from `friends_battery_api` | Hand-rolled API `fromJson` DTOs mirroring Swagger |
| Dio | `lib/core/network` only (shared Dio + interceptors) | New Dio clients in features |
| Routing | **go_router** (`lib/app/router`) | Navigator-only new flows without router |
| Theme | `AppTheme` / `AppTheme.themeData` | Random hard-coded colors when tokens exist |
| Generated code | `frontend/lib/api/` | Hand-edit generated package |

```text
UI (Consumer*) → Riverpod provider → Feature Repository
  → FriendsBatteryApi / *Api → Dio (core/network) → Backend
```

---

## Folder map

```text
frontend/lib/
├── api/                 # GENERATED — npm run gen only
├── app/                 # MaterialApp + go_router
├── core/
│   ├── network/         # Dio, ApiConfig, interceptors, apiClientProvider
│   ├── storage/         # session / tokens
│   └── state/           # shared sync helpers
├── features/
│   ├── admin/ | seller/ | employee/ | auth/ | shared/
│   └── <area>/<feature>/
│       ├── screens/
│       ├── providers/
│       ├── repository/ or repositories/
│       ├── widgets/
│       └── models/      # thin UI models only if needed
├── shared/              # cross-role widgets/utils
└── theme/app_theme.dart
```

- Put role-specific UI under `admin/`, `seller/`, `employee/`.
- Shared inventory/product/staff flows live under `features/shared/`.
- No empty folders “for later.”

### Hard rule — small feature widgets (no god screens)

A screen is a **shell**. Never dump a whole feature into one screen file.

- Split each feature UI into small widgets under that feature’s `widgets/`.
- One widget = one job (form, list, picker, card, empty state).
- Screen `build`: compose those widgets + `ref.watch` + loading/error. No 400-line `build()`.
- Stay in the feature folder. Move to `features/shared` or `lib/shared/widgets` only on a **second** real use.
- Do not extract one-line pass-through wrappers.

---

## Add or change a feature (order)

### A. API already exists in generated client

1. Find the right `*Api` in `friends_battery_api` (e.g. `ShopsApi`, `SalesApi`).
2. Implement/update **feature repository** — call generated methods only.
3. Add/update **Riverpod** providers (`Provider`, `FutureProvider`, `Notifier` as fits existing feature).
4. Wire **screen** as a shell: `ConsumerWidget` + loading / error / empty, composing feature `widgets/`.
5. Route via **go_router** if new destination.
6. Use `AppTheme` + existing shared widgets when possible.

### B. Backend / contract changes

1. Fix backend route + **Swagger** (real `{ success, message, data }`, auth, errors).
2. Repo root: **`npm run gen`** (never hand-edit `frontend/lib/api/`).
3. Then A.2 → A.6.

If generated types look wrong → fix Swagger and regenerate, do not patch generated Dart.

---

## Riverpod patterns (this app)

### Repository provider + data provider

Match existing style (e.g. locations):

```dart
final fooRepositoryProvider = Provider<FooRepository>((ref) {
  return FooRepository(ref.watch(apiClientProvider));
});

final fooListProvider = FutureProvider<List<OpenApiType>>((ref) async {
  return ref.watch(fooRepositoryProvider).list();
});
```

- Inject `FriendsBatteryApi` via `apiClientProvider` from `core/network/api_client_provider.dart`.
- Prefer `ref.watch` in UI; `ref.read` for one-shot actions (submit, logout).
- Controllers/notifiers: follow the nearest feature’s existing pattern (e.g. auth controller) — do not introduce a new state library.

### Screen shell

```dart
class FooScreen extends ConsumerWidget {
  const FooScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(fooListProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (items) {
        if (items.isEmpty) return const Center(child: Text('No items'));
        return ListView(/* ... */);
      },
    );
  }
}
```

Every async surface needs **loading / error / empty**.

### Rules

- No network I/O inside pure widgets — providers/repositories only.
- Invalidate/refetch the same way nearby features already do (e.g. `ref.invalidate`).
- Do not add `flutter_hooks`.

---

## Repository + OpenAPI patterns

### Do

```dart
class LocationsRepository {
  LocationsRepository(this._api);
  final FriendsBatteryApi _api;

  ShopsApi get _shops => _api.getShopsApi();

  Future<List<LocationItem>> list({String? type}) async {
    final response = await _shops.apiShopsLocationsGet(type: type);
    final data = response.data?.data;
    if (data == null) {
      throw Exception(response.data?.message ?? 'Failed to load locations');
    }
    return data.toList();
  }
}
```

- Built requests use generated builders (`CreateLocationRequest((b) { ... })`, `*Builder`).
- Prefer returning **OpenAPI types** to providers/UI.
- Thin UI / session maps are OK **only** when mapped from OpenAPI (auth profile maps, display helpers).
- Catch `DioException` for user-facing messages when the feature already does.

### Don’t

```dart
// BAD — raw Dio for documented app APIs
await dio.get('/api/shops/locations');

// BAD — hand-written twin of OpenAPI schema
MyLocation.fromJson(map);

// BAD — edit generated package
// frontend/lib/api/...
```

### Dio (transport only)

- Create/configure Dio only under `lib/core/network/`.
- Auth headers / base URL / interceptors: existing `createAppDio` + `ApiInterceptor`.
- `apiClientProvider` passes shared Dio into `FriendsBatteryApi` with **empty** generated interceptors (auth is already on shared Dio) — do not “fix” that without reading `api_client_provider.dart`.

---

## Routing (go_router)

- Routes live under `lib/app/router/`.
- New screens: add a path consistent with role (admin vs seller vs employee).
- Never expose admin-only actions on seller/employee routes/UI.
- Deep links / redirects: extend existing router patterns; don’t spawn a second navigator stack for the same flow.

---

## UI / theme

Source: `frontend/lib/theme/app_theme.dart` and `docs/frontend-guidelines.md`.

| Token | Use |
|-------|-----|
| Primary `#006B2C` | Primary actions |
| Surface `#F8FAFC` | Cards |
| Error `#DC2626` / Success `#16A34A` | Status |
| Spacing | 8px grid (4/8/12/16/24/32) |
| Buttons | ≥ 48 height, pill shape |
| Cards | radius 16; inputs radius 8 |

- Prefer shared widgets under `features/shared` and `lib/shared/widgets`.
- Clean light Material 3 — no decorative gradients.
- Status chips: tinted bg + darker same-hue text.

---

## Domain UI (never violate)

1. **Unit-based inventory** — one physical battery = one serial unit. Do not invent shop-level `quantity` / stock_count UIs that ignore serials (request quantities on stock requests are the exception).
2. **Roles** — SUPER_ADMIN / ADMIN / SELLER / EMPLOYEE scopes differ; UI and routes must match role.
3. **No client-trusted owner IDs** for auth decisions — session comes from auth middleware/backend; UI only reflects allowed role.

---

## Testing (when asked)

- Widget tests: pump with `ProviderScope` + overrides.
- Override repositories / `apiClientProvider` — do not hit real network in unit/widget tests.
- Prefer testing repository mapping and provider async states over screenshot-only fluff.
- Official Flutter test skills are fine for `WidgetTester` mechanics; **this skill** owns networking/state layering.

---

## Anti-patterns checklist (reject in review)

- [ ] Raw Dio / hardcoded paths in `features/**` for app APIs  
- [ ] Hand-edited `frontend/lib/api/`  
- [ ] Parallel API DTO `fromJson` classes  
- [ ] flutter_hooks or Bloc for new work  
- [ ] Business network calls inside widgets  
- [ ] New global state outside Riverpod  
- [ ] Stock-count UI that ignores serial units  
- [ ] Scaffolding unused providers/screens “for later”  
- [ ] Ignoring `AppTheme` with one-off palettes  
- [ ] Entire feature UI dumped in one screen file (god screen)  

---

## Commands

```bash
cd frontend
flutter pub get
flutter analyze
flutter run
# API contract change (repo root):
npm run gen
```

Env: `--dart-define=ENV_FILE=.env.local` (or `.env.production`).

---

## Deeper detail

- Network edge cases / gen pipeline: `references/openapi-network.md`
- Feature scaffold checklist: `references/feature-checklist.md`

When unsure: open an existing similar feature (e.g. `features/admin/locations/`) and copy structure, not a blog post architecture.
