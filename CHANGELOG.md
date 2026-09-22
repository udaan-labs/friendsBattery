# backend

## 1.2.0

### Minor Changes

- 378d6a1: Harden auth validation, attendance geofencing rules, dead OTP path removal, and enforce shop-scoped access.
- cb3299a: Add returns schema validation, harden sales & return transactions, and apply database migrations.
- 29ec3dc: Enforce immutable inventory ledger, add shipment cancel rollback, drop legacy transfers endpoints, and scope inventory by shop.

### Patch Changes

- df34ba3: Add `npm run backend` to start API and ngrok tunnel together
- 317150b: fix(auth): return 500 on auth DB errors not 401
- 317150b: fix(auth): attach parentId to req.user for peer returns
- 317150b: fix(inventory): ignore client location_id for non-admin item fetch
- 4b1c420: fix(product-units): validate verify body with Zod
- f88eec3: fix(returns): set currentLocationId on restock from actor
- 964e848: fix(sales): set fromLocationId on employee SOLD ledger
- beadc68: fix(server): graceful shutdown on SIGTERM/SIGINT
- 317150b: fix(shipments): generate unique shipment numbers under concurrency
- a3ae7c0: feat(shipment): refactor the workflow of the shipmett

---

# frontend

## 1.2.0

### Minor Changes

- 76c6387: Regenerate OpenAPI client, remove fake CREDIT payment mode, and fix seller dashboard screens.

### Patch Changes

- 317150b: fix(admin): close drawer with Scaffold.closeDrawer
- 317150b: fix(attendance): use mapLat/mapLng in checked-in GPS subtitle
- 317150b: fix(lookup): lock scanner onDetect to prevent duplicate pushes
- 317150b: fix(network): guard Dio error message when body is not Map
- 317150b: fix(sellers): use plural /admin/sellers route on card tap
- 317150b: fix(ui): guard double-submit on return and add-stock
- a3ae7c0: chore: update version to 1.1.3 and add changeset for versioning
