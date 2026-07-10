const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function checkInventory() {
  try {
    const users = await prisma.user.findMany();
    
    for (const user of users) {
      const count = await prisma.productUnit.count({
        where: {
          ownerId: user.id,
          status: 'AVAILABLE'
        }
      });
      console.log(`User: ${user.userName} (Role: ${user.role}, ID: ${user.id}) - Available Inventory: ${count}`);
    }
  } catch (error) {
    console.error(error);
  } finally {
    await prisma.$disconnect();
  }
}

checkInventory();
