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
