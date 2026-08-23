require('dotenv').config();
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function del(label, fn) {
  const result = await fn();
  console.log(`  ${label}: ${result.count}`);
  return result.count;
}

async function main() {
  console.log('Clearing all inventory data across all shops...\n');

  await prisma.$transaction(async (tx) => {
    await del('return_products', () => tx.returnProduct.deleteMany({}));
    await del('battery_rents', () => tx.batteryRent.deleteMany({}));
    await del('sales_transactions', () => tx.salesTransaction.deleteMany({}));
    await del('inventory_transactions', () => tx.inventoryTransaction.deleteMany({}));
    await del('shipment_items (new)', () => tx.newShipmentItem.deleteMany({}));
    await del('shipments (new)', () => tx.newShipment.deleteMany({}));
    await del('transfer_items', () => tx.shipmentItem.deleteMany({}));
    await del('transfers', () => tx.shipment.deleteMany({}));
    await del('stock_request_items', () => tx.stockRequestItem.deleteMany({}));
    await del('stock_requests', () => tx.stockRequest.deleteMany({}));
    await del('product_units', () => tx.productUnit.deleteMany({}));
    
    // Reset product stock counts to 0
    await tx.product.updateMany({ data: { stockQuantity: 0 } });
  });

  console.log('\nAll inventory units cleared successfully. All shops now have 0 products/units.');
}

main()
  .catch((e) => {
    console.error('Failed to clear inventory:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
