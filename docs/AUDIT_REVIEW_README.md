# 📋 FriendsBattery — Complete Code Review & System Audit Guide

This document serves as the master review guide for the **FriendsBattery** system audit. It details system workflows, role-based authorization hierarchies, security/IDOR defense mechanisms, immutable ledger integrity, and identified production-readiness improvements.

---

## 📑 Quick Navigation & Artifacts

- 📄 **Executive Audit PDF Report:** [`docs/FRIENDSBATTERY_DEEP_AUDIT_REPORT.pdf`](file:///c:/Users/DELL/dev/friendsBattery/docs/FRIENDSBATTERY_DEEP_AUDIT_REPORT.pdf)
- 🏗️ **Backend Architecture Rules:** [`docs/architecture.md`](file:///c:/Users/DELL/dev/friendsBattery/docs/architecture.md)
- 📱 **Frontend Guidelines & OpenAPI:** [`docs/OPENAPI.md`](file:///c:/Users/DELL/dev/friendsBattery/docs/OPENAPI.md) & [`docs/frontend-guidelines.md`](file:///c:/Users/DELL/dev/friendsBattery/docs/frontend-guidelines.md)
- 🧪 **Production Smoke Test Plan:** [`docs/PRODUCTION_BUGS_SMOKE_TEST.md`](file:///c:/Users/DELL/dev/friendsBattery/docs/PRODUCTION_BUGS_SMOKE_TEST.md)

---

## 🏛️ 1. System Role Hierarchy & Data Flow

```
👑 SUPER_ADMIN (Org Root / parent_id: null)
   │
   └── 🏢 ADMIN (Shop Owner / parent_id -> Super Admin)
         ├── 🏬 EMPLOYEE (Shop Staff / parent_id -> Admin)
         │     └── Scope: Units physically at current_location_id
         │
         └── 📦 SELLER (Franchise / Retailer / parent_id -> Admin)
               └── Scope: Units allocated with owner_id = user.id
```

### Hierarchy & Scoping Table:

| Role | Database Link | Data & Inventory Scope | Authorization Enforcement |
| :--- | :--- | :--- | :--- |
| **SUPER_ADMIN** | `parent_id = NULL` | Global visibility across all shops, locations & ledgers | Global bypass in `access.util.js` |
| **ADMIN** | `parent_id ➔ SA` | Scoped to own `location_id` and all downstream staff/sellers | `resolveAdminShopScope()` in SQL `WHERE` |
| **EMPLOYEE** | `parent_id ➔ Admin` | Scoped strictly to batteries located at `current_location_id` | `inventory.scope.js` (`resolveUnitScope`) |
| **SELLER** | `parent_id ➔ Admin` | Scoped strictly to batteries with `owner_id = user.id` | `assertAccess(kind: 'owned' / 'sale')` |

---

## 🔄 2. End-to-End Domain Workflows

### 2.1 Employee Attendance & GPS Geofencing
1. **App Initiation:** Employee opens the Flutter app and triggers Check-in.
2. **GPS Validation:** Device coordinates are sent to `POST /api/attendance/check-in`.
3. **Geofence Calculation:** Backend computes distance using the Haversine formula in [`geo.util.js`](file:///c:/Users/DELL/dev/friendsBattery/backend/src/shared/utils/geo.util.js). If distance > assigned shop radius (default 100m), it rejects with `400 Bad Request`.
4. **Location Throttling:** Background real-time tracking enforces a **15-second write throttle** to protect DB write capacity.

### 2.2 Shipment Lifecycle & Atomic Unit Transfer
1. **Creation:** Admin selects serialized units ➔ Status transitions `AVAILABLE` ➔ `IN_SHIPMENT` (Shipment: `PENDING`).
2. **Delivery & Handoff:** Seller views the shipment in `/seller/shipments/:id` and taps **Accept**.
3. **Atomic Execution:** Prisma `$transaction` executes:
   - Shipment status ➔ `RECEIVED`
   - Unit `owner_id` ➔ Seller's User ID
   - Unit `status` ➔ `AVAILABLE`
   - Inserts append-only record in `inventory_transactions` (`SHIPPED`).
4. **Cancellation:** If Admin cancels, units unlock back to Admin's shop location.

### 2.3 Product Units & Immutable Ledger
- **One Row = One Unit:** `product_units` maintains a single row per physical battery with a unique serial number.
- **Append-Only Ledger:** `inventory_transactions` is strictly immutable (zero `UPDATE` or `DELETE` statements).
- **Concurrency Locking:** Sales and rentals enforce optimistic locks (`status: 'AVAILABLE'`) inside transactions to prevent double-selling the same serial.

---

## 🛡️ 3. Security, IDOR & Code Quality Checklist

| Check Area | Verification Result | Notes |
| :--- | :--- | :--- |
| **No IDOR Vulnerabilities** | ✅ **PASSED** | Identity is derived strictly from `req.user` after JWT verification. Client IDs in body/query name the entity, not the permission. |
| **Object-Level Access (`assertAccess`)** | ✅ **PASSED** | By-ID endpoints load the target row, check existence (404), and evaluate `assertAccess(actor, claim)` (403 on mismatch). |
| **SQL-Level Scoping** | ✅ **PASSED** | List endpoints filter via Prisma `where: { ...scope }`, preventing in-memory data leakage. |
| **OpenAPI Client Integration** | ✅ **PASSED** | Flutter repositories exclusively use generated `friends_battery_api` models. |
| **Automated Tests** | ✅ **100% PASS** | **11/11** Backend tests & **41/41** Flutter widget/provider tests pass. |

---

## 🛠️ 4. Action Items & Remediation

The following minor items are flagged for review and implementation:

1. **QR Scanner Rescan Flag:** In [`verify_product_screen.dart`](file:///c:/Users/DELL/dev/friendsBattery/frontend/lib/features/shared/product_lookup/screens/verify_product_screen.dart#L98), reset `_isHandlingScan = false` when reopening the camera to allow continuous scans without closing the screen.
2. **Registration Double-Tap Guard:** In [`auth_controller.dart`](file:///c:/Users/DELL/dev/friendsBattery/frontend/lib/features/auth/providers/auth_controller.dart#L52), add `if (state.isLoading) return;` to `register` and `registerAdmin`.
3. **Sales Query Optimization at Scale:** In [`sales.service.js`](file:///c:/Users/DELL/dev/friendsBattery/backend/src/modules/sales/sales.service.js), replace the in-memory array merging of 2,000+ sales/bills/rents with a PostgreSQL `UNION ALL` query when dealing with millions of records.
4. **Database Indexes:** Add PostgreSQL GIN/trigram indexes on `product_units.serial_number` and `customers.name`.

---

## 🚀 How to Review & Run Tests

### Backend Tests:
```bash
cd backend
npm test
```

### Frontend Tests:
```bash
cd frontend
flutter analyze
flutter test
```
