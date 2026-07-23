# Migration: Feature 1 — Admin stock transfer / shipments

## Files changed

### Backend
- `backend/src/config/swagger.schemas.js` — CreateShipment*, AvailableSerials*, SellersList*, InventoryProducts*
- `backend/src/modules/shipments/shipments.routes.js` — POST /api/shipments OpenAPI matches serial transfer
- `backend/src/modules/inventory/inventory.routes.js` — available-serials response schema
- `backend/src/modules/shops/shops.routes.js` — sellers list response schema
- `backend/src/modules/products/products.routes.js` — inventory-products response schema
- `backend/openapi.json` — re-exported

### Frontend
- `frontend/lib/api/**` — regenerated (no hand-edits)
- `frontend/lib/features/admin/shipments/repository/shipment_repository.dart` — **zero Dio**; uses ShipmentsApi / InventoryApi / ShopsApi / ProductsApi
- `frontend/lib/features/admin/shipments/providers/shipment_provider.dart` — injects `FriendsBatteryApi`
- `frontend/lib/features/admin/shipments/screens/create_shipment_screen.dart` — no raw Dio
- `frontend/lib/features/seller/dashboard/screens/shipment_details_screen.dart` — accept via repository

## OpenAPI changes
- `CreateShipmentRequest` / `CreateShipmentItem` / `CreateShipmentResult` / `CreateShipmentResponse`
- `AvailableSerialsResponse`
- `SellersListResponse` / `SellerShopSummary`
- `InventoryProductsResponse` (+ nested group/model)

## Generated
- Full `dart-dio` regenerate + `build_runner`
- SDK constraint set to `>=3.9.2 <4.0.0` after gen

## Removed
- Raw Dio from `ShipmentRepository`
- Raw Dio from create-shipment inventory-products load
- Raw Dio from seller accept shipment screen

## Manual test checklist
- [ ] Admin create transfer: select seller, product, model, scan serial → success
- [ ] Invalid serial rejected
- [ ] Admin inventory decreases; seller inventory increases after refresh
- [ ] Admin shipments list loads
- [ ] Shipment detail opens
- [ ] Legacy PENDING accept still works if any exist

## Verification
- [x] `dart analyze lib/features/admin/shipments` — no issues
- [x] OpenAPI export succeeds
- [x] Client regenerates without manual model edits
- [ ] Full app `flutter test` / device E2E — run on your machine when convenient

## Next feature
Feature 2/3: shared inventory repository off Dio; seller dashboard shipment detail GET via generated client.
