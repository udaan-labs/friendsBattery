const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');

const prisma = new PrismaClient();

async function main() {
  console.log('Clearing existing database tables...');

  // Delete in reverse order of foreign keys to avoid referential integrity issues
  await prisma.replacement.deleteMany();
  await prisma.return.deleteMany();
  await prisma.sale.deleteMany();
  await prisma.inventoryTransaction.deleteMany();
  await prisma.stockRequestItem.deleteMany();
  await prisma.stockRequest.deleteMany();
  await prisma.shopInventoryAggregate.deleteMany();
  await prisma.productUnit.deleteMany();
  await prisma.product.deleteMany();
  await prisma.productSubgroup.deleteMany();
  await prisma.productGroup.deleteMany();
  await prisma.customer.deleteMany();
  await prisma.auditLog.deleteMany();
  await prisma.user.deleteMany();
  await prisma.shop.deleteMany();

  console.log('Database tables cleared. Starting seeding...');

  // 1. Seed Shops
  const wholesaleWarehouse = await prisma.shop.create({
    data: {
      shopName: 'Central Wholesale Warehouse',
      ownerName: 'Friends Battery Corp',
      mobile: '9998887776',
      address: '100 Industrial Area, Phase-1, Bangalore',
    }
  });

  const cityShop = await prisma.shop.create({
    data: {
      shopName: 'City Center Battery Shop',
      ownerName: 'John Doe',
      mobile: '9876543210',
      address: '15 Main Road, Sector-4, Bangalore',
    }
  });

  console.log('Seeded Shops.');

  // 2. Seed Users
  const passwordHash = await bcrypt.hash('AdminPassword2026', 10);
  const sellerPasswordHash = await bcrypt.hash('SellerPassword2026', 10);

  const superAdmin = await prisma.user.create({
    data: {
      name: 'Super Admin',
      email: 'admin@friendsbattery.com',
      password_hash: passwordHash,
      role: 'SUPER_ADMIN',
    }
  });

  const sellerUser = await prisma.user.create({
    data: {
      name: 'John Seller',
      email: 'seller@friendsbattery.com',
      password_hash: sellerPasswordHash,
      role: 'SELLER',
      shop_id: cityShop.id,
    }
  });

  console.log('Seeded Users.');

  // 3. Seed Product Groups
  const carGroup = await prisma.productGroup.create({
    data: { name: 'Car Batteries' }
  });

  const inverterGroup = await prisma.productGroup.create({
    data: { name: 'Inverter Batteries' }
  });

  console.log('Seeded Product Groups.');

  // 4. Seed Product Subgroups
  const leadAcidSubgroup = await prisma.productSubgroup.create({
    data: {
      product_group_id: carGroup.id,
      name: 'Lead-Acid Starter Batteries',
    }
  });

  const tubularSubgroup = await prisma.productSubgroup.create({
    data: {
      product_group_id: inverterGroup.id,
      name: 'Tall Tubular Inverter Batteries',
    }
  });

  console.log('Seeded Product Subgroups.');

  // 5. Seed Products
  const productExide = await prisma.product.create({
    data: {
      product_subgroup_id: leadAcidSubgroup.id,
      brandName: 'Exide',
      modelName: 'Exide Mile XL 50AH',
      capacity: '50AH',
      warrantyMonths: 36,
      minimum_selling_price: '4500.00',
      is_serialized: true,
    }
  });

  const productLuminous = await prisma.product.create({
    data: {
      product_subgroup_id: tubularSubgroup.id,
      brandName: 'Luminous',
      modelName: 'Red Charge 15000',
      capacity: '150AH',
      warrantyMonths: 48,
      minimum_selling_price: '12500.00',
      is_serialized: true,
    }
  });

  console.log('Seeded Products.');

  // 6. Seed Product Units (Physical Battery Items)
  // Let's create units for Exide (Lead-Acid)
  const unitExide1 = await prisma.productUnit.create({
    data: {
      serial_number: 'EXD-LA-0001',
      product_id: productExide.id,
      manufacturingDate: new Date('2026-01-15'),
      status: 'IN_WAREHOUSE',
      current_owner_type: 'WHOLESALER',
      current_owner_id: wholesaleWarehouse.id,
    }
  });

  const unitExide2 = await prisma.productUnit.create({
    data: {
      serial_number: 'EXD-LA-0002',
      product_id: productExide.id,
      manufacturingDate: new Date('2026-01-15'),
      status: 'AT_SHOP',
      current_owner_type: 'SHOP',
      current_owner_id: cityShop.id,
    }
  });

  const unitExide3 = await prisma.productUnit.create({
    data: {
      serial_number: 'EXD-LA-0003',
      product_id: productExide.id,
      manufacturingDate: new Date('2026-02-10'),
      status: 'SOLD',
      current_owner_type: 'CUSTOMER',
    }
  });

  const unitExide4 = await prisma.productUnit.create({
    data: {
      serial_number: 'EXD-LA-0004',
      product_id: productExide.id,
      manufacturingDate: new Date('2026-02-10'),
      status: 'RETURNED',
      current_owner_type: 'SHOP',
      current_owner_id: cityShop.id,
    }
  });

  // Let's create units for Luminous (Tubular)
  const unitLuminous1 = await prisma.productUnit.create({
    data: {
      serial_number: 'LUM-TB-9001',
      product_id: productLuminous.id,
      manufacturingDate: new Date('2025-12-01'),
      status: 'IN_WAREHOUSE',
      current_owner_type: 'WHOLESALER',
      current_owner_id: wholesaleWarehouse.id,
    }
  });

  const unitLuminous2 = await prisma.productUnit.create({
    data: {
      serial_number: 'LUM-TB-9002',
      product_id: productLuminous.id,
      manufacturingDate: new Date('2025-12-05'),
      status: 'AT_SHOP',
      current_owner_type: 'SHOP',
      current_owner_id: cityShop.id,
    }
  });

  const unitLuminous3 = await prisma.productUnit.create({
    data: {
      serial_number: 'LUM-TB-9003',
      product_id: productLuminous.id,
      manufacturingDate: new Date('2026-01-05'),
      status: 'SOLD',
      current_owner_type: 'CUSTOMER',
    }
  });

  const unitLuminousReplacement = await prisma.productUnit.create({
    data: {
      serial_number: 'LUM-TB-9004', // to be used as a replacement battery
      product_id: productLuminous.id,
      manufacturingDate: new Date('2026-01-05'),
      status: 'REPLACED',
      current_owner_type: 'CUSTOMER',
    }
  });

  console.log('Seeded Product Units.');

  // 7. Seed Customers
  const customerAlice = await prisma.customer.create({
    data: {
      fullName: 'Alice Smith',
      mobile: '9876541111',
      vehicleNumber: 'KA-03-MB-5678',
      address: '42 Orchid Lane, Bangalore',
    }
  });

  const customerBob = await prisma.customer.create({
    data: {
      fullName: 'Bob Johnson',
      mobile: '9876542222',
      vehicleNumber: 'KA-05-AB-9999',
      address: '77 Maple Street, Bangalore',
    }
  });

  console.log('Seeded Customers.');

  // 8. Seed Sales (Records of selling product units to customers)
  // Alice bought Exide Battery (unitExide3)
  const sale1 = await prisma.sale.create({
    data: {
      product_unit_id: unitExide3.id,
      product_id: productExide.id,
      quantity: 1,
      customer_id: customerAlice.id,
      shop_id: cityShop.id,
      sold_by_user_id: sellerUser.id,
      sale_price: '4800.00',
      sale_date: new Date('2026-03-01T10:30:00Z'),
    }
  });

  // Bob bought Luminous Battery (unitLuminous3)
  const sale2 = await prisma.sale.create({
    data: {
      product_unit_id: unitLuminous3.id,
      product_id: productLuminous.id,
      quantity: 1,
      customer_id: customerBob.id,
      shop_id: cityShop.id,
      sold_by_user_id: sellerUser.id,
      sale_price: '13500.00',
      sale_date: new Date('2026-03-10T14:15:00Z'),
    }
  });

  console.log('Seeded Sales.');

  // 9. Seed Returns
  // Bob returned his Luminous battery (unitLuminous3) due to a defect
  const returnRequest = await prisma.return.create({
    data: {
      sale_id: sale2.id,
      product_unit_id: unitLuminous3.id,
      return_reason: 'Battery holding charge for less than 1 hour.',
      status: 'APPROVED',
      created_at: new Date('2026-03-12T09:00:00Z'),
      updated_at: new Date('2026-03-12T11:00:00Z'),
    }
  });

  console.log('Seeded Returns.');

  // 10. Seed Replacements
  // Bob received unitLuminousReplacement to replace the defective unitLuminous3
  await prisma.replacement.create({
    data: {
      return_id: returnRequest.id,
      old_product_unit_id: unitLuminous3.id,
      new_product_unit_id: unitLuminousReplacement.id,
      created_at: new Date('2026-03-12T11:00:00Z'),
    }
  });

  console.log('Seeded Replacements.');

  // 11. Seed Inventory Transactions (Ledger)
  // We record the ledger history for all movements to remain immutable

  // Warehouse arrivals
  await prisma.inventoryTransaction.createMany({
    data: [
      {
        product_unit_id: unitExide1.id,
        product_id: productExide.id,
        transaction_type: 'RECEIVED',
        from_owner_type: 'WHOLESALER',
        to_owner_type: 'WHOLESALER',
        to_owner_id: wholesaleWarehouse.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Initial stock received at Warehouse',
        created_at: new Date('2026-01-20T08:00:00Z'),
      },
      {
        product_unit_id: unitExide2.id,
        product_id: productExide.id,
        transaction_type: 'RECEIVED',
        from_owner_type: 'WHOLESALER',
        to_owner_type: 'WHOLESALER',
        to_owner_id: wholesaleWarehouse.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Initial stock received at Warehouse',
        created_at: new Date('2026-01-20T08:00:00Z'),
      },
      {
        product_unit_id: unitExide3.id,
        product_id: productExide.id,
        transaction_type: 'RECEIVED',
        from_owner_type: 'WHOLESALER',
        to_owner_type: 'WHOLESALER',
        to_owner_id: wholesaleWarehouse.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Initial stock received at Warehouse',
        created_at: new Date('2026-02-15T08:00:00Z'),
      },
      {
        product_unit_id: unitExide4.id,
        product_id: productExide.id,
        transaction_type: 'RECEIVED',
        from_owner_type: 'WHOLESALER',
        to_owner_type: 'WHOLESALER',
        to_owner_id: wholesaleWarehouse.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Initial stock received at Warehouse',
        created_at: new Date('2026-02-15T08:00:00Z'),
      },
      {
        product_unit_id: unitLuminous1.id,
        product_id: productLuminous.id,
        transaction_type: 'RECEIVED',
        from_owner_type: 'WHOLESALER',
        to_owner_type: 'WHOLESALER',
        to_owner_id: wholesaleWarehouse.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Luminous stock received at Warehouse',
        created_at: new Date('2025-12-10T09:00:00Z'),
      },
      {
        product_unit_id: unitLuminous2.id,
        product_id: productLuminous.id,
        transaction_type: 'RECEIVED',
        from_owner_type: 'WHOLESALER',
        to_owner_type: 'WHOLESALER',
        to_owner_id: wholesaleWarehouse.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Luminous stock received at Warehouse',
        created_at: new Date('2025-12-10T09:00:00Z'),
      },
      {
        product_unit_id: unitLuminous3.id,
        product_id: productLuminous.id,
        transaction_type: 'RECEIVED',
        from_owner_type: 'WHOLESALER',
        to_owner_type: 'WHOLESALER',
        to_owner_id: wholesaleWarehouse.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Luminous stock received at Warehouse',
        created_at: new Date('2026-01-10T09:00:00Z'),
      },
      {
        product_unit_id: unitLuminousReplacement.id,
        product_id: productLuminous.id,
        transaction_type: 'RECEIVED',
        from_owner_type: 'WHOLESALER',
        to_owner_type: 'WHOLESALER',
        to_owner_id: wholesaleWarehouse.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Replacement buffer unit received at Warehouse',
        created_at: new Date('2026-01-10T09:00:00Z'),
      }
    ]
  });

  // Transfers to City Shop
  await prisma.inventoryTransaction.createMany({
    data: [
      {
        product_unit_id: unitExide2.id,
        product_id: productExide.id,
        transaction_type: 'TRANSFERRED',
        from_owner_type: 'WHOLESALER',
        from_owner_id: wholesaleWarehouse.id,
        to_owner_type: 'SHOP',
        to_owner_id: cityShop.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Stock transfer to City Shop',
        created_at: new Date('2026-01-25T11:00:00Z'),
      },
      {
        product_unit_id: unitExide3.id,
        product_id: productExide.id,
        transaction_type: 'TRANSFERRED',
        from_owner_type: 'WHOLESALER',
        from_owner_id: wholesaleWarehouse.id,
        to_owner_type: 'SHOP',
        to_owner_id: cityShop.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Stock transfer to City Shop',
        created_at: new Date('2026-02-20T11:00:00Z'),
      },
      {
        product_unit_id: unitExide4.id,
        product_id: productExide.id,
        transaction_type: 'TRANSFERRED',
        from_owner_type: 'WHOLESALER',
        from_owner_id: wholesaleWarehouse.id,
        to_owner_type: 'SHOP',
        to_owner_id: cityShop.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Stock transfer to City Shop',
        created_at: new Date('2026-02-20T11:00:00Z'),
      },
      {
        product_unit_id: unitLuminous2.id,
        product_id: productLuminous.id,
        transaction_type: 'TRANSFERRED',
        from_owner_type: 'WHOLESALER',
        from_owner_id: wholesaleWarehouse.id,
        to_owner_type: 'SHOP',
        to_owner_id: cityShop.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Stock transfer to City Shop',
        created_at: new Date('2025-12-15T14:00:00Z'),
      },
      {
        product_unit_id: unitLuminous3.id,
        product_id: productLuminous.id,
        transaction_type: 'TRANSFERRED',
        from_owner_type: 'WHOLESALER',
        from_owner_id: wholesaleWarehouse.id,
        to_owner_type: 'SHOP',
        to_owner_id: cityShop.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Stock transfer to City Shop',
        created_at: new Date('2026-01-15T14:00:00Z'),
      },
      {
        // Transfer replacement battery to shop first
        product_unit_id: unitLuminousReplacement.id,
        product_id: productLuminous.id,
        transaction_type: 'TRANSFERRED',
        from_owner_type: 'WHOLESALER',
        from_owner_id: wholesaleWarehouse.id,
        to_owner_type: 'SHOP',
        to_owner_id: cityShop.id,
        performed_by_user_id: superAdmin.id,
        notes: 'Replacement unit transfer to City Shop',
        created_at: new Date('2026-01-15T14:00:00Z'),
      }
    ]
  });

  // Sales Transactions
  await prisma.inventoryTransaction.createMany({
    data: [
      {
        product_unit_id: unitExide3.id,
        product_id: productExide.id,
        transaction_type: 'SOLD',
        from_owner_type: 'SHOP',
        from_owner_id: cityShop.id,
        to_owner_type: 'CUSTOMER',
        to_owner_id: customerAlice.id,
        performed_by_user_id: sellerUser.id,
        notes: 'Sold to Alice Smith',
        created_at: new Date('2026-03-01T10:30:00Z'),
      },
      {
        product_unit_id: unitLuminous3.id,
        product_id: productLuminous.id,
        transaction_type: 'SOLD',
        from_owner_type: 'SHOP',
        from_owner_id: cityShop.id,
        to_owner_type: 'CUSTOMER',
        to_owner_id: customerBob.id,
        performed_by_user_id: sellerUser.id,
        notes: 'Sold to Bob Johnson',
        created_at: new Date('2026-03-10T14:15:00Z'),
      }
    ]
  });

  // Return & Replacement Transactions
  await prisma.inventoryTransaction.createMany({
    data: [
      {
        product_unit_id: unitLuminous3.id,
        product_id: productLuminous.id,
        transaction_type: 'RETURNED',
        from_owner_type: 'CUSTOMER',
        from_owner_id: customerBob.id,
        to_owner_type: 'SHOP',
        to_owner_id: cityShop.id,
        performed_by_user_id: sellerUser.id,
        notes: 'Defective unit returned by Bob',
        created_at: new Date('2026-03-12T09:00:00Z'),
      },
      {
        product_unit_id: unitLuminousReplacement.id,
        product_id: productLuminous.id,
        transaction_type: 'REPLACED',
        from_owner_type: 'SHOP',
        from_owner_id: cityShop.id,
        to_owner_type: 'CUSTOMER',
        to_owner_id: customerBob.id,
        performed_by_user_id: sellerUser.id,
        notes: 'Replacement battery given to Bob',
        created_at: new Date('2026-03-12T11:00:00Z'),
      }
    ]
  });

  console.log('Seeded Inventory Ledger Transactions.');

  // 12. Seed Stock Requests & Items
  const stockReq = await prisma.stockRequest.create({
    data: {
      shop_id: cityShop.id,
      status: 'PENDING',
      requested_by_user_id: sellerUser.id,
      created_at: new Date('2026-03-15T12:00:00Z'),
    }
  });

  await prisma.stockRequestItem.create({
    data: {
      stock_request_id: stockReq.id,
      product_id: productExide.id,
      requested_quantity: 5,
    }
  });

  console.log('Seeded Stock Requests.');

  // 13. Seed Shop Inventory Aggregates
  // Calculates current shop inventory counts based on active stock:
  // - City Shop has:
  //   - Exide: unitExide2 (AT_SHOP), unitExide4 (RETURNED/AT_SHOP) = 2 units
  //   - Luminous: unitLuminous2 (AT_SHOP) = 1 unit (unitLuminous3 sold/defective, unitLuminousReplacement given away)
  // - Wholesale Warehouse has:
  //   - Exide: unitExide1 = 1 unit
  //   - Luminous: unitLuminous1 = 1 unit
  
  await prisma.shopInventoryAggregate.createMany({
    data: [
      {
        shop_id: cityShop.id,
        product_id: productExide.id,
        quantity: 2,
      },
      {
        shop_id: cityShop.id,
        product_id: productLuminous.id,
        quantity: 1,
      },
      {
        shop_id: wholesaleWarehouse.id,
        product_id: productExide.id,
        quantity: 1,
      },
      {
        shop_id: wholesaleWarehouse.id,
        product_id: productLuminous.id,
        quantity: 1,
      }
    ]
  });

  console.log('Seeded Shop Inventory Aggregates.');

  // 14. Seed Audit Logs
  await prisma.auditLog.createMany({
    data: [
      {
        user_id: superAdmin.id,
        entity_name: 'ProductGroup',
        entity_id: carGroup.id,
        action: 'CREATE',
        new_data: { name: 'Car Batteries' },
        created_at: new Date('2026-02-01T10:00:00Z'),
      },
      {
        user_id: superAdmin.id,
        entity_name: 'ProductGroup',
        entity_id: inverterGroup.id,
        action: 'CREATE',
        new_data: { name: 'Inverter Batteries' },
        created_at: new Date('2026-02-01T10:05:00Z'),
      }
    ]
  });

  console.log('Seeded Audit Logs.');
  console.log('Database seeding completed successfully with mock data in all 15 tables!');
}

main()
  .catch((e) => {
    console.error('Error during database seeding:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
