const { prisma } = require('../../config/db');

class ShipmentsRepository {
  async findSellerById(sellerId) {
    return prisma.user.findFirst({
      where: {
        id: BigInt(sellerId),
        role: 'SELLER'
      }
    });
  }

  async findProduct(categoryId, productNameId, productModelId) {
    return prisma.product.findFirst({
      where: {
        categoryId: BigInt(categoryId),
        productNameId: BigInt(productNameId),
        productModelId: BigInt(productModelId)
      }
    });
  }

  async createShipment(data, tx = prisma) {
    return tx.newShipment.create({
      data: {
        shipmentNumber: data.shipmentNumber,
        sellerId: BigInt(data.sellerId),
        createdByAdminId: BigInt(data.createdByAdminId),
        status: 'PENDING',
        items: {
          create: data.items.map(item => ({
            productCategoryId: BigInt(item.productCategoryId),
            productNameId: BigInt(item.productNameId),
            productModelId: BigInt(item.productModelId),
            quantity: item.quantity
          }))
        }
      },
      include: {
        items: true
      }
    });
  }

  async getPendingShipmentsCount(sellerId) {
    return prisma.newShipment.count({
      where: {
        sellerId: BigInt(sellerId),
        status: 'PENDING'
      }
    });
  }

  async getShipmentsBySeller(sellerId) {
    return prisma.newShipment.findMany({
      where: {
        sellerId: BigInt(sellerId)
      },
      include: {
        items: {
          include: {
            model: true
          }
        }
      },
      orderBy: {
        createdAt: 'desc'
      }
    });
  }

  async findShipmentById(shipmentId) {
    return prisma.newShipment.findUnique({
      where: {
        id: BigInt(shipmentId)
      },
      include: {
        items: true
      }
    });
  }

  async acceptShipment(shipmentId, items, sellerId) {
    const crypto = require('crypto');
    return prisma.$transaction(async (tx) => {
      // 1. Update shipment status and acceptedAt
      const updatedShipment = await tx.newShipment.update({
        where: { id: BigInt(shipmentId) },
        data: {
          status: 'ACCEPTED',
          acceptedAt: new Date()
        }
      });

      // 2. Create ProductUnit records for the seller
      for (const item of items) {
        // Find product ID for this combo
        const product = await tx.product.findFirst({
          where: {
            categoryId: item.productCategoryId,
            productNameId: item.productNameId,
            productModelId: item.productModelId
          }
        });

        if (!product) {
          throw new Error(`Product combo category: ${item.productCategoryId}, name: ${item.productNameId}, model: ${item.productModelId} not found`);
        }

        // Generate quantity number of units
        const unitsData = Array.from({ length: item.quantity }).map(() => ({
          productId: product.id,
          ownerId: BigInt(sellerId),
          serialNumber: `SHP-${updatedShipment.shipmentNumber}-${Date.now()}-${crypto.randomUUID()}`,
          status: 'IN_STOCK'
        }));

        const createdUnits = await tx.productUnit.createManyAndReturn({
          data: unitsData
        });

        // 3. Create InventoryTransactions
        const transactionLogs = createdUnits.map(unit => ({
          productUnitId: unit.id,
          fromUserId: updatedShipment.createdByAdminId,
          toUserId: BigInt(sellerId),
          action: 'RECEIVED'
        }));

        await tx.inventoryTransaction.createMany({
          data: transactionLogs
        });
      }

      return updatedShipment;
    });
  }
}

module.exports = new ShipmentsRepository();
