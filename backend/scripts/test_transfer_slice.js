/**
 * Manual / CI-friendly tests for Admin → Seller serial transfer.
 * Requires DATABASE_URL + a seeded admin + seller + at least one AVAILABLE admin unit.
 *
 * Run: node scripts/test_transfer_slice.js
 * Or with env: PORT/JWT already not required — exercises service layer via repository+service.
 */
require('dotenv').config();
const { prisma } = require('../src/config/db');
const shipmentsService = require('../src/modules/shipments/shipments.service');

function assert(cond, msg) {
  if (!cond) throw new Error(`ASSERT: ${msg}`);
}

async function main() {
  console.log('--- Transfer slice tests ---\n');

  const admin = await prisma.user.findFirst({ where: { role: 'ADMIN' } });
  const seller = await prisma.user.findFirst({ where: { role: 'SELLER' } });
  assert(admin, 'Need an ADMIN user in DB');
  assert(seller, 'Need a SELLER user in DB');

  // Pick or create one AVAILABLE admin unit for happy path
  let unit = await prisma.productUnit.findFirst({
    where: { status: 'AVAILABLE', owner: { role: 'ADMIN' } },
    include: { product: true },
  });

  if (!unit) {
    console.log('SKIP happy-path: no AVAILABLE admin unit. Seed stock first.');
  } else {
    const product = unit.product;
    const serial = unit.serialNumber;
    const sellerBefore = await prisma.productUnit.count({
      where: { productId: product.id, ownerId: seller.id, status: 'AVAILABLE' },
    });
    const adminBefore = await prisma.productUnit.count({
      where: { productId: product.id, status: 'AVAILABLE', owner: { role: 'ADMIN' } },
    });

    console.log(`1) Successful transfer of serial=${serial}`);
    const result = await shipmentsService.createShipment(
      {
        sellerId: Number(seller.id),
        items: [
          {
            product_name_id: Number(product.productNameId),
            product_model_id: Number(product.productModelId),
            serial_numbers: [serial],
          },
        ],
      },
      Number(admin.id)
    );

    assert(result.transferredUnits === 1, 'transferredUnits === 1');
    assert(Array.isArray(result.inventory), 'inventory array present');

    const updated = await prisma.productUnit.findUnique({ where: { id: unit.id } });
    assert(Number(updated.ownerId) === Number(seller.id), 'owner is seller');
    assert(updated.ownerType === 'SELLER', 'ownerType SELLER');
    assert(updated.status === 'AVAILABLE', 'status AVAILABLE');

    const tx = await prisma.inventoryTransaction.findFirst({
      where: { productUnitId: unit.id, action: 'TRANSFERRED' },
      orderBy: { id: 'desc' },
    });
    assert(tx, 'inventory_transactions TRANSFERRED row exists');

    const sellerAfter = await prisma.productUnit.count({
      where: { productId: product.id, ownerId: seller.id, status: 'AVAILABLE' },
    });
    const adminAfter = await prisma.productUnit.count({
      where: { productId: product.id, status: 'AVAILABLE', owner: { role: 'ADMIN' } },
    });
    assert(sellerAfter === sellerBefore + 1, 'seller inventory +1');
    assert(adminAfter === adminBefore - 1, 'admin inventory -1');
    console.log('   OK\n');

    console.log('2) Duplicate serial transfer (same serial again) → expect fail');
    let dupFailed = false;
    try {
      await shipmentsService.createShipment(
        {
          sellerId: Number(seller.id),
          items: [
            {
              product_name_id: Number(product.productNameId),
              product_model_id: Number(product.productModelId),
              serial_numbers: [serial],
            },
          ],
        },
        Number(admin.id)
      );
    } catch (e) {
      dupFailed = true;
      assert(e.statusCode === 400 || e.statusCode === 409, `status ${e.statusCode}`);
      console.log(`   OK (${e.message})\n`);
    }
    assert(dupFailed, 'duplicate transfer must fail');
  }

  console.log('3) Missing serial → expect fail');
  {
    const product = await prisma.product.findFirst();
    assert(product, 'need a product row');
    let failed = false;
    try {
      await shipmentsService.createShipment(
        {
          sellerId: Number(seller.id),
          items: [
            {
              product_name_id: Number(product.productNameId),
              product_model_id: Number(product.productModelId),
              serial_numbers: ['DOES-NOT-EXIST-SERIAL-XYZ'],
            },
          ],
        },
        Number(admin.id)
      );
    } catch (e) {
      failed = true;
      assert(e.statusCode === 400, '400 for missing serial');
      console.log(`   OK (${e.message})\n`);
    }
    assert(failed, 'missing serial must fail');
  }

  console.log('4) Invalid seller → expect fail');
  {
    const unit2 = await prisma.productUnit.findFirst({
      where: { status: 'AVAILABLE', owner: { role: 'ADMIN' } },
      include: { product: true },
    });
    if (!unit2) {
      console.log('   SKIP (no admin unit left)\n');
    } else {
      let failed = false;
      try {
        await shipmentsService.createShipment(
          {
            sellerId: 999999999,
            items: [
              {
                product_name_id: Number(unit2.product.productNameId),
                product_model_id: Number(unit2.product.productModelId),
                serial_numbers: [unit2.serialNumber],
              },
            ],
          },
          Number(admin.id)
        );
      } catch (e) {
        failed = true;
        assert(e.statusCode === 404, '404 invalid seller');
        console.log(`   OK (${e.message})\n`);
      }
      assert(failed, 'invalid seller must fail');

      // unit still admin-owned (rollback)
      const still = await prisma.productUnit.findUnique({ where: { id: unit2.id } });
      assert(still.status === 'AVAILABLE', 'unit still AVAILABLE after failed transfer');
      assert(still.ownerType === 'ADMIN' || Number(still.ownerId) === Number(admin.id), 'unit still admin-owned');
      console.log('5) Rollback on failure — unit unchanged: OK\n');
    }
  }

  console.log('All transfer slice tests passed.');
}

main()
  .catch((e) => {
    console.error('\nFAILED:', e.message);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
