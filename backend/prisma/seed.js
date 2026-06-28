require('dotenv').config();
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

const data = [
  { company: 'Exide', model: 'Xpress XP800' },
  { company: 'Exide', model: 'Mileage MLDIN60' },
  { company: 'Exide', model: 'Matrix MT40B20L' },
  { company: 'Amaron', model: 'GO 46B24R' },
  { company: 'Amaron', model: 'FLO DIN66' },
  { company: 'Amaron', model: 'Hi-Life F700' },
  { company: 'SF Sonic', model: 'FlashStart FS40B20L' },
  { company: 'SF Sonic', model: 'PowerBox DIN65' },
  { company: 'Luminous', model: 'Red Charge RC18000' },
  { company: 'Luminous', model: 'Eco Volt EV150' },
  { company: 'Tata Green', model: 'TG40B20L' },
  { company: 'Tata Green', model: 'TGDIN66' },
  { company: 'Bosch', model: 'S4 005' },
  { company: 'Bosch', model: 'S5 008' },
  { company: 'Bosch', model: 'M6 Mega Power' },
  { company: 'Livguard', model: 'LGDIN60' },
  { company: 'Livguard', model: 'LGMAX65' },
  { company: 'Okaya', model: 'Power Plus PP65' },
  { company: 'Okaya', model: 'Ultra Max UM75' },
  { company: 'Base', model: 'B24L' },
  { company: 'Base', model: 'DIN66' },
  { company: 'AC Delco', model: '55D23L' },
  { company: 'AC Delco', model: 'DIN74' },
  { company: 'Yokohama', model: 'Gold 65D26R' },
  { company: 'Yokohama', model: 'Premium DIN80' },
];

async function main() {
  console.log('Seed script started...');

  let totalProductsCreated = 0;

  for (const item of data) {
    // Create or get ProductName (brand/company)
    let productName = await prisma.productName.findUnique({
      where: { name: item.company },
    });
    if (!productName) {
      productName = await prisma.productName.create({
        data: { name: item.company },
      });
      console.log(`  Created brand: ${item.company}`);
    }

    // Create or get ProductModel
    let productModel = await prisma.productModel.findUnique({
      where: { productNameId_name: { productNameId: productName.id, name: item.model } },
    });
    if (!productModel) {
      productModel = await prisma.productModel.create({
        data: { name: item.model, productNameId: productName.id },
      });
      console.log(`  Created model: ${item.model} for ${item.company}`);
    }

    // Check if Product already exists for this brand + model
    const existingProduct = await prisma.product.findFirst({
      where: {
        productNameId: productName.id,
        productModelId: productModel.id,
      },
    });

    if (!existingProduct) {
      await prisma.product.create({
        data: {
          productNameId: productName.id,
          productModelId: productModel.id,
          minPrice: 0,
          onSale: false,
          minUnitCountAdmin: 0,
          minUnitCountSeller: 0,
        },
      });
      totalProductsCreated++;
    }
  }

  console.log(`Seed completed. Created ${totalProductsCreated} new products.`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
