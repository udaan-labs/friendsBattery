require('dotenv').config();
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function main() {
  console.log('Seed script started...');

  // 1. Create Group
  const group = await prisma.group.upsert({
    where: { name: 'Battery' },
    update: {},
    create: { name: 'Battery' },
  });

  // 2. Create Categories
  const categoriesData = ['Car', 'Bike', 'Scooty', 'Inverter'];
  const categories = {};
  for (const catName of categoriesData) {
    categories[catName] = await prisma.category.upsert({
      where: { name: catName },
      update: { groupId: group.id },
      create: { name: catName, groupId: group.id },
    });
  }

  // 3. Brands & Models Data
  const brandsData = {
    Car: {
      'Amaron': ['FLO 35B20L', 'FLO 42B20L', 'GO 65D26L', 'DIN60', 'DIN66', 'PRO 50B20L'],
      'Exide': ['Mileage ML38B20L', 'Matrix DIN60', 'XP800', 'XP1000', 'Matrix MTRED65', 'Eezy 35B20R'],
      'SF Sonic': ['Flash MZ50', 'Flash MZ65', 'Pro SP60', 'Pro SP70', 'PowerBox 40', 'PowerBox 50'],
      'Livguard': ['CarMax 40', 'CarMax 55', 'SUVPro 65', 'SUVPro 75', 'ZigZag 35', 'CarMax 45'],
      'Bosch': ['S4 005', 'S4 008', 'S5 010', 'S3 002', 'S6 013', 'S5 001'],
      'Tata Green': ['Premio 35', 'Premio 45', 'Silver 60', 'Silver 70', 'YUASA 40', 'YUASA 50'],
    },
    Bike: {
      'Amaron': ['AP-BTZ4', 'AP-BTZ5', 'AP-BTZ7', 'AP-BTX9', 'AP-BTX7L', 'AP-BTZ9'],
      'Exide': ['XLTZ4', 'XLTZ5', 'XLTZ7', 'Bikerz BZ4', 'Bikerz BZ5', 'Xplore XLTZ4'],
      'SF Sonic': ['Mobike 4', 'Mobike 5', 'Mobike 7', 'Mobike 9', 'Power 5', 'Power 7'],
      'Livguard': ['TwoWheeler 4', 'TwoWheeler 5', 'TwoWheeler 7', 'TwoWheeler 9', 'BikePro 4', 'BikePro 5'],
      'Bosch': ['M6 001', 'M6 004', 'M6 006', 'M6 008', 'M4 001', 'M4 005'],
      'Tata Green': ['TG 4', 'TG 5', 'TG 7', 'TG 9', 'Velocity 4', 'Velocity 5'],
    },
    Scooty: {
      'Amaron': ['AP-BTZ4', 'AP-BTX5L', 'AP-BTX4L', 'AP-BTZ5', 'AP-BTX7A', 'AP-BTX7L'],
      'Exide': ['XLTZ4', 'XLTZ5', 'Activa EZ4', 'Jupiter EZ5', 'Scooty Pro 4', 'Scooty Pro 5'],
      'SF Sonic': ['Scooter 4', 'Scooter 5', 'Jet 4', 'Jet 5', 'PowerScoot 4', 'PowerScoot 5'],
      'Livguard': ['Scoot 4', 'Scoot 5', 'EasyGo 4', 'EasyGo 5', 'ScootPro 4', 'ScootPro 5'],
      'Bosch': ['M6 001', 'M6 004', 'S-M4 001', 'S-M4 005', 'Scooter M6 002', 'Scooter M6 003'],
      'Tata Green': ['TG 4', 'TG 5', 'Scooty TG4', 'Scooty TG5', 'Acti Green 4', 'Acti Green 5'],
    },
    Inverter: {
      'Amaron': ['Current AR200', 'Current AR150', 'Tall Tubular 150Ah', 'Tall Tubular 200Ah', 'Flat Plate 135Ah', 'Flat Plate 150Ah'],
      'Exide': ['InvaTubular 150Ah', 'InvaTubular 200Ah', 'InvaTubular 220Ah', 'InvaMaster 150Ah', 'InvaPlus 135Ah', 'InvaRed 150Ah'],
      'SF Sonic': ['StanTubular 150Ah', 'StanTubular 200Ah', 'PowerBox Inv 150Ah', 'PowerBox Inv 200Ah', 'InvTub 135Ah', 'InvTub 150Ah'],
      'Livguard': ['Invertuff 150Ah', 'Invertuff 200Ah', 'Invertuff 220Ah', 'IT 150Ah', 'IT 200Ah', 'IT 165Ah'],
      'Bosch': ['Inverter 150Ah', 'Inverter 200Ah', 'Tubular 150Ah', 'Tubular 200Ah', 'Flat 150Ah', 'Flat 200Ah'],
      'Tata Green': ['Inva Plus 150Ah', 'Inva Plus 200Ah', 'TG Inv 150Ah', 'TG Inv 200Ah', 'Tubular Inv 150Ah', 'Tubular Inv 200Ah'],
    }
  };

  let totalProductsCreated = 0;

  // Iterate to create Brands, Models, Products
  for (const catName of Object.keys(brandsData)) {
    const category = categories[catName];
    const catBrands = brandsData[catName];

    for (const brandName of Object.keys(catBrands)) {
      // Create ProductName (Brand)
      let brand = await prisma.productName.findUnique({
        where: { categoryId_name: { categoryId: category.id, name: brandName } },
      });
      if (!brand) {
        brand = await prisma.productName.create({
          data: { name: brandName, categoryId: category.id },
        });
      }

      const models = catBrands[brandName];
      for (const modelName of models) {
        // Create ProductModel
        let model = await prisma.productModel.findUnique({
          where: { productNameId_name: { productNameId: brand.id, name: modelName } },
        });
        if (!model) {
          model = await prisma.productModel.create({
            data: { name: modelName, productNameId: brand.id },
          });
        }

        // Create Product
        // Determine realistic prices based on category
        let basePrice = 1000;
        if (catName === 'Car') basePrice = 3000 + Math.floor(Math.random() * 3000);
        else if (catName === 'Bike' || catName === 'Scooty') basePrice = 800 + Math.floor(Math.random() * 500);
        else if (catName === 'Inverter') basePrice = 10000 + Math.floor(Math.random() * 5000);

        const purchasePrice = basePrice;
        const sellingPrice = purchasePrice + Math.floor(purchasePrice * (0.1 + Math.random() * 0.2)); // 10% to 30% margin

        const minAdmin = 10 + Math.floor(Math.random() * 41); // 10-50
        const minSeller = 2 + Math.floor(Math.random() * 9); // 2-10

        // check if product exists
        const existingProducts = await prisma.product.findMany({
          where: {
            categoryId: category.id,
            groupId: group.id,
            productNameId: brand.id,
            productModelId: model.id,
          }
        });

        if (existingProducts.length === 0) {
          await prisma.product.create({
            data: {
              categoryId: category.id,
              groupId: group.id,
              productNameId: brand.id,
              productModelId: model.id,
              minPrice: purchasePrice,
              offerPrice: sellingPrice,
              onSale: true,
              minUnitCountAdmin: minAdmin,
              minUnitCountSeller: minSeller,
            }
          });
          totalProductsCreated++;
        }
      }
    }
  }

  console.log(`Seed script completed successfully. Created ${totalProductsCreated} new products.`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
