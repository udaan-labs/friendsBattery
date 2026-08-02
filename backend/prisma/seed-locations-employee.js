/**
 * Idempotent seed for employee+location slice.
 * Run: node prisma/seed-locations-employee.js
 *
 * Creates: WH001, SHOP001, ADMIN001, SELLER001, EMP001,
 * one product if missing, sample units at warehouse + shop.
 */
require('dotenv').config();
const bcrypt = require('bcrypt');
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();
const PASSWORD = process.env.SEED_EMP_PASSWORD || '123';

async function upsertUser({ userId, userName, role, userNumber, shopName, locationId, employeeRoleId, passwordHash }) {
  const existing = await prisma.user.findFirst({
    where: { OR: [{ userId }, { userNumber }] },
  });
  if (existing) {
    return prisma.user.update({
      where: { id: existing.id },
      data: {
        userId,
        role,
        locationId: locationId ?? null,
        employeeRoleId: employeeRoleId ?? null,
        isActive: true,
        isVerified: true,
        passwordHash,
        userName,
        shopName: shopName ?? null,
      },
    });
  }
  return prisma.user.create({
    data: {
      userId,
      userName,
      role,
      userNumber,
      shopName: shopName ?? null,
      locationId: locationId ?? null,
      employeeRoleId: employeeRoleId ?? null,
      passwordHash,
      isActive: true,
      isVerified: true,
      loginAttempt: 0,
    },
  });
}

async function main() {
  console.log('Seed locations + users + sample stock...');
  const passwordHash = await bcrypt.hash(PASSWORD, 10);

  const warehouse = await prisma.location.upsert({
    where: { code: 'WH001' },
    update: { name: 'Main Warehouse', type: 'WAREHOUSE', isActive: true },
    create: {
      code: 'WH001',
      name: 'Main Warehouse',
      type: 'WAREHOUSE',
      isActive: true,
    },
  });

  const shop = await prisma.location.upsert({
    where: { code: 'SHOP001' },
    update: { name: 'Friends Battery Shop', type: 'SHOP', isActive: true },
    create: {
      code: 'SHOP001',
      name: 'Friends Battery Shop',
      type: 'SHOP',
      isActive: true,
    },
  });
  console.log('  locations WH001=', Number(warehouse.id), 'SHOP001=', Number(shop.id));

  let cashier = await prisma.employeeRole.findFirst({ where: { name: 'Cashier' } });
  if (!cashier) {
    cashier = await prisma.employeeRole.create({
      data: { name: 'Cashier', description: 'Checkout and billing' },
    });
  }

  const admin = await upsertUser({
    userId: 'admin1',
    userName: 'Admin',
    role: 'ADMIN',
    userNumber: '9000000000',
    shopName: null,
    locationId: warehouse.id,
    passwordHash,
  });
  const seller = await upsertUser({
    userId: 'seller1',
    userName: 'Seller A',
    role: 'SELLER',
    userNumber: '9000000002',
    shopName: 'Friends Battery Shop',
    locationId: shop.id,
    passwordHash,
  });
  const emp = await upsertUser({
    userId: 'employee1',
    userName: 'Employee Rahul',
    role: 'EMPLOYEE',
    userNumber: '9000000001',
    shopName: 'Friends Battery Shop',
    locationId: shop.id,
    employeeRoleId: cashier.id,
    passwordHash,
  });
  console.log(
    '  users admin1=',
    Number(admin.id),
    'seller1=',
    Number(seller.id),
    'employee1=',
    Number(emp.id)
  );

  // Ensure one product exists
  let productName = await prisma.productName.findFirst({ where: { name: 'Exide' } });
  if (!productName) {
    productName = await prisma.productName.create({ data: { name: 'Exide' } });
  }
  let productModel = await prisma.productModel.findFirst({
    where: { productNameId: productName.id, name: 'Seed XP800' },
  });
  if (!productModel) {
    productModel = await prisma.productModel.create({
      data: { productNameId: productName.id, name: 'Seed XP800' },
    });
  }
  let product = await prisma.product.findFirst({
    where: { productNameId: productName.id, productModelId: productModel.id },
  });
  if (!product) {
    product = await prisma.product.create({
      data: {
        productNameId: productName.id,
        productModelId: productModel.id,
        minPrice: 1000,
        stockQuantity: 0,
        minUnitCountAdmin: 0,
        minUnitCountSeller: 0,
      },
    });
  }

  // Sample units only if none at shop (so re-run is safe)
  const shopUnits = await prisma.productUnit.count({
    where: { currentLocationId: shop.id, status: 'AVAILABLE' },
  });
  if (shopUnits === 0) {
    // 3 at warehouse (admin owns)
    await prisma.productUnit.createMany({
      data: [1, 2, 3].map((i) => ({
        productId: product.id,
        ownerId: admin.id,
        ownerType: 'ADMIN',
        currentLocationId: warehouse.id,
        serialNumber: `SEED-WH-${Date.now()}-${i}`,
        status: 'AVAILABLE',
      })),
    });
    // 3 at shop (seller owns — employee sees by location)
    await prisma.productUnit.createMany({
      data: [1, 2, 3].map((i) => ({
        productId: product.id,
        ownerId: seller.id,
        ownerType: 'SELLER',
        currentLocationId: shop.id,
        serialNumber: `SEED-SHOP-${Date.now()}-${i}`,
        status: 'AVAILABLE',
      })),
    });
    await prisma.product.update({
      where: { id: product.id },
      data: { stockQuantity: { increment: 3 } },
    });
    console.log('  created 3 warehouse + 3 shop sample units');
  } else {
    console.log('  shop already has', shopUnits, 'AVAILABLE units — skip sample create');
  }

  // Backfill null locations
  await prisma.productUnit.updateMany({
    where: { currentLocationId: null, status: 'AVAILABLE', owner: { role: 'ADMIN' } },
    data: { currentLocationId: warehouse.id },
  });
  await prisma.productUnit.updateMany({
    where: { currentLocationId: null, status: 'AVAILABLE', ownerId: seller.id },
    data: { currentLocationId: shop.id },
  });

  const atShop = await prisma.productUnit.count({
    where: { currentLocationId: shop.id, status: 'AVAILABLE' },
  });
  console.log('  AVAILABLE at SHOP001:', atShop);
  console.log('Done. Passwords:', PASSWORD);
  console.log('  admin1 | seller1 | employee1');
  console.log('  EMP inventory → units at shop; SELLER → owner_id; ADMIN → admin stock');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
