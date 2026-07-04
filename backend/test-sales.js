const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const sales = await prisma.salesTransaction.findMany();
  console.log('All sales:');
  for (const s of sales) {
    console.log(`- ID: ${s.id}, soldAt: ${s.soldAt.toISOString()}, local: ${s.soldAt.toString()}`);
  }
  
  const startOfToday = new Date();
  startOfToday.setHours(0, 0, 0, 0);

  const endOfToday = new Date();
  endOfToday.setHours(23, 59, 59, 999);
  
  console.log('startOfToday:', startOfToday.toISOString());
  console.log('endOfToday:', endOfToday.toISOString());
}

main().catch(console.error).finally(() => prisma.$disconnect());
