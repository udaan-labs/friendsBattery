# Migration: Feature 5 — Admin + Seller dashboards

## Backend
- Admin/Seller dashboard stats schemas completed (pendingShipments, todaySalesAmount, recentSales)
- Recent activity + activity history response schemas
- OpenAPI export + client regen

## Frontend
- `DashboardApiService` → FriendsBatteryApi only
- Admin KPI, recent activity, activity history providers off Dio
- Seller KPI, inventory preview, shipment detail off Dio
- Seller shipment detail screen uses `ShipmentDetailModel`

## Next
Feature 6: Sales (create bill, history repos)
