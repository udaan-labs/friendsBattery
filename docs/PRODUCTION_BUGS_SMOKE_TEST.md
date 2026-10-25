# Production Bugs — Smoke Test (Wave 1 + Wave 2)

Checklist for everything fixed so far. Tick each row. Fail = stop and note ID.

**Prep**
- [ ] Backend running (`npm run dev` / local API)
- [ ] Flutter app on device/emulator against that API
- [ ] Accounts ready: **Admin**, **Seller** (with `location_id`), **Employee** (same shop), optional 2nd seller same admin (peer returns)

---

## A. App / UI (do these first — fastest)

| # | ID | Role | Steps | Pass if |
|---|----|------|-------|---------|
| 1 | **1.3** | Admin | Manage Sellers → tap any seller card | Seller details opens (no `GoException` / crash) |
| 2 | **1.6** | Admin | Open drawer → tap Dashboard / View Stock / Sellers / Logout | Drawer closes; no `There is nothing to pop` |
| 3 | **1.4** | Admin | Checked-in staff screen; prefer staff with GPS ping but weak check-in GPS | List builds; GPS line / Map OK; **no red screen** |
| 4 | **5.1** | Admin or Seller | Verify Product → Scan QR → hold **one** code in frame 2–3s | **One** lookup + **one** details screen (not 3–5 stacked) |
| 5 | **5.1** | same | Cancel scan → Scan again → scan another code | Second scan still works |
| 6 | **5.2** | Seller | Return product → verify serial → **double-tap Submit fast** | Only **one** success (or one error); no duplicate return |
| 7 | **5.2** | Admin | Add Stock → fill form → **double-tap Submit fast** | Only **one** stock update |
| 8 | **1.5** | Seller | Create bill / scan product while API stopped or returning HTML 502 (optional) | Snackbar / fallback message; **app does not crash** in catch |

---

## B. Sales / returns / inventory (core business)

| # | ID | Role | Steps | Pass if |
|---|----|------|-------|---------|
| 9 | **1.1** | Seller or Admin | Sales history → **Unpaid** tab / `?unpaid=true` | **200**, list loads (no 500) |
| 10 | **2.3** | Seller A | Return a battery originally sold by **Seller B** (same admin parent) | Return **allowed** (not 403 “you did not sell”) |
| 11 | **2.3** | Seller | Try return of a sale from **another shop / other admin tree** | Still **403** |
| 12 | **2.1** | Employee | Call or use client: `GET /api/inventory/:productId?location_id=<OTHER_SHOP>` | Only **own** shop data / 404 — **never** other shop serials |
| 13 | **2.1** | Admin | `GET /api/inventory/:productId?location_id=<allowed>` | Still works with assertAccess |
| 14 | **3.1** | Employee | Sell one battery from shop stock | DB: latest `inventory_transactions` `SOLD` has `from_location_id` = employee’s location |
| 15 | **3.1** | Seller | Sell from own stock (no claimByLocation) | `from_location_id` can stay null — OK |
| 16 | **3.2** | Seller (has location) | Customer return → restock AVAILABLE | DB: that `product_units.current_location_id` = seller’s location |
| 17 | **3.2** | Employee | Same shop inventory / sell path | Returned serial **visible** at that shop |

---

## C. Shipments / API / server

| # | ID | Role | Steps | Pass if |
|---|----|------|-------|---------|
| 18 | **1.2** | Admin | Create **two shipments** almost at once (two devices / parallel requests) | Both **2xx**, **different** `shipmentNumber`; no `P2002` 500 |
| 19 | **4.2** | any auth | `POST /api/product-units/verify` with `{}` or no body | **400** validation (not 500 TypeError) |
| 20 | **4.2** | any auth | Same with `{ "identifier": "<valid serial>" }` | **200** or **404** as before (not 500) |
| 21 | **4.1** | ops | Start API → Ctrl+C / stop process | Clean exit log; process dies (no hung node) |
| 22 | **2.2** | ops (optional hard) | Valid JWT + simulate DB blip / kill DB briefly | Prefer **500**, session **not** force-logged-out like 401; bad JWT still **401** |

---

## D. Quick curl helpers (optional)

Replace `TOKEN` and `BASE` (`http://localhost:PORT/api`).

```bash
# 1.1 unpaid (seller/admin token)
curl -s -H "Authorization: Bearer TOKEN" "%BASE%/sales/history?unpaid=true"

# 4.2 empty body → expect 400
curl -s -X POST -H "Authorization: Bearer TOKEN" -H "Content-Type: application/json" -d "{}" "%BASE%/product-units/verify"

# 2.1 employee IDOR (employee token + foreign location id)
curl -s -H "Authorization: Bearer TOKEN" "%BASE%/inventory/1?location_id=99999"
```

**DB checks (3.1 / 3.2)** — run in Prisma Studio / SQL after the UI steps:

```sql
-- after employee sale (3.1)
SELECT id, action, from_location_id, from_user_id
FROM inventory_transactions
WHERE action = 'SOLD'
ORDER BY id DESC
LIMIT 5;

-- after seller return (3.2)
SELECT id, serial_number, status, owner_id, current_location_id
FROM product_units
WHERE serial_number = '<returned-serial>';
```

---

## E. Sign-off

| Wave | Result | Tester | Date |
|------|--------|--------|------|
| Wave 1 P0 (rows 1–3, 8–13, 18, 22) | ☐ Pass ☐ Fail | | |
| Wave 2 P1 (rows 4–7, 14–17, 19–21) | ☐ Pass ☐ Fail | | |

**Failed IDs:** _______________________  
**Notes:** _______________________

---

## Not in this smoke (deferred)

- §6 ponytail deletes / package removals  
- Dio Map guard on `add_stock_screen` / `add_product_hub` (sibling of 1.5)  
- Rent-out ledger `fromLocationId` (sibling of 3.1)
