const { prisma } = require('../../config/db');
const { getDefaultWarehouseId, getUserLocationId } = require('../../shared/utils/location.util');
const { httpError } = require('../../shared/utils/http-error');

async function resolveUnitsForSerials(tx, { adminId, serials }) {
  const ownerId = BigInt(adminId);
  const existing = await tx.productUnit.findMany({
    where: {
      status: 'AVAILABLE',
      ownerId,
      OR: serials.map((s) => ({ serialNumber: { equals: s, mode: 'insensitive' } })),
    },
    include: {
      product: { select: { id: true, productNameId: true, productModelId: true } },
    },
  });
  const bySerial = new Map(existing.map((u) => [u.serialNumber.toLowerCase(), u]));
  const units = [];
  for (const serial of serials) {
    const u = bySerial.get(serial.toLowerCase());
    if (!u) {
      throw httpError(400, `Serial number(s) unavailable or not in admin inventory: ${serial}`);
    }
    units.push(u);
  }
  return units;
}

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
      include: {
        location: { select: { id: true, type: true, warehouseId: true } },
      },
    });
  }

  /**
   * Atomic admin → seller serial transfer. Serials must already exist on admin units.
   * Product is resolved from each unit (no name/model in the request).
   * @param {{ sellerId: number, adminId: number, serials: string[] }} data
   */
  async transferUnitsToSeller(data) {
    const { sellerId, adminId, serials } = data;

    return prisma.$transaction(async (tx) => {
      const allUnits = await resolveUnitsForSerials(tx, { adminId, serials });
      const byProduct = new Map();
      for (const unit of allUnits) {
        const pid = Number(unit.productId);
        let entry = byProduct.get(pid);
        if (!entry) {
          entry = { product: unit.product, units: [] };
          byProduct.set(pid, entry);
        }
        entry.units.push(unit);
      }
      const boundItems = [...byProduct.values()];
      const unitIds = allUnits.map((u) => u.id);

      const moved = await tx.productUnit.updateMany({
        where: {
          id: { in: unitIds },
          status: 'AVAILABLE',
          ownerId: BigInt(adminId),
        },
        data: { status: 'IN_SHIPMENT' },
      });
      if (moved.count !== unitIds.length) {
        throw httpError(409,
          'One or more serial numbers are no longer available. Refresh and try again.'
        );
      }

      const count = await tx.newShipment.count();
      const shipment = await tx.newShipment.create({
        data: {
          shipmentNumber: `SHP-${100 + count + 1}`,
          sellerId: BigInt(sellerId),
          createdByAdminId: BigInt(adminId),
          status: 'PENDING',
          acceptedAt: null,
          items: {
            create: boundItems.flatMap((r) =>
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

      await tx.inventoryTransaction.createMany({
        data: unitIds.map((productUnitId) => ({
          productUnitId,
          fromUserId: BigInt(adminId),
          toUserId: BigInt(sellerId),
          action: 'SHIPPED',
          ...(fromLoc ? { fromLocationId: fromLoc } : {}),
          ...(toLoc ? { toLocationId: toLoc } : {}),
        })),
      });

      for (const r of boundItems) {
        await tx.product.update({
          where: { id: r.product.id },
          data: { stockQuantity: { decrement: r.units.length } },
        });
      }

      return {
        shipmentId: Number(shipment.id),
        shipmentNumber: shipment.shipmentNumber,
        status: shipment.status,
        transferredUnits: allUnits.length,
        sellerId: Number(sellerId),
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

  /**
   * Shop Admin: shipments they sent or to their sellers.
   * @param {number|bigint} adminId
   * @param {bigint[]} sellerIds
   */
  async getShipmentsForShopAdmin(adminId, sellerIds) {
    const toIds = (sellerIds || []).map((id) => BigInt(id));
    return prisma.newShipment.findMany({
      where: {
        OR: [
          { createdByAdminId: BigInt(adminId) },
          ...(toIds.length ? [{ sellerId: { in: toIds } }] : []),
        ],
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
          const adminOwnerId = updatedShipment.createdByAdminId;
          const locked = await tx.productUnit.findMany({
            where: {
              id: { in: productUnitIds },
              status: { in: ['IN_SHIPMENT', 'AVAILABLE'] },
              ownerId: adminOwnerId,
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
