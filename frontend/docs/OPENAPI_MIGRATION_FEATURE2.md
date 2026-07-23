# Migration: Feature 2 — Shared inventory (list + detail)

## Files changed

### Backend
- `backend/src/config/swagger.schemas.js` — InventoryList*, InventoryItemDetail*
- `backend/src/modules/inventory/inventory.routes.js` — GET `/api/inventory` and GET `/api/inventory/{productId}` response schemas
- `backend/openapi.json` — re-exported

### Frontend
- `frontend/lib/api/**` — regenerated (no hand-edits)
- `frontend/lib/features/shared/inventory/repository/shared_inventory_repository.dart` — **zero Dio**; uses `InventoryApi`
- `frontend/lib/features/shared/inventory/providers/inventory_provider.dart` — injects `FriendsBatteryApi`
- `frontend/lib/features/shared/inventory/screens/current_inventory_screen.dart` — removed unused Dio import

## OpenAPI changes
- `InventoryListItem` / `InventoryPagination` / `InventoryListPayload` / `InventoryListResponse`
- `InventoryItemDetail` / `InventoryItemDetailResponse`
- Query: `search`, `page`, `limit`, `includeOutOfStock` on GET `/api/inventory`
- Detail includes `serial_numbers`

## Generated
- Full `dart-dio` regenerate + `build_runner`
- SDK constraint set to `>=3.9.2 <4.0.0` after gen
- `apiInventoryGet` → `InventoryListResponse` (was `void`)
- `apiInventoryProductIdGet` → `InventoryItemDetailResponse`

## Removed
- Raw Dio from `SharedInventoryRepository`
- Manual JSON map parsing for inventory list/detail

## Manual test checklist
- [ ] Admin current inventory list loads and paginates
- [ ] Search filters inventory
- [ ] Product detail opens with serial numbers
- [ ] Seller inventory list loads for that seller
- [ ] Pull-to-refresh works

## Verification
- [x] `dart analyze lib/features/shared/inventory` — clean (unused import fixed)
- [x] OpenAPI export succeeds
- [x] Client regenerates without manual model edits

## Next feature
Feature 3: inventory mutations (update-stock, adjust) off Dio in screens.
