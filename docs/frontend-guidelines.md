# Frontend guidelines

FriendsBattery Flutter app (admin + seller). Inventory is **serial units**, not homeowner solar dashboards.

Also: `AGENTS.md` · `docs/OPENAPI.md` · theme code: `frontend/lib/theme/app_theme.dart`

---

## Stack & structure

```text
lib/
├── api/              # GENERATED friends_battery_api — never hand-edit
├── app/              # MaterialApp, go_router
├── core/             # network (Dio), storage, state helpers
├── features/         # admin | seller | auth | shared
│   └── <feature>/    # screens, providers, repository, widgets, models?
└── theme/            # AppTheme
```

| Rule | Detail |
|------|--------|
| State | **Riverpod only** (no flutter_hooks) |
| Screens | `ConsumerWidget` / `ConsumerStatefulWidget` + `ref.watch` |
| Routing | go_router only |
| Network | UI → provider → **repository** → generated `*Api` → Dio (`core/network`) |
| Models | OpenAPI types for API data; thin UI models OK if mapped from OpenAPI |
| Widgets | **Hard rule:** small feature widgets. Screen = shell. No god screens |

---

## API (short)

Full rules: [`OPENAPI.md`](./OPENAPI.md)

```text
UI → Riverpod → Feature Repository → friends_battery_api → Dio → Backend
```

1. Backend Swagger matches handler  
2. Repo root: `npm run gen`  
3. Repository uses generated `*Api` + OpenAPI models  
4. Provider → UI  

**Never:** hand-edit `lib/api/`, feature raw Dio for app APIs, twin `fromJson` API DTOs.  
**OK:** Hive session maps; catch `DioException`; presentation models from OpenAPI.

---

## Design (match `AppTheme`)

Source of truth for colors/shapes is **`AppTheme`**, not a parallel design essay.

| Token | Value | Use |
|-------|--------|-----|
| Primary | `#006B2C` | Primary buttons, focus, positive actions |
| On primary | white | Text on primary |
| Secondary / text | `#1E293B` | Headers, primary text |
| Muted text | `#64748B` | Secondary labels |
| Background | `#FFFFFF` | Scaffold |
| Surface | `#F8FAFC` | Cards |
| Error | `#DC2626` | Errors |
| Success | `#16A34A` | Success / healthy status |
| Font | Inter | All UI |
| Button height | ≥ 48 | Touch targets |
| Button shape | pill (`9999`) | Elevated / primary |
| Input radius | 8 | Fields |
| Card radius | 16 | Cards |
| Spacing | 8px grid | 4 / 8 / 12 / 16 / 24 / 32 |

**Style:** clean light Material 3, high contrast, no gradients, soft elevation (prefer tonal surfaces over heavy shadows).

**Status chips:** tinted background + darker text of same hue (e.g. light green + dark green).

**Lists:** 1px soft divider, ~16px vertical padding per row.

Prefer `AppTheme.themeData` / `AppTheme.*` colors over hard-coded one-offs.

---

## Hard rule — small feature widgets (no god screens)

A screen is a **shell**. Never dump a whole feature into one screen file.

- Split each feature UI into small widgets under `features/<area>/<feature>/widgets/`.
- One widget = one job (form, list, picker, card, empty state).
- Screen `build`: compose those widgets + `ref.watch` + loading/error. No 400-line `build()`.
- Stay in the feature folder. Move to `features/shared` or `lib/shared/widgets` only on a **second** real use.
- Do not extract one-line pass-through wrappers.

## UI habits

- Prefer existing shared widgets under `features/shared` and `lib/shared/widgets`
- Loading / error / empty states on every async screen
- Don’t invent stock-count UIs that ignore serial units — product is unit-based inventory
- Admin vs seller: different feature folders; never show admin-only actions to sellers in UI routing

---

## Commands

```bash
cd frontend
flutter pub get
flutter run
# after API/swagger change (repo root):
npm run gen
```

Env: `--dart-define=ENV_FILE=.env.local` (or `.env.production`). APKs: root `npm run build-local` / `build-prod`.
