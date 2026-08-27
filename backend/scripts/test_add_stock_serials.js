/**
 * Add-stock with scanned serials (no STK- placeholders).
 * Run: node scripts/test_add_stock_serials.js
 */
require('dotenv').config();
const { prisma } = require('../src/config/db');
const inventoryService = require('../src/modules/inventory/inventory.service');

function assert(cond, msg) {
  if (!cond) throw new Error(`ASSERT: ${msg}`);
}

async function main() {
  console.log('--- Add-stock serial slice ---\n');

  const admin = await prisma.user.findFirst({ where: { role: 'ADMIN' } });
  assert(admin, 'Need an ADMIN user in DB');
  const product = await prisma.product.findFirst();
  assert(product, 'Need a product row');

  const stamp = Date.now();
  const s1 = `ADD-SCAN-${stamp}-a`;
  const s2 = `ADD-SCAN-${stamp}-b`;
  const actor = { role: admin.role, locationId: admin.locationId };
  const adminId = Number(admin.id);

  console.log('1) Two scanned serials → two AVAILABLE admin units');
  await inventoryService.updateStock(
    adminId,
    {
      productNameId: Number(product.productNameId),
      productModelId: Number(product.productModelId),
      serial_numbers: [s1, s2],
    },
    actor
  );
  const created = await prisma.productUnit.findMany({
    where: { serialNumber: { in: [s1, s2] } },
  });
  assert(created.length === 2, 'two units created');
  for (const u of created) {
    assert(Number(u.ownerId) === adminId, 'owner is admin');
    assert(u.status === 'AVAILABLE', 'AVAILABLE');
    assert(!String(u.serialNumber).startsWith('STK-'), 'not a placeholder');
  }
  const ledger = await prisma.inventoryTransaction.findMany({
    where: { productUnitId: { in: created.map((u) => u.id) } },
  });
  assert(ledger.length === 2, 'two RECEIVED ledger rows');
  for (const t of ledger) {
    assert(t.action === 'RECEIVED', 'RECEIVED');
    assert(Number(t.toUserId) === adminId, 'ledger toUser is admin');
  }
  console.log('   OK\n');

  console.log('2) Duplicate serial → 400');
  let dupFailed = false;
  try {
    await inventoryService.updateStock(
      adminId,
      {
        productNameId: Number(product.productNameId),
        productModelId: Number(product.productModelId),
        serial_numbers: [s1],
      },
      actor
    );
  } catch (e) {
    dupFailed = true;
    assert(e.statusCode === 400, `status ${e.statusCode}`);
    console.log(`   OK (${e.message})\n`);
  }
  assert(dupFailed, 'duplicate must fail');

  await prisma.inventoryTransaction.deleteMany({
    where: { productUnit: { serialNumber: { in: [s1, s2] } } },
  });
  await prisma.productUnit.deleteMany({ where: { serialNumber: { in: [s1, s2] } } });
  console.log('All add-stock serial tests passed.');
}

main()
  .catch((e) => {
    console.error(e);
    process.exitCode = 1;
  })
  .finally(() => prisma.$disconnect());
