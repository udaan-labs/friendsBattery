# Migration: Feature 4 — Product catalog

## Files changed

### Backend
- `backend/src/config/swagger.schemas.js` — ProductName/Model ids as integers; Create*/List*/ProductNames*/ProductModels*/ProductStockDetails*
- `backend/src/modules/products/products.routes.js` — product-names GET/POST, product-models, list, create product
- `backend/src/modules/inventory/inventory.routes.js` — product-details response schema
- `backend/openapi.json` — re-exported

### Frontend
- `frontend/lib/api/**` — regenerated
- `frontend/lib/features/shared/products/repository/product_catalog_repository.dart` — **new**, gen client only
- `frontend/lib/features/shared/products/providers/product_catalog_providers.dart` — uses repository
- Forms: add_product_name, add_product_model, create_product — no raw Dio

## Next
Feature 5: Admin/Seller dashboards off Dio.
