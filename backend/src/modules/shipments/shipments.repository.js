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
      name: { select: { id: true, name: true } },
      model: { select: { id: true, name: true } },
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
        status: 'AVAILABLE'
      },
      take: limit
    });
  }

  async createShipment(data) {
    return prisma.$transaction(async (tx) => {
      // 1. Create ProductUnit records with real serial numbers
      const createdUnits = await tx.productUnit.createManyAndReturn({
        data: data.units
      });

      // 2. Map shipment items to created units
      let unitIndex = 0;
      const itemCreates = data.items.map(item => ({
        productNameId: BigInt(item.productNameId),
        productModelId: BigInt(item.productModelId),
        productId: BigInt(item.productId),
        productUnitId: createdUnits[unitIndex++].id,
        quantity: item.quantity
      }));

      // 3. Create the shipment with items
      const shipment = await tx.newShipment.create({
        data: {
          shipmentNumber: data.shipmentNumber,
          sellerId: BigInt(data.sellerId),
          createdByAdminId: BigInt(data.createdByAdminId),
          status: 'PENDING',
          items: {
            create: itemCreates
          }
        },
        include: {
          items: true
        }
      });

      // 4. Decrement stockQuantity and clean up matching Admin dummy AVAILABLE units
      for (const update of data.stockUpdates) {
        const dummyUnits = await tx.productUnit.findMany({
          where: {
            productId: BigInt(update.productId),
            ownerId: BigInt(data.createdByAdminId),
            status: 'AVAILABLE'
          },
          take: update.decrementBy,
          select: { id: true }
        });

        if (dummyUnits.length > 0) {
          const dummyIds = dummyUnits.map(u => u.id);
          await tx.productUnit.deleteMany({
            where: { id: { in: dummyIds } }
          });
        }

        await tx.product.update({
          where: { id: BigInt(update.productId) },
          data: {
            stockQuantity: { decrement: update.decrementBy }
          }
        });
      }

      return shipment;
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
            ownerType: 'SELLER',
            status: 'AVAILABLE'
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
