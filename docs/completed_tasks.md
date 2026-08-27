# Archived Tasks

---

## Baseline Completed Tasks

- [x] Unit inventory + immutable ledger  
- [x] Stock / products / sellers / locations (shop + warehouse + geofence)  
- [x] Shipments: assign → seller accept  
- [x] Seller: create bill, sales history, returns  
- [x] Employee: check-in/out, location stock, shipments **read-only** (cannot accept)  
- [x] OpenAPI → Flutter client  

---

## Completed Sections Archive

### #1 Section 0: Roles Foundation (2026-08-12)
- [x] Roles: `SUPER_ADMIN` → `ADMIN` → `SELLER` → `EMPLOYEE`  
- [x] Backend `requireRole` + Flutter route gates for all four  
- [x] Parent links: Admin → shops under Super Admin; Seller/Employee → Admin’s shop  
- [x] Common / Config: Bypass/hide OTP verification screen across flows without deleting code  

### #2 Section 1: Super Admin (2026-08-12)
- [x] View **all** warehouses, shops, and employees (WH + shop)  
- [x] Add / manage warehouses  
- [x] Add stock to **any** warehouse  
- [x] Manually update stock of **any** shop  
- [x] Create / oversee Admins and shops  
- [x] Sell + accept shipment (full access)  
- [x] GPS — **all** checked-in warehouse + shop employees + last/current location  
- [x] Super Admin Dashboard Stat Cards: Product card opens available products list → tap product to open Configure Product screen  
- [x] Quick Action - Add Product: Replace configure product quick action with Add Product screen  
- [x] Super Admin Location Card/List: Tapping location card opens Location Detail screen with filtered sales view and Export Sales to PDF  
- [x] Quick Action - Employees (Sellers/Staff): Open searchable list of all employees  
- [x] Dashboard Recent Activity Filter: Add filters for Today, This Week, and Date Range  

### #3 Section 2: Admin (shop) (2026-08-12)
- [x] Scope UI/API: **own shop only** (not all warehouses)  
- [x] Add **shop only** — block warehouse create  
- [x] View **own** employees + inventory  
- [x] Sell battery + accept shipment (shop)  
- [x] Manage sellers / employees under this shop  
- [x] Other bill screens for shop  
- [x] Sales PDF — **own shop only**: today / this week / this month  
- [x] GPS — own shop employees **when checked in** only  

### #4 Section 3: Seller (2026-08-12)
- [x] Create bill, sales history, returns  
- [x] Accept shipment  
- [x] Re-scope: only **own** inventory / own shop  
- [x] Staff under seller/shop consistent with Admin chain  
- [x] Use shared bill upgrades (§5): validation, WhatsApp, print, variants  

### #5 Section 4: Employee (2026-08-12)
- [x] Check-in / check-out (geofence)  
- [x] View location stock  
- [x] Shipments **read-only** — **cannot** accept  
- [x] **Create bill** (reuse seller flow; stock = employee location)  
- [x] Same serial / unit rules as seller  
- [x] No Super Admin / Admin-only screens  
- [x] Can use service bills when off-site  

### #6 Section 5: Shared Sell Tools (2026-08-12)
- [x] Stronger validation & WhatsApp on sale success  
- [x] Hardware bill print (OS system print)  
- [x] Send & verify OTP  
- [x] Scrap battery & Mechanic price  
- [x] Service bills (Check, Charging, Jumpstart, Inverter)  
- [x] Battery rent with deposit & refund  

### #7 Section 1 follow-up: SA add shop + warehouse admin (2026-08-14)
- [x] Super Admin quick action Add Admin: create **shop admin** and **warehouse admin** (`POST /api/auth/register-admin` accepts SHOP or WAREHOUSE)

### #8 Section 1 follow-up: Add Product = name + model (2026-08-14)
- [x] Quick action **Add Product** opens add name/model (`/admin/add-product`), not configure pricing

### #9 Section 1 follow-up: product card + Add Product UI (2026-08-14)
- [x] Top PRODUCTS card: list all catalog names, tap → configure product
- [x] SA Add Product uses the same Admin form layout (name/model card, not a separate SA form)

