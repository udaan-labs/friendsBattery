const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  // Check NewShipment table (mapped to "shipments")
  const newShipments = await prisma.newShipment.findMany({ include: { items: true } });
  console.log('=== NewShipment table (shipments) ===');
  console.log('Count:', newShipments.length);
  console.log(JSON.stringify(newShipments, (key, value) =>
    typeof value === 'bigint' ? Number(value) : value, 2));

  console.log('\n');

  // Check old Shipment table (mapped to "transfers")
  const oldShipments = await prisma.shipment.findMany({ include: { items: true } });
  console.log('=== Shipment table (transfers) ===');
  console.log('Count:', oldShipments.length);
  console.log(JSON.stringify(oldShipments, (key, value) =>
    typeof value === 'bigint' ? Number(value) : value, 2));

  console.log('\n');

  // Also list all users so we can verify seller IDs
  const users = await prisma.user.findMany({ select: { id: true, userId: true, userName: true, role: true } });
  console.log('=== Users ===');
  console.log(JSON.stringify(users, (key, value) =>
    typeof value === 'bigint' ? Number(value) : value, 2));
}

main()
  .catch(e => console.error('Error:', e))
  .finally(() => prisma.$disconnect());
