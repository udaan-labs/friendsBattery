/**
 * Wipe all business data; keep login accounts (users) + org structure they need.
 *
 * KEEPS:
 *   - users (SUPER_ADMIN, ADMIN, SELLER, EMPLOYEE) — passwords / login
 *   - locations (users.location_id FK)
 *   - employee_roles (users.employee_role_id FK)
 *
 * DELETES:
 *   sessions, attendance, activity logs, returns, sales, customers,
 *   inventory ledger + units, stock requests, transfers, shipments,
 *   products / models / brands
 *
 * Run from backend/:  node scripts/cleanup_db.js
 */
require('dotenv').config();
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function del(label, fn) {
  const result = await fn();
  console.log(`  ${label}: ${result.count}`);
  return result.count;
}

async function main() {
  console.log('Cleaning DB — keep users + locations + employee_roles only...\n');

  const beforeUsers = await prisma.user.count();
  console.log(`Users that will remain: ${beforeUsers}`);

  await prisma.$transaction(async (tx) => {
    // Child / leaf tables first
    await del('employee_sessions', () => tx.employeeSession.deleteMany({}));
    await del('employee_activity_logs', () => tx.employeeActivityLog.deleteMany({}));
    await del('product_catalog_events', () => tx.productCatalogEvent.deleteMany({}));
    await del('org_events', () => tx.orgEvent.deleteMany({}));
    await del('employee_attendance', () => tx.employeeAttendance.deleteMany({}));

    await del('return_products', () => tx.returnProduct.deleteMany({}));
    await del('battery_rents', () => tx.batteryRent.deleteMany({}));
    await del('service_bills', () => tx.serviceBill.deleteMany({}));
    await del('sales_transactions', () => tx.salesTransaction.deleteMany({}));
    await del('customers', () => tx.customer.deleteMany({}));

    await del('inventory_transactions', () => tx.inventoryTransaction.deleteMany({}));
    await del('shipment_items (new)', () => tx.newShipmentItem.deleteMany({}));
    await del('shipments (new)', () => tx.newShipment.deleteMany({}));
    await del('transfer_items', () => tx.shipmentItem.deleteMany({}));
    await del('transfers', () => tx.shipment.deleteMany({}));
    await del('stock_request_items', () => tx.stockRequestItem.deleteMany({}));
    await del('stock_requests', () => tx.stockRequest.deleteMany({}));

    await del('product_units', () => tx.productUnit.deleteMany({}));
    await del('products', () => tx.product.deleteMany({}));
    await del('product_models', () => tx.productModel.deleteMany({}));
    await del('product_names', () => tx.productName.deleteMany({}));
  });

  // Soft-reset lockouts so everyone can log in cleanly
  const reset = await prisma.user.updateMany({
    data: { loginAttempt: 0 },
  });
  console.log(`\nReset login_attempt on ${reset.count} users.`);

  const users = await prisma.user.findMany({
    select: { userId: true, userName: true, role: true, isActive: true },
    orderBy: [{ role: 'asc' }, { userId: 'asc' }],
  });

  console.log('\nRemaining logins:');
  for (const u of users) {
    console.log(`  [${u.role}] ${u.userId} — ${u.userName}${u.isActive ? '' : ' (inactive)'}`);
  }

  console.log('\nDone.');
}

main()
  .catch((e) => {
    console.error('Cleanup failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
