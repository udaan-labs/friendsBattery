# Migration: Features 6–12 — Sales, sellers, returns, health

## Sales
- OpenAPI: CreateSale*, SaleRecord*, SaleHistory*, AdminSale*, ScanForSale*
- Fixed zod to accept `filter`/`date` on seller history
- `SellerSalesRepository` / `AdminSalesRepository` gen-client only
- Create bill: scan-for-sale + create sale via repo

## Sellers
- Seller detail OpenAPI + `apiShopsSellersSellerIdGet`
- Sellers list + detail providers off Dio

## Returns / product-units / health
- New OpenAPI tags + generated `ReturnsApi`, `ProductUnitsApi`, `HealthApi`
- Return screen, product lookup, health repository migrated

## Leftovers
- Auth login/register still `Response<void>` (typed response polish later)
- Some admin list endpoints still void where unused by app
- UI still uses `DioException` for error message extraction only
