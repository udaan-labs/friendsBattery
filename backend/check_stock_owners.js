const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const stockCounts = await prisma.productUnit.groupBy({
    by: ['ownerId'],
    where: {
      status: 'IN_STOCK'
    },
    _count: {
      id: true
    }
  });

  console.log('Stock distribution by owner:');
  for (const group of stockCounts) {
    const user = await prisma.user.findUnique({
      where: { id: group.ownerId }
    });
    
    const username = user ? user.userName : 'Unknown';
    const role = user ? user.role : 'Unknown';
    
    console.log(`Owner ID: ${group.ownerId} | Username: ${username} | Role: ${role} | Items IN_STOCK: ${group._count.id}`);
  }
}

main()
  .catch(e => console.error(e))
  .finally(async () => {
    await prisma.$disconnect();
  });
