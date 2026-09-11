/**
 * PENDING shipment cancel restores IN_SHIPMENT → AVAILABLE.
 * Run: node scripts/test_shipment_cancel.js
 */
require('dotenv').config();
const { prisma } = require('../src/config/db');
const shipmentsService = require('../src/modules/shipments/shipments.service');

function assert(cond, msg) {
  if (!cond) throw new Error(`ASSERT: ${msg}`);
}

async function main() {
  console.log('--- Shipment cancel tests ---\n');

  const admin = await prisma.user.findFirst({ where: { role: 'ADMIN' } });
  const seller = await prisma.user.findFirst({ where: { role: 'SELLER' } });
  assert(admin, 'Need ADMIN');
  assert(seller, 'Need SELLER');

  let unit = await prisma.productUnit.findFirst({
    where: { status: 'AVAILABLE', ownerId: admin.id },
  });
  if (!unit) {
    console.log('SKIP: no AVAILABLE admin unit');
    return;
  }

  const serial = unit.serialNumber;
  console.log(`1) Create then cancel serial=${serial}`);
  const created = await shipmentsService.createShipment(
    { sellerId: Number(seller.id), serial_numbers: [serial] },
    Number(admin.id),
    { id: Number(admin.id), role: 'ADMIN', locationId: admin.locationId }
  );
  assert(created.status === 'PENDING', 'PENDING');

  const mid = await prisma.productUnit.findUnique({ where: { id: unit.id } });
  assert(mid.status === 'IN_SHIPMENT', 'IN_SHIPMENT after create');

  const cancelled = await shipmentsService.cancelShipment(created.shipmentId, {
    id: Number(admin.id),
    role: 'ADMIN',
    locationId: admin.locationId,
  });
  assert(cancelled.status === 'REJECTED', 'REJECTED');

  const after = await prisma.productUnit.findUnique({ where: { id: unit.id } });
  assert(after.status === 'AVAILABLE', 'AVAILABLE after cancel');
  assert(Number(after.ownerId) === Number(admin.id), 'owner unchanged');

  const ship = await prisma.newShipment.findUnique({
    where: { id: BigInt(created.shipmentId) },
  });
  assert(ship.status === 'REJECTED', 'DB REJECTED');

  console.log('2) Double-cancel must fail');
  let failed = false;
  try {
    await shipmentsService.cancelShipment(created.shipmentId, {
      id: Number(admin.id),
      role: 'ADMIN',
      locationId: admin.locationId,
    });
  } catch (e) {
    failed = e.statusCode === 400 || e.status === 400 || /cannot be cancelled/i.test(e.message);
  }
  assert(failed, 'second cancel rejected');

  console.log('\nOK shipment cancel');
}

main()
  .catch((e) => {
    console.error(e);
    process.exitCode = 1;
  })
  .finally(() => prisma.$disconnect());
