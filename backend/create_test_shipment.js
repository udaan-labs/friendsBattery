// create_test_shipment.js - Seed test shipments for ALL sellers
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  // Clear any existing test shipments to avoid unique constraints
  await prisma.newShipmentItem.deleteMany();
  await prisma.newShipment.deleteMany();
  console.log("Cleared existing shipments.");

  // Check if admin user exists (User ID 3 or 4)
  const admin = await prisma.user.findFirst({ where: { role: 'ADMIN' } });
  if (!admin) {
    console.error("No Admin user found to create shipments. Please seed users first.");
    return;
  }
  console.log(`Using Admin: ${admin.userName} (ID: ${admin.id})`);

  // Seller IDs to create shipments for
  const sellerIds = [2, 5, 6, 7, 8];
  
  for (let i = 0; i < sellerIds.length; i++) {
    const id = sellerIds[i];
    const seller = await prisma.user.findUnique({ where: { id: id } });
    if (seller) {
      const shpNum = `SHP-${101 + i}`;
      await prisma.newShipment.create({
        data: {
          shipmentNumber: shpNum,
          sellerId: seller.id,
          createdByAdminId: admin.id,
          status: "PENDING",
          items: {
            create: [
              {
                productCategoryId: 1, // Laptop
                productNameId: 1,     // Lenevo
                productModelId: 1,    // Thinkpad P1
                quantity: 5 + i
              }
            ]
          }
        }
      });
      console.log(`Created PENDING shipment ${shpNum} for Seller ID ${id} (${seller.userName})`);
    }
  }
}

main()
  .catch(e => console.error(e))
  .finally(() => prisma.$disconnect());
