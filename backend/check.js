const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const transfers = await prisma.shipment.findMany();
  console.log('All shipments (transfers table):', transfers.map(t => ({ id: t.id.toString(), status: t.status, toUserId: t.toUserId.toString() })));

  const shipments = await prisma.newShipment.findMany();
  console.log('All newShipments (shipments table):', shipments.map(t => ({ id: t.id.toString(), status: t.status, sellerId: t.sellerId.toString() })));
}

main().catch(console.error).finally(() => prisma.$disconnect());
