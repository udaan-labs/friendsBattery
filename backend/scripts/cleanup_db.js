const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  console.log('Starting cleanup...');
  
  // Deleting in order to respect constraints where possible
  // Using try-catch because if there are constraints from other tables like ProductUnit, it might fail.
  // The user requested only to delete from these 4 tables.
  
  try {
    const deletedProducts = await prisma.product.deleteMany({});
    console.log(`Deleted ${deletedProducts.count} products.`);
    
    const deletedModels = await prisma.productModel.deleteMany({});
    console.log(`Deleted ${deletedModels.count} product models.`);
    
    const deletedNames = await prisma.productName.deleteMany({});
    console.log(`Deleted ${deletedNames.count} product names.`);
    
    const deletedCategories = await prisma.category.deleteMany({});
    console.log(`Deleted ${deletedCategories.count} categories.`);
    
  } catch (error) {
    console.error('Error during cleanup:', error);
  } finally {
    await prisma.$disconnect();
  }
}

main();
