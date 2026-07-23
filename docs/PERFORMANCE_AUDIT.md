# Flutter Performance Audit — FriendsBattery

**Date:** 2026-07-23  
**Stack:** Flutter · Riverpod · Dio  
**Symptom:** Backend feels fast in Bruno; app takes ~2s to show data.

---

## Executive summary

Most of the ~2s delay was **not JSON parsing or widget rebuild cost**. It was a combination of:

| Source | Est. cost (device / cold) | Fixed? |
|--------|---------------------------|--------|
| Hard-coded splash delay `Future.delayed(2s)` | **2000 ms** always | Yes → ~400 ms max |
| `FlutterSecureStorage` ×3 on **every** HTTP request | 50–200 ms × 3 reads ≈ **150–600 ms / request** | Yes → in-memory cache |
| Verbose `LogInterceptor` (request/response bodies) | 50–300 ms / large response | Yes → off in release; body logs off in debug |
| Admin dashboard double-fetch (`initState` refresh + `watch`) | 2× network for KPIs/activity | Yes |
| Admin tab switch force-refresh + stock preload | Extra network | Yes |
| Seller: full inventory + 2× shipments endpoints | 2–3 redundant calls | Yes |
| Ngrok free tunnel + missing skip-browser header | Often **200–1500+ ms** vs localhost | Header added; prefer local BASE_URL for dev |
| Recreating `GoRouter` on every auth `watch` | Full app route rebuild on login | Yes → `refreshListenable` |

JSON mapping and typical Riverpod rebuilds are usually **&lt; 20 ms** and were not the bottleneck.

---

## How to measure (debug builds)

After these changes, debug console logs:

```
[PERF] GET /api/dashboard/stats | auth=2ms net=180ms total=182ms status=200 ~bytes=312
[PERF-PROVIDER] kpiProvider total=185ms
[PERF-PROVIDER] recentActivityProvider network+dio=210ms parse=1ms total=211ms items=10
[PERF-PROVIDER] sharedInventoryProvider total=240ms page=1 items=10
```

| Field | Meaning |
|-------|---------|
| `auth` | Time to attach auth headers (should be ~0–5 ms after cache warm) |
| `net` | Wire + server + TLS after auth |
| `total` | Full Dio interceptor span for that call |
| `PERF-PROVIDER` | Provider wall time including Dio + parse |

---

## Findings by task

### 1. Network / parse / provider / rebuild

| Phase | Typical (healthy local API) | Before (common) |
|-------|----------------------------|-----------------|
| Auth header attach | &lt; 5 ms (cache) | 150–600 ms (secure storage) |
| Network (localhost) | 20–80 ms | — |
| Network (ngrok free) | 200–1500 ms | Same |
| JSON parse (dashboard / inventory page) | 1–15 ms | Same |
| Provider overhead | negligible | Same |
| Widget rebuild | 1–16 ms / frame | Same |
| Splash artificial wait | 0–400 ms | **2000 ms** |

### 2. Duplicate API requests

| Duplicate | Where | Fix |
|-----------|--------|-----|
| KPI + activity fetched twice on admin open | `initState.refreshAllData` + widget `watch` | Removed forced init refresh |
| `GET /api/seller/shipments` twice | `sellerPendingShipmentsProvider` + `sellerAllShipmentsProvider` | Pending **derives** from all |
| Full inventory for “recent” list | `sellerRecentInventory` → `sellerInventory` full fetch | Dedicated `limit=4` request |
| Sales history warm after every sale | `DataSync` always `read` notifiers | Only if `ref.exists(...)` |

### 3. Sequential calls that can be parallel

| Before | After |
|--------|-------|
| Secure storage: 3 sequential `read`s | `Future.wait` + memory cache |
| Seller dashboard pull: 5 sequential-ish refreshes (incl. duplicates) | Parallel batch of 3 unique sources |
| Admin pull: already parallel KPI + activity | Unchanged (stock not forced) |

Dashboard screens already fire independent `FutureProvider`s in parallel when multiple widgets `watch` — that was fine.

### 4. Unnecessary invalidations

| Issue | Fix |
|-------|-----|
| Post-sale always spun up admin + seller sales notifiers | `ref.exists` guard |
| Inventory mutation also ok to invalidate KPIs | Kept (correct SSOT) |

