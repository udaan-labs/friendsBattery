const { prisma } = require('../../config/db');

/**
 * Inventory Repository
 *
 * Handles all database operations for the inventory module.
 * Does not contain any business logic or permission checks.
 * Uses Prisma Client for DB interactions.
 */
class InventoryRepository {
  /**
   * Retrieves user's inventory grouped by product.
   * Input: userId (BigInt)
   * Output: Array of products with their unit count for the user.
   */
  async findInventory(userId, { search, skip, take }) {
    const whereClause = {
      units: {
        some: {
          ownerId: userId,
          status: 'IN_STOCK'
        }
      }
    };

    if (search) {
      whereClause.OR = [
        { productName: { name: { contains: search, mode: 'insensitive' } } },
        { productModel: { name: { contains: search, mode: 'insensitive' } } }
      ];
    }

    const queryOptions = {
      where: whereClause,
      include: {
        category: true,
        productName: true,
        productModel: true,
        _count: {
          select: {
            units: {
              where: {
                ownerId: userId,
                status: 'IN_STOCK'
              }
            }
          }
        }
      }
    };

    if (skip !== undefined && take !== undefined) {
      queryOptions.skip = skip;
      queryOptions.take = take;
    }

    return prisma.product.findMany(queryOptions);
  }

  /**
   * Retrieves the total count of inventory items for a user based on search criteria.
   * Input: userId (BigInt), search object
   * Output: Integer representing total count
   */
  async countInventory(userId, { search }) {
    const whereClause = {
      units: {
        some: {
          ownerId: userId,
          status: 'IN_STOCK'
        }
      }
    };

    if (search) {
      whereClause.OR = [
        { productName: { name: { contains: search, mode: 'insensitive' } } },
        { productModel: { name: { contains: search, mode: 'insensitive' } } }
      ];
    }

    return prisma.product.count({ where: whereClause });
  }

  /**
   * Retrieves a single inventory item details for a user.
   * Input: userId (BigInt), productId (BigInt)
   * Output: Product object with unit count, or null if not found.
   */
  async findInventoryByProduct(userId, productId) {
    return prisma.product.findFirst({
      where: {
        id: productId,
        units: {
          some: {
            ownerId: userId,
            status: 'IN_STOCK'
          }
        }
      },
      include: {
        category: true,
        productName: true,
        productModel: true,
        _count: {
          select: {
            units: {
              where: {
                ownerId: userId,
                status: 'IN_STOCK'
              }
            }
          }
        }
      }
    });
  }

  /**
   * Creates new inventory units in the database.
   * Input: Array of unit data objects
   * Output: Array of created units
   */
  async createInventory(unitsData, tx = prisma) {
    return tx.productUnit.createManyAndReturn({
      data: unitsData
    });
  }

  /**
   * Updates inventory units status or ownership.
   * Input: Array of unit IDs, update payload
   * Output: Updated records count
   */
  async updateInventory(unitIds, data, tx = prisma) {
    return tx.productUnit.updateMany({
      where: {
        id: { in: unitIds }
      },
      data
    });
  }

  /**
   * Retrieves available IN_STOCK units for a specific product and user.
   * Input: userId, productId, quantity
   * Output: Array of ProductUnit records
   */
  async findAvailableUnits(userId, productId, quantity, tx = prisma) {
    return tx.productUnit.findMany({
      where: {
        ownerId: userId,
        productId: productId,
        status: 'IN_STOCK'
      },
      take: quantity
    });
  }

  /**
   * Finds a seller by ID
   * Input: sellerId
   * Output: User object
   */
  async findSeller(sellerId) {
    return prisma.user.findUnique({
      where: { id: sellerId }
    });
  }

  /**
   * Creates an inventory transaction record (audit log).
   * Input: transaction data
   * Output: created transaction
   */
  async createInventoryTransaction(data, tx = prisma) {
    return tx.inventoryTransaction.createMany({
      data
    });
  }

  /**
   * Retrieves inventory history.
   * Input: filter options (userId, fromDate, toDate, productId)
   * Output: Array of inventory transactions
   */
  async findHistory(filters, { skip, take }) {
    return prisma.inventoryTransaction.findMany({
      where: filters,
      include: {
        productUnit: {
          include: { product: true }
        },
        fromUser: { select: { userName: true, shopName: true } },
        toUser: { select: { userName: true, shopName: true } }
      },
      skip,
      take,
      orderBy: { timestamp: 'desc' }
    });
  }

  /**
   * Create a shipment record.
   * Input: shipment data
   * Output: created shipment
   */
  async createShipment(data, tx = prisma) {
    return tx.shipment.create({
      data
    });
  }

  /**
   * Create shipment item records.
   * Input: array of shipment items data
   * Output: created items count
   */
  async createShipmentItem(data, tx = prisma) {
    return tx.shipmentItem.createMany({
      data
    });
  }
}

module.exports = new InventoryRepository();
