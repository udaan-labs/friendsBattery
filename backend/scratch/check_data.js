const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const users = await prisma.user.findMany({ select: { id: true, userId: true, role: true } });
  console.log("USERS:", users);

  const categories = await prisma.category.findMany();
  console.log("CATEGORIES:", categories);

  const names = await prisma.productName.findMany();
  console.log("PRODUCT NAMES:", names);

  const models = await prisma.productModel.findMany();
  console.log("PRODUCT MODELS:", models);

  const products = await prisma.product.findMany();
  console.log("PRODUCTS:", products);

  const units = await prisma.productUnit.findMany({ take: 5 });
  console.log("PRODUCT UNITS (first 5):", units);
}

main()
  .catch(e => console.error(e))
  .finally(() => prisma.$disconnect());
