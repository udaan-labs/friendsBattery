/**
 * Dev wipe: keep SUPER_ADMIN logins only.
 * Deletes other users, locations, catalog, inventory, sales, shipments.
 */
require('dotenv').config();
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function del(label, fn) {
  const result = await fn();
  console.log(`  ${label}: ${result.count}`);
}

async function main() {
  console.log('Wipe — keep SUPER_ADMIN only\n');

  await del('employee_sessions', () => prisma.employeeSession.deleteMany());
  await del('employee_activity_logs', () => prisma.employeeActivityLog.deleteMany());
  await del('employee_attendance', () => prisma.employeeAttendance.deleteMany());
  await del('return_products', () => prisma.returnProduct.deleteMany());
  await del('battery_rents', () => prisma.batteryRent.deleteMany());
  await del('service_bills', () => prisma.serviceBill.deleteMany());
  await del('sales_transactions', () => prisma.salesTransaction.deleteMany());
  await del('customers', () => prisma.customer.deleteMany());
  await del('inventory_transactions', () => prisma.inventoryTransaction.deleteMany());
  await del('shipment_items', () => prisma.newShipmentItem.deleteMany());
  await del('shipments', () => prisma.newShipment.deleteMany());
  await del('transfer_items', () => prisma.shipmentItem.deleteMany());
  await del('transfers', () => prisma.shipment.deleteMany());
  await del('stock_request_items', () => prisma.stockRequestItem.deleteMany());
  await del('stock_requests', () => prisma.stockRequest.deleteMany());
  await del('product_units', () => prisma.productUnit.deleteMany());
  await del('product_catalog_events', () => prisma.productCatalogEvent.deleteMany());
  await del('org_events', () => prisma.orgEvent.deleteMany());
  await del('products', () => prisma.product.deleteMany());
  await del('product_models', () => prisma.productModel.deleteMany());
  await del('product_names', () => prisma.productName.deleteMany());

  await prisma.user.updateMany({
    data: { locationId: null, employeeRoleId: null, parentId: null },
  });

  await del('employees', () => prisma.user.deleteMany({ where: { role: 'EMPLOYEE' } }));
  await del('sellers', () => prisma.user.deleteMany({ where: { role: 'SELLER' } }));
  await del('admins', () => prisma.user.deleteMany({ where: { role: 'ADMIN' } }));
  await del('locations', () => prisma.location.deleteMany());
  await del('employee_roles', () => prisma.employeeRole.deleteMany());

  const left = await prisma.user.findMany({
    select: { userId: true, userName: true, role: true },
    orderBy: { userId: 'asc' },
  });
  console.log('\nRemaining:');
  for (const u of left) console.log(`  [${u.role}] ${u.userId} — ${u.userName}`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
