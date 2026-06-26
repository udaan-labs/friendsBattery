const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const shipments = await prisma.newShipment.findMany({
    include: { items: true },
  });
  console.log(JSON.stringify(shipments, null, 2));
}

main()
  .catch(e => console.error('Error:', e))
  .finally(() => prisma.$disconnect());
