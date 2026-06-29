const { prisma } = require('../../config/db');

/**
 * Transfers Repository
 *
 * Handles all database operations for the transfers (shipments) module.
 * Contains only Prisma queries — no business logic.
 */
class TransfersRepository {
  /**
   * Find a seller by ID
   * Input: sellerId (Number/BigInt)
   * Output: User object or null
   */
  async findSellerById(sellerId) {
    return prisma.user.findFirst({
      where: {
        id: sellerId,
        role: 'SELLER'
      }
    });
  }

  /**
   * Find a product by ID
   * Input: productId (Number/BigInt)
   * Output: Product object or null
   */
  async findProductById(productId) {
    return prisma.product.findUnique({
      where: { id: productId }
    });
  }

  /**
   * Count available AVAILABLE units for a specific product owned by a user
   * Input: ownerId, productId
   * Output: Number of available units
   */
  async countAvailableUnits(ownerId, productId) {
    return prisma.productUnit.count({
      where: {
        ownerId,
        productId,
        status: 'AVAILABLE'
      }
    });
  }

  /**
   * Create a shipment record with its items
   * Input: shipment data object with nested items
   * Output: Created shipment with items
   */
  async createShipment(data) {
    return prisma.shipment.create({
      data: {
        fromUserId: data.fromUserId,
        toUserId: data.toUserId,
        totalProductsShipped: data.totalProductsShipped,
        shipmentPrice: data.shipmentPrice,
        status: 'PENDING',
        items: {
          create: data.items
        }
      },
      include: {
        items: true
      }
    });
  }

  /**
   * Fetch all shipments (Admin view)
   * Output: Array of shipments with sender, receiver details
   */
  async getAllShipments() {
    return prisma.shipment.findMany({
      include: {
        fromUser: { select: { id: true, userName: true, shopName: true } },
        toUser: { select: { id: true, userName: true, shopName: true } }
      },
      orderBy: { createdAt: 'desc' }
    });
  }

  /**
   * Fetch shipments for a specific seller (where they are the receiver)
   * Input: sellerId
   * Output: Array of shipments assigned to the seller
   */
  async getShipmentsBySeller(sellerId) {
    return prisma.shipment.findMany({
      where: { toUserId: sellerId },
      include: {
        fromUser: { select: { id: true, userName: true, shopName: true } },
        toUser: { select: { id: true, userName: true, shopName: true } }
      },
      orderBy: { createdAt: 'desc' }
    });
  }

  /**
   * Find a single shipment by ID with full details including items and product info
   * Input: shipmentId
   * Output: Shipment object with relations or null
   */
  async findShipmentById(shipmentId) {
    return prisma.shipment.findUnique({
      where: { id: shipmentId },
      include: {
        fromUser: { select: { id: true, userName: true, shopName: true } },
        toUser: { select: { id: true, userName: true, shopName: true } },
        items: {
          include: {
            product: {
              include: {
                category: true,
                productName: true,
                productModel: true
              }
            }
          }
        }
      }
    });
  }

  /**
   * Execute the full receive shipment workflow inside a Prisma transaction.
   * This atomically:
   *   1. Finds available admin units for each shipment item
   *   2. Transfers ownership from admin to seller
   *   3. Creates inventory_transactions ledger entries
   *   4. Marks shipment as DELIVERED
   *
   * Input: shipmentId, shipment object (with items), fromUserId, toUserId
   * Output: Updated shipment record
   */
  async receiveShipment(shipmentId, shipment) {
    return prisma.$transaction(async (tx) => {
      // Process each shipment item
      for (const item of shipment.items) {
        // 1. Find available AVAILABLE units owned by admin for this product
        const availableUnits = await tx.productUnit.findMany({
          where: {
            ownerId: shipment.fromUserId,
            productId: item.productId,
            status: 'AVAILABLE'
          },
          take: item.quantity
        });

        if (availableUnits.length < item.quantity) {
          throw new Error(
            `Insufficient admin inventory for product ID ${Number(item.productId)}. Required: ${item.quantity}, Available: ${availableUnits.length}`
          );
        }

        const unitIds = availableUnits.map(u => u.id);

        // 2. Transfer ownership: update ownerId to seller
        await tx.productUnit.updateMany({
          where: { id: { in: unitIds } },
          data: { ownerId: shipment.toUserId }
        });

        // 3. Create immutable ledger entries in inventory_transactions
        const ledgerEntries = unitIds.map(unitId => ({
          productUnitId: unitId,
          fromUserId: shipment.fromUserId,
          toUserId: shipment.toUserId,
          action: 'TRANSFERRED'
        }));

        await tx.inventoryTransaction.createMany({
          data: ledgerEntries
        });
      }

      // 4. Mark shipment as DELIVERED with timestamp
      const updatedShipment = await tx.shipment.update({
        where: { id: shipmentId },
        data: {
          status: 'DELIVERED',
          deliveredOn: new Date()
        }
      });

      return updatedShipment;
    });
  }

  /**
   * Cancel a shipment by updating its status to CANCELLED
   * Input: shipmentId
   * Output: Updated shipment record
   */
  async cancelShipment(shipmentId) {
    return prisma.shipment.update({
      where: { id: shipmentId },
      data: { status: 'CANCELLED' }
    });
  }
}

module.exports = new TransfersRepository();
