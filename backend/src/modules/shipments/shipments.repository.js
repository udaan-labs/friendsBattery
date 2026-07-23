const { prisma } = require('../../config/db');

const SHIPMENT_DETAIL_INCLUDE = {
  seller: {
    select: {
      id: true,
      userName: true,
      shopName: true,
      userNumber: true,
    },
  },
  admin: {
    select: {
      id: true,
      userName: true,
    },
  },
  items: {
    include: {
      name: { select: { id: true, name: true } },
      model: { select: { id: true, name: true } },
      productUnit: { select: { id: true, serialNumber: true, status: true } },
    },
  },
};

class ShipmentsRepository {
  async findSellerById(sellerId) {
    return prisma.user.findFirst({
      where: {
        id: BigInt(sellerId),
        role: 'SELLER',
      },
    });
  }

  /**
   * Atomic admin → seller serial transfer.
   * @param {{ sellerId: number, adminId: number, resolvedItems: Array<{ product, units }> }} data
   */
  async transferUnitsToSeller(data) {
    const { sellerId, adminId, resolvedItems } = data;
    const allUnits = resolvedItems.flatMap((r) => r.units);
    const transferredCount = allUnits.length;

    return prisma.$transaction(async (tx) => {
      // 1. Lock units: re-check status inside TX to prevent race
      const unitIds = allUnits.map((u) => u.id);
      const locked = await tx.productUnit.findMany({
        where: {
          id: { in: unitIds },
          status: 'AVAILABLE',
          owner: { role: 'ADMIN' },
        },
      });

      if (locked.length !== unitIds.length) {
        const error = new Error(
          'One or more serial numbers are no longer available. Refresh and try again.'
        );
        error.statusCode = 409;
        throw error;
      }

      // 2. Shipment record (completed immediately — ownership moves now)
      const count = await tx.newShipment.count();
      const shipmentNumber = `SHP-${100 + count + 1}`;

      const shipment = await tx.newShipment.create({
        data: {
          shipmentNumber,
          sellerId: BigInt(sellerId),
          createdByAdminId: BigInt(adminId),
          status: 'ACCEPTED',
          acceptedAt: new Date(),
          items: {
            create: resolvedItems.flatMap((r) =>
              r.units.map((unit) => ({
                productNameId: r.product.productNameId,
                productModelId: r.product.productModelId,
                productId: r.product.id,
                productUnitId: unit.id,
                quantity: 1,
              }))
            ),
          },
        },
      });

      // 3. Ownership → seller
      await tx.productUnit.updateMany({
        where: { id: { in: unitIds } },
        data: {
          ownerId: BigInt(sellerId),
          ownerType: 'SELLER',
          status: 'AVAILABLE',
        },
      });

      // 4. Immutable ledger (inventory movement + audit trail)
      await tx.inventoryTransaction.createMany({
        data: unitIds.map((productUnitId) => ({
          productUnitId,
          fromUserId: BigInt(adminId),
          toUserId: BigInt(sellerId),
          action: 'TRANSFERRED',
        })),
      });

      // 5. Keep denormalized product.stockQuantity roughly in sync (admin pool)
      const byProduct = new Map();
      for (const r of resolvedItems) {
        const pid = Number(r.product.id);
        byProduct.set(pid, (byProduct.get(pid) || 0) + r.units.length);
      }
      for (const [productId, qty] of byProduct.entries()) {
        await tx.product.update({
          where: { id: BigInt(productId) },
          data: { stockQuantity: { decrement: qty } },
        });
      }

      // 6. Updated inventory counts for response
      const inventory = [];
      for (const [productId, transferred] of byProduct.entries()) {
        const product = resolvedItems.find((r) => Number(r.product.id) === productId)?.product;
        const [adminRemaining, sellerCount] = await Promise.all([
          tx.productUnit.count({
            where: {
              productId: BigInt(productId),
              status: 'AVAILABLE',
              owner: { role: 'ADMIN' },
            },
          }),
          tx.productUnit.count({
            where: {
              productId: BigInt(productId),
              status: 'AVAILABLE',
              ownerId: BigInt(sellerId),
            },
          }),
        ]);

        inventory.push({
          productId,
          productName: product?.productName?.name || '',
          productModel: product?.productModel?.name || '',
          transferred,
          adminAvailable: adminRemaining,
          sellerAvailable: sellerCount,
        });
      }

      return {
        shipmentId: Number(shipment.id),
        shipmentNumber: shipment.shipmentNumber,
        status: shipment.status,
        transferredUnits: transferredCount,
        sellerId: Number(sellerId),
        inventory,
      };
    });
  }

  async getPendingShipmentsCount(sellerId) {
    return prisma.newShipment.count({
      where: {
        sellerId: BigInt(sellerId),
        status: 'PENDING',
      },
    });
  }

  async getShipmentsBySeller(sellerId) {
    return prisma.newShipment.findMany({
      where: {
        sellerId: BigInt(sellerId),
      },
      include: {
        items: {
          include: {
            product: {
              include: {
                productModel: true,
                productName: true,
              },
            },
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    });
  }

  async getAllShipments() {
    return prisma.newShipment.findMany({
      include: {
        seller: {
          select: {
            id: true,
            userName: true,
            shopName: true,
          },
        },
        items: {
          include: {
            product: {
              include: {
                productModel: true,
                productName: true,
              },
            },
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    });
  }

  async getShipmentById(shipmentId) {
    return prisma.newShipment.findUnique({
      where: {
        id: BigInt(shipmentId),
      },
      include: SHIPMENT_DETAIL_INCLUDE,
    });
  }

  async findShipmentById(shipmentId) {
    return prisma.newShipment.findUnique({
      where: {
        id: BigInt(shipmentId),
      },
      include: {
        items: true,
      },
    });
  }

  /**
   * Legacy PENDING shipments only — transfer ownership on seller accept.
   */
  async acceptPendingShipment(shipmentId, items, sellerId) {
    return prisma.$transaction(async (tx) => {
      const updatedShipment = await tx.newShipment.update({
        where: { id: BigInt(shipmentId) },
        data: {
          status: 'ACCEPTED',
          acceptedAt: new Date(),
        },
      });

      if (items && items.length > 0) {
        const productUnitIds = items.map((item) => BigInt(item.productUnitId));

        await tx.productUnit.updateMany({
          where: { id: { in: productUnitIds } },
          data: {
            ownerId: BigInt(sellerId),
            ownerType: 'SELLER',
            status: 'AVAILABLE',
          },
        });

        await tx.inventoryTransaction.createMany({
          data: items.map((item) => ({
            productUnitId: BigInt(item.productUnitId),
            fromUserId: updatedShipment.createdByAdminId,
            toUserId: BigInt(sellerId),
            action: 'RECEIVED',
          })),
        });
      }

      return updatedShipment;
    });
  }
}

module.exports = new ShipmentsRepository();
