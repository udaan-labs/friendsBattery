# Migration: Feature 3 — Inventory mutations (update-stock + adjust)

## Files changed

### Backend
- `backend/src/config/swagger.schemas.js` — UpdateStock*, AdjustInventory*
- `backend/src/modules/inventory/inventory.routes.js` — POST update-stock, PATCH adjust schemas
- `backend/openapi.json` — re-exported

### Frontend
- `frontend/lib/api/**` — regenerated (no hand-edits)
- `frontend/lib/features/shared/inventory/repository/shared_inventory_repository.dart` — `updateStock`, `adjustInventory` via InventoryApi
- `frontend/lib/features/admin/inventory/widgets/admin_edit_inventory_bottom_sheet.dart` — no raw Dio
- `frontend/lib/features/admin/inventory/screens/add_stock_screen.dart` — no raw Dio

## OpenAPI changes
- `UpdateStockRequest` — quantity optional; includes `onSale`
- `UpdateStockResult` / `UpdateStockResponse`
- `AdjustInventoryRequest` / `AdjustInventoryResult` / `AdjustInventoryResponse`

## Generated
- `apiInventoryUpdateStockPost` → typed `UpdateStockRequest` / `UpdateStockResponse`
- `apiInventoryAdjustPatch` → typed `AdjustInventoryRequest` / `AdjustInventoryResponse`
- SDK constraint `>=3.9.2 <4.0.0` after gen

## Removed
- Raw Dio from admin quick-edit inventory sheet
- Raw Dio from add-stock screen

## Manual test checklist
- [ ] Add stock with product name/model + quantity
- [ ] Quick edit: change min price / on sale without adding qty
- [ ] Quick edit: add quantity
- [ ] Quick edit: remove quantity (adjust negative)
- [ ] Inventory list refreshes after mutation

## Verification
- [x] OpenAPI export + client regen + build_runner
- [x] `dart analyze` on shared/admin inventory paths

## Next feature
Feature 4: product catalog (product-names, models, products forms) off Dio.