### 5. Provider recreation / lifecycle

| Issue | Fix |
|-------|-----|
| `routerProvider` used `ref.watch(authProvider)` → new `GoRouter` each auth change | `ref.listen` + `refreshListenable` |
| No `autoDispose` on hot lists | Intentional for shell-cached SSOT; invalidation on mutation |
| `adminStockDetailsProvider` no longer force-refreshed on dashboard open | Lazy when View Stock tab watches |

### 6. API calls inside `build`

No direct Dio calls inside `build`. Pattern is `ref.watch(FutureProvider)` which is correct.  
**However:** first `watch` of a `FutureProvider` starts the network call during the first build frame — expected.

Forms (Add Stock, Create Product) previously loaded catalogs in `initState`/`setState`; catalog is now Riverpod-backed.

### 7. Rebuild reduction

| Change | Effect |
|--------|--------|
| Stable `GoRouter` | Avoids full `MaterialApp.router` tree churn on login |
| No double dashboard refresh | Fewer loading→data state flips |
| Splash shorter | Faster first meaningful frame |

---

## Environment note (Bruno vs Flutter)

Flutter `BASE_URL` in `.env.local`:

```text
https://flannels-battering-paralyses.ngrok-free.dev
```

Bruno often hits **localhost**. That alone can make Bruno feel “instant” and the app feel “slow”.

**Recommendation for local dev:**

```env
BASE_URL=http://10.0.2.2:3000   # Android emulator → host
# or machine LAN IP for physical device
```

Keep the ngrok header for tunnel use: `ngrok-skip-browser-warning: 1` (now set on Dio).

---

## Changes shipped

| File | Change |
|------|--------|
| `core/storage/auth_token_cache.dart` | In-memory auth tokens |
| `core/storage/secure_storage.dart` | Parallel write; cache-backed read |
| `core/storage/session_manager.dart` | Parallel write; cache set/clear |
| `core/network/api_interceptor.dart` | Use cache; mark perf auth boundary |
| `core/network/perf_interceptor.dart` | Debug timing logs |
| `core/network/api_client.dart` | Perf + slim logs + ngrok header |
| `features/auth/screens/splash_screen.dart` | 2s delay → ≤400 ms |
| `shared/providers/auth_provider.dart` | Warm cache on session restore |
| `app/router/app_router.dart` | Stable router + refreshListenable |
| `admin/dashboard/*` | No double-fetch; stock lazy |
| `seller/dashboard/providers/*` | Deduped shipments; limited recent inventory |
| `core/state/data_sync.dart` | Conditional sales refresh |

---

## Expected impact (order of magnitude)

| Scenario | Before | After (local API) |
|----------|--------|-------------------|
| Cold open → dashboard data | ~2.0–3.5 s | ~0.3–0.8 s |
| Subsequent list open (cached providers) | Instant–stale | Instant if not invalidated |
| Each authenticated API call overhead | +150–600 ms | +0–5 ms |

With **ngrok**, network still dominates (`net` in logs); client overhead should no longer stack on top.

---

## Remaining recommendations

1. **Dev BASE_URL:** Prefer LAN/localhost over ngrok free when profiling.
2. **HTTP cache / ETag** for rarely changing product catalog.
3. **Backend pagination defaults:** Ensure inventory list is never unbounded.
4. **Riverpod 3 / AsyncNotifier** when upgrading packages.
5. **DevTools:** Timeline + Network while reproducing; compare `[PERF]` lines to Bruno timing for the same host.
6. **Optional:** `dio_http2_adapter` only if server supports HTTP/2 and host is stable.
7. **Avoid** calling `DataSync.afterInventoryMutation` from hot loops; it intentionally fans out invalidations.

---

## Verification checklist

1. Run app in **debug**, open admin dashboard — confirm console has `[PERF]` and **no** 2s splash wait.
2. Confirm `auth=` on second request is ~0–5 ms.
3. Pull-to-refresh still updates KPIs/activity.
4. Seller dashboard: one shipments fetch; recent inventory uses `limit=4`.
5. After add stock / sale, inventory and KPIs still update (DataSync).
