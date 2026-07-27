const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  try {
    const usersCount = await prisma.user.count();
    console.log('Prisma connected successfully. User count:', usersCount);
  } catch (error) {
    console.error('Prisma connection failed:', error);
  } finally {
    await prisma.$disconnect();
  }
}

main();
