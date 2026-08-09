const { prisma } = require('../../config/db');
const { getDefaultWarehouseId, getUserLocationId } = require('../../shared/utils/location.util');
const { httpError } = require('../../shared/utils/http-error');

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
        throw httpError(409, 
          'One or more serial numbers are no longer available. Refresh and try again.'
        );
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

      const fromLoc = await getDefaultWarehouseId(tx);
      const toLoc = await getUserLocationId(sellerId, tx);

      // 3. Ownership → seller (+ shop location when seller has one)
      await tx.productUnit.updateMany({
        where: { id: { in: unitIds } },
        data: {
          ownerId: BigInt(sellerId),
          ownerType: 'SELLER',
          status: 'AVAILABLE',
          ...(toLoc ? { currentLocationId: toLoc } : {}),
        },
      });

      // 4. Immutable ledger (inventory movement + audit trail)
      await tx.inventoryTransaction.createMany({
        data: unitIds.map((productUnitId) => ({
          productUnitId,
          fromUserId: BigInt(adminId),
          toUserId: BigInt(sellerId),
          action: 'TRANSFERRED',
          ...(fromLoc ? { fromLocationId: fromLoc } : {}),
          ...(toLoc ? { toLocationId: toLoc } : {}),
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

  /**
   * Shipments for all sellers assigned to the same shop location as the employee.
   */
  async getShipmentsBySellerLocationId(locationId) {
    if (locationId == null) return [];
    return prisma.newShipment.findMany({
      where: {
        seller: {
          locationId: BigInt(locationId),
          role: 'SELLER',
        },
      },
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

  async sellerSharesLocation(sellerId, locationId) {
    if (locationId == null) return false;
    const seller = await prisma.user.findFirst({
      where: {
        id: BigInt(sellerId),
        role: 'SELLER',
        locationId: BigInt(locationId),
      },
      select: { id: true },
    });
    return !!seller;
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
   * Atomic: claim PENDING→ACCEPTED first; only move AVAILABLE admin-owned units.
   */
  async acceptPendingShipment(shipmentId, items, sellerId) {
    return prisma.$transaction(async (tx) => {
      // Claim row so concurrent accepts cannot both succeed
      const claimed = await tx.newShipment.updateMany({
        where: { id: BigInt(shipmentId), status: 'PENDING' },
        data: {
          status: 'ACCEPTED',
          acceptedAt: new Date(),
        },
      });
      if (claimed.count !== 1) {
        throw httpError(400, 
          'Shipment cannot be accepted. It may already be processed.'
        );
      }

      const updatedShipment = await tx.newShipment.findUnique({
        where: { id: BigInt(shipmentId) },
      });

      if (items && items.length > 0) {
        const productUnitIds = items
          .map((item) => item.productUnitId)
          .filter((id) => id != null)
          .map((id) => BigInt(id));

        if (productUnitIds.length > 0) {
          // Never force SOLD/transferred units back to AVAILABLE under seller
          const locked = await tx.productUnit.findMany({
            where: {
              id: { in: productUnitIds },
              status: 'AVAILABLE',
              owner: { role: 'ADMIN' },
            },
            select: { id: true },
          });
          if (locked.length !== productUnitIds.length) {
            throw httpError(409, 
              'One or more serials are no longer available for this shipment. Contact admin.'
            );
          }

          const fromLoc = await getDefaultWarehouseId(tx);
          const toLoc = await getUserLocationId(sellerId, tx);
          const lockedIds = locked.map((u) => u.id);

          await tx.productUnit.updateMany({
            where: {
              id: { in: lockedIds },
              status: 'AVAILABLE',
              owner: { role: 'ADMIN' },
            },
            data: {
              ownerId: BigInt(sellerId),
              ownerType: 'SELLER',
              status: 'AVAILABLE',
              ...(toLoc ? { currentLocationId: toLoc } : {}),
            },
          });

          await tx.inventoryTransaction.createMany({
            data: lockedIds.map((productUnitId) => ({
              productUnitId,
              fromUserId: updatedShipment.createdByAdminId,
              toUserId: BigInt(sellerId),
              action: 'RECEIVED',
              ...(fromLoc ? { fromLocationId: fromLoc } : {}),
              ...(toLoc ? { toLocationId: toLoc } : {}),
            })),
          });
        }
      }

      return updatedShipment;
    });
  }
}

module.exports = new ShipmentsRepository();
