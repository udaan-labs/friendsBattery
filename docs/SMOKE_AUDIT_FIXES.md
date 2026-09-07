# Smoke tests — audit fix queue (manual)

Run after pulling this branch. Backend up + Flutter against same API. Use **two shops** (Admin A / Admin B) + one seller/employee per shop.

## P0 IDOR

| # | Steps | Expect |
|---|--------|--------|
| A1 | Shop Admin A `PUT /api/auth/activate` on B’s seller | **403** |
| A1 | Admin A activate own seller | **200** |
| A1 | SA activate anyone | **200** |
| A2 | Admin A adjust with B’s `user_id` | **403** |
| A3 | Admin A removeUnit serial owned by B | **403** |
| A5 | Admin A sales history `?sellerId=` B’s seller | **403** |
| A5 | Admin A history no sellerId | only A’s shop rows |

## P0 stock / returns / ship

| # | Steps | Expect |
|---|--------|--------|
| B1 | Create shipment → cancel | units **AVAILABLE** again; sellable |
| B7 | `POST /api/transfers` | **404** |
| B7 | Flutter create shipment (serial) still works | **200** |
| B4 | Sell serial while concurrent adjust (optional) | one fails clean |
| B2 | Return with restock AVAILABLE → sell same serial | works |
| B3 | Employee sells → shop seller returns | **200** (not 403) |
| B8 | SA ships Admin-owned location stock | create shipment **200** |

## P1 money / UI

| # | Steps | Expect |
|---|--------|--------|
| B6 | CREDIT sale → return | due cleared / paid settled |
| C1 | Service bill screen | no CREDIT tile |
| C2 | Rent out screen | no CREDIT tile |
| C5 | Admin sales PDF | header shows **collected** + booked |
| C6 | Rent return fee > deposit | form error before submit |
| C4 | Inventory scrap | cannot silent qty-destroy without serials |

## Ops

| # | Steps | Expect |
|---|--------|--------|
| C7 | SA/Admin: stock → ship → seller accept → sell → return | full path green |
| C7 | Employee: check-in → create bill | works; no accept shipment |
| C8 | Employee checked out | no location pings |
| C8 | Checked in | pings while on shift |

## Bruno (optional)

- Login admin / seller / employee  
- Shipments create / accept / **cancel** (new)  
- Returns with `restock_as`  
- Old Transfers folder → expect fail/404  
