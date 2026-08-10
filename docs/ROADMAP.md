# FriendsBattery — roadmap

**Role chain:** `SUPER ADMIN → ADMIN → SELLER → EMPLOYEE`  
One stream at a time. Work **down** the chain.  
`- [ ]` todo · `- [x]` done.  
**Next:** §6 Hardening / ops.

```text
SUPER ADMIN     all WH + shops · stock any WH · adjust any shop · PDF/GPS all · sell/accept
    └── ADMIN   own shop · add shop (not WH) · sell · accept · PDF/GPS shop
            └── SELLER   own inventory · sell · accept · returns · staff
                    └── EMPLOYEE   create bill · check-in/out · no accept shipment
```

Shared sell tools (§5) once anyone can sell. Obsidian: `obsidian/FriendsBattery/Role Chain Workflow.canvas` · `/todo-sync`.

---

## Already done

- [x] Unit inventory + immutable ledger  
- [x] Stock / products / sellers / locations (shop + warehouse + geofence)  
- [x] Shipments: assign → seller accept  
- [x] Seller: create bill, sales history, returns  
- [x] Employee: check-in/out, location stock, shipments **read-only** (cannot accept)  
- [x] OpenAPI → Flutter client  

---

## 0. Roles foundation (do first)

- [x] Roles: `SUPER_ADMIN` → `ADMIN` → `SELLER` → `EMPLOYEE`  
- [x] Backend `requireRole` + Flutter route gates for all four  
- [x] Parent links: Admin → shops under Super Admin; Seller/Employee → Admin’s shop  

| | Super Admin | Admin | Seller | Employee |
|--|:-----------:|:-----:|:------:|:--------:|
| All WH + shops + staff | ✓ | — | — | — |
| Own shop only | — | ✓ | ✓ stock | ✓ location |
| Add warehouse | ✓ | ✗ | ✗ | ✗ |
| Add shop | ✓ | ✓ | ✗ | ✗ |
| Stock any WH / adjust any shop | ✓ | own shop | ✗ | ✗ |
| Accept shipment | ✓ | ✓ | ✓ | ✗ |
| Create bill / sell | ✓ | ✓ | ✓ | ✓ |
| Check-in / out | — | — | — | ✓ |
| Sales PDF (today/week/month) | ✓ all | ✓ shop | ✗ | ✗ |
| GPS checked-in staff | ✓ all | ✓ shop | ✗ | ✗ |

---

## 1. Super Admin

- [x] View **all** warehouses, shops, and employees (WH + shop)  
- [x] Add / manage warehouses  
- [x] Add stock to **any** warehouse  
- [x] Manually update stock of **any** shop  
- [x] Create / oversee Admins and shops  
- [x] Sell + accept shipment (full access)  
- [x] Sales PDF — **all** shops: today / this week / this month  
- [x] GPS — **all** checked-in warehouse + shop employees + last/current location  

---

## 2. Admin (shop)

- [x] Scope UI/API: **own shop only** (not all warehouses)  
- [x] Add **shop only** — block warehouse create  
- [x] View **own** employees + inventory  
- [x] Sell battery + accept shipment (shop)  
- [x] Manage sellers / employees under this shop  
- [x] Other bill screens for shop (uses §5 types when built)  
- [x] Sales PDF — **own shop only**: today / this week / this month  
- [x] GPS — own shop employees **when checked in** only  

---

## 3. Seller

- [x] Create bill, sales history, returns  
- [x] Accept shipment  
- [x] Re-scope: only **own** inventory / own shop (after §0)  
- [x] Staff under seller/shop consistent with Admin chain  
- [x] Use shared bill upgrades (§5): validation, WhatsApp, print, variants  

---

## 4. Employee

- [x] Check-in / check-out (geofence)  
- [x] View location stock  
- [x] Shipments **read-only** — **cannot** accept  
- [x] **Create bill** (reuse seller flow; stock = employee location)  
- [x] Same serial / unit rules as seller  
- [x] No Super Admin / Admin-only screens  
- [x] Can use service bills when off-site (jumpstart etc. via §5)  

---

## 5. Shared sell tools (after someone can sell)

*Admin · Seller · Employee · Super Admin who create bills — build once.*

### 5.1 Harden current bill
- [x] Stronger validation (price, serials, ownership/location)  
- [x] On sale success → **WhatsApp message to customer**  

### 5.2 Hardware bill print
- [x] Connect to print hardware — **OS system print** (USB/Wi‑Fi/paired via phone dialog; ESC-POS app pairing later if needed)  
- [x] Print bill after successful sale (same path all roles — `SaleSuccessScreen`)  

### 5.3 OTP (reusable)
- [x] Send OTP + verify OTP (backend)  
- [x] Flutter helper reusable on many screens  
- [x] Wire **login** first  
- [x] Ready to reuse on other sensitive screens (same helper)  

### 5.4 Sale variants (unit + price)
- [x] **Scrap battery:** take old battery + sell new at **reduced** price  
- [x] **Mechanic / trade:** battery to mechanic at **lower** price (B2B tier)  

### 5.5 Service bills (little/no stock move)
- [x] **Battery check** — 2-wheeler ₹30 · 4-wheeler ₹70  
- [x] **Battery charging** bill  
- [x] **Jumpstart** — employee goes to other location; customer + place + charge  
- [x] **Inverter service** — fixed charge (~₹1000)  

### 5.6 Battery rent
- [x] Out on rent with **deposit** (e.g. ₹1000)  
- [x] On return: take fee from deposit (e.g. ₹100), **refund rest**; unit back via ledger  

---

## 6. Hardening / ops (suggested)

- [ ] E2E smoke: login → stock → ship → accept → sell → return (all roles that apply)  
- [ ] GPS: no tracking when checked out; only while on shift  

---

## Build order

```text
0 Roles
  → 1 Super Admin
    → 2 Admin
      → 3 Seller re-scope
        → 4 Employee create bill
          → 5 Shared (validate → WA → print → OTP → scrap/mechanic → services → rent)
            → 6 Harden / ops polish
```

Do **not** start §5 rent/service before §4 employee bill works.

---

## Optional later (suggested; only if needed)

- [ ] Location ↔ location stock move (warehouse ↔ shop without full seller reassignment)  
- [ ] Seller stock **request** flow (schema exists; no app flow yet)  
- [ ] Admin attendance **history** reports (beyond live GPS)  
