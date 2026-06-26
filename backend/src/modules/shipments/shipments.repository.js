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
            productId: BigInt(item.productId),
            productUnitId: BigInt(item.productItemId),
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
            product: {
              include: {
                productModel: true,
                productName: true
              }
            }
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

      // 2. Transfer ProductUnit records to the seller
      for (const item of items) {
        // We now have a specific productUnit linked to this shipment item
        const updatedUnit = await tx.productUnit.update({
          where: { id: BigInt(item.productUnitId) },
          data: {
            ownerId: BigInt(sellerId),
            status: 'IN_STOCK'
          }
        });

        // 3. Create InventoryTransaction
        await tx.inventoryTransaction.create({
          data: {
            productUnitId: updatedUnit.id,
            fromUserId: updatedShipment.createdByAdminId,
            toUserId: BigInt(sellerId),
            action: 'RECEIVED'
          }
        });
      }

      return updatedShipment;
    });
  }
}

module.exports = new ShipmentsRepository();
