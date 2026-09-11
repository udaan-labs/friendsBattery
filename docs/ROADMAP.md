# FriendsBattery — roadmap

**Role chain:** `SUPER ADMIN → ADMIN → SELLER → EMPLOYEE`  
One stream at a time. Work **down** the chain.  
`- [ ]` todo · `- [x]` done.  
**Next:** §6c C7 smoke (`docs/SMOKE_AUDIT_FIXES.md`). Code queue done; you run smoke. (§1 leftover: SA reset password.)

```text
SUPER ADMIN     all WH + shops · stock any WH · adjust any shop · PDF/GPS all · sell/accept
    └── ADMIN   own shop · add shop (not WH) · sell · accept · PDF/GPS shop
            └── SELLER   own inventory · sell · accept · returns · staff
                    └── EMPLOYEE   create bill · check-in/out · no accept shipment
```

Shared sell tools (§5) once anyone can sell. Obsidian: `obsidian/FriendsBattery/Role Chain Workflow.canvas` · `/todo-sync`.

## Completed Tasks & Archive

Completed sections and baseline tasks are archived with timestamps/numbers in [completed_tasks.md](file:///c:/Users/DELL/dev/friendsBattery/docs/completed_tasks.md).

---


## Completed Sections & Archive

Finished sections (§0 through §5) are archived with numbers (`#1` through `#6`) and timestamps in [completed_tasks.md](file:///c:/Users/DELL/dev/friendsBattery/docs/completed_tasks.md).

---

## 1. Super Admin

- [ ] Super Admin: Change password of Admin, Seller, or Employee using employee ID or mobile number  

---

## 6. Hardening — audit fix queue

Source: `docs/FriendsBattery_Business_Logic_Bugs_Hinglish.pdf` + ponytail-audit.  
**Workflow:** one open box → implement → **you test** → `/todo-done` → next. Do **not** batch.

### 6a · IDOR / shop scope (P0 — pehle ye)

- [x] **A1** Shop Admin `PUT /api/auth/activate` — shop-scope only (`assertAccess` / parent chain); no org-wide activate  
- [x] **A2** `adjustInventory` — ignore body `user_id` for permission; scope to actor shop / allowed owners only  
- [x] **A3** `removeUnit` — owner/shop/`assertAccess` before DEFECTIVE  
- [x] **A4** `POST /api/inventory/transfer` — deleted with B7  
- [x] **A5** Admin sales history — client `sellerId` must stay inside shop `sellerIds` (no bypass)  
- [x] **A6** Inventory history + verifyProduct + `getInventoryItem?location_id` — shop-scope Admin (not SA-wide)  
- [x] **A7** Legacy transfer cancel — deleted with B7  

### 6b · Inventory / shipments / returns (P0–P1)

- [x] **B1** Shipment cancel/reject API — restore units `IN_SHIPMENT` → `AVAILABLE` + ledger note  
- [x] **B2** Return restock policy — `RETURNED` → `AVAILABLE` or `DEFECTIVE` (explicit path; not dead-end)  
- [x] **B3** Employee/Admin sale returns — allow return for shop-owned sale (not only `sellerId ===` logged-in seller); Flutter verify/submit same rule  
- [x] **B4** Atomic unit claim on transfer/adjust/remove (`UPDATE … WHERE status/owner` like sales)  
- [x] **B5** Stop trusting / syncing `products.stockQuantity` (derive from units; or remove writes)  
- [x] **B6** Return money — reverse/settle credit or record refund note on return (minimal)  
- [x] **B7** Kill dual transfer systems — remove or quarantine legacy `/api/transfers` + quantity over-commit; one path = serial `/api/shipments`  
- [x] **B8** SA/Admin create shipment — claim units by shop/location ownership (not only `ownerId = req.user.id`) so SA can ship stock they can see  
- [x] **B9** Scrap/adjust ledger honesty — use real actions (`DEFECTIVE`/`ADJUST`), not fake `RETURNED`; set `ownerType` correctly on receive  
- [x] **B10** SA remove-qty vs org-wide list — adjust/write targets match what UI lists (location/owner), no silent SA-only write-off  

### 6c · Flutter money / UX gaps + smoke

- [x] **C1** Service bill — remove fake CREDIT **or** wire real due (ponytail: remove unless pay-later needed)  
- [x] **C2** Rent CREDIT/deposit — same: no fake CREDIT without collect path  
- [x] **C3** Seller sales history — include employee sales for shop credit/due (or clear UI that staff credit is separate)  
- [x] **C4** Admin/SA quantity scrap — serial confirm (no silent random DEFECTIVE)  
- [x] **C5** Admin sales PDF revenue — use `amountPaid` (or show booked vs collected)  
- [x] **C6** Rent return fee — UI cap `fee ≤ deposit` (match backend)  
- [ ] **C7** E2E smoke: login → stock → ship → accept → sell → return (roles that apply) — **YOU run** `docs/SMOKE_AUDIT_FIXES.md`  
- [x] **C8** GPS: no tracking when checked out; only while on shift  

### 6d · Ponytail deletes (bloat — after correctness; still in queue)

- [x] **D1** Delete legacy `/api/transfers` module (Prisma legacy tables kept for later drop)  
- [x] **D2** Delete unused `StockRequest`/`StockRequestItem` from schema (+ migration)  
- [x] **D3** Delete dead OTP/SMS stack + orphan `verify-otp` route + Flutter interceptor allowlist  
- [x] **D4** Delete `GET /api/inventory/history` if still Bruno-only after A6  
- [x] **D5** Drop write-only `EmployeeActivityLog` writes (model kept)  
- [x] **D6** Drop unused `firebase_token` from login validation (DB column kept)  
- [x] **D7** Shrink pass-throughs (partial: EmployeeProfile typedef, DataSync alias; bigger UI shrinks skipped)  


---

## Build order (priority P0 → P1 → P2 → deletes)

```text
Phase1 IDOR:     A1 → A2 → A3 → A5 → A6
Phase2 P0 stock: B1 → (A4+A7+B7+D1 DELETE transfers) → B4 → B2 → B3 → B8
Phase3 P1:       B6 → B5 → B9 → (B10+C4) → C1 → C2 → C3 → C5 → C6
Phase4 smoke:    C7 → C8
Phase5 ponytail: D2 → D3 → D4 → D5 → D6 → D7
```

Ponytail: Flutter never calls legacy transfers → **delete** covers A4+A7+B7+D1 in one step.  
One step → you test → next.

---

## Optional later (product features — not audit bugs)

- [ ] Location ↔ location stock move (warehouse ↔ shop without full seller reassignment)  
- [ ] Seller stock **request** app flow (schema may be deleted in D2; re-add only if product needs it)  
- [ ] Admin attendance **history** reports (beyond live GPS)  
