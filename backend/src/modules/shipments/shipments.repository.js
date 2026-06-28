const { prisma } = require('../../config/db');

// Full nested include used by both admin and seller detail views
const SHIPMENT_DETAIL_INCLUDE = {
  seller: {
    select: {
      id: true,
      userName: true,
      shopName: true,
      userNumber: true,
    }
  },
  admin: {
    select: {
      id: true,
      userName: true,
    }
  },
  items: {
    include: {
      category: { select: { id: true, name: true } },
      name: { select: { id: true, name: true } },
      model: { select: { id: true, name: true } },
      product: {
        select: {
          id: true,
          group: { select: { id: true, name: true } }
        }
      },
      productUnit: { select: { id: true, serialNumber: true, status: true } }
    }
  }
};

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

  async findProductById(productId) {
    return prisma.product.findUnique({
      where: {
        id: BigInt(productId)
      }
    });
  }

  async getAvailableUnits(productId, ownerId, limit) {
    return prisma.productUnit.findMany({
      where: {
        productId: BigInt(productId),
        ownerId: BigInt(ownerId),
        status: 'IN_STOCK'
      },
      take: limit
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

  /**
   * Get all shipments for a specific seller (all statuses).
   */
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

  /**
   * Get all shipments (Admin view — all sellers).
   */
  async getAllShipments() {
    return prisma.newShipment.findMany({
      include: {
        seller: {
          select: {
            id: true,
            userName: true,
            shopName: true,
          }
        },
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

  /**
   * Get a single shipment by ID with all nested relations.
   */
  async getShipmentById(shipmentId) {
    return prisma.newShipment.findUnique({
      where: {
        id: BigInt(shipmentId)
      },
      include: SHIPMENT_DETAIL_INCLUDE
    });
  }

  /**
   * Find a shipment with only items (used for accept validation).
   */
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
    return prisma.$transaction(async (tx) => {
      // 1. Update shipment status and acceptedAt
      const updatedShipment = await tx.newShipment.update({
        where: { id: BigInt(shipmentId) },
        data: {
          status: 'ACCEPTED',
          acceptedAt: new Date()
        }
      });

      if (items && items.length > 0) {
        const productUnitIds = items.map(item => BigInt(item.productUnitId));

        // 2. Transfer all ProductUnit records to the seller in one query
        await tx.productUnit.updateMany({
          where: { id: { in: productUnitIds } },
          data: {
            ownerId: BigInt(sellerId),
            status: 'IN_STOCK'
          }
        });

        // 3. Create InventoryTransaction records in bulk
        const transactionsData = items.map(item => ({
          productUnitId: BigInt(item.productUnitId),
          fromUserId: updatedShipment.createdByAdminId,
          toUserId: BigInt(sellerId),
          action: 'RECEIVED'
        }));

        await tx.inventoryTransaction.createMany({
          data: transactionsData
        });
      }

      return updatedShipment;
    }, {
      timeout: 10000 // Increase timeout just in case of slow DB
    });
  }
}

module.exports = new ShipmentsRepository();
