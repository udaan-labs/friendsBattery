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
  async findInventory(userId, role, { search, skip, take, includeOutOfStock }) {
    const ownerFilter = role === 'ADMIN' ? { owner: { role: 'ADMIN' } } : { ownerId: BigInt(userId) };

    const whereClause = {};
    if (!includeOutOfStock) {
      whereClause.units = {
        some: {
          ...ownerFilter,
          status: 'AVAILABLE'
        }
      };
    } else {
      whereClause.units = {
        some: {
          ...ownerFilter
        }
      };
    }

    if (search) {
      whereClause.OR = [
        { productName: { name: { contains: search, mode: 'insensitive' } } },
        { productModel: { name: { contains: search, mode: 'insensitive' } } }
      ];
    }

    const queryOptions = {
      where: whereClause,
      include: {
        productName: true,
        productModel: true,
        _count: {
          select: {
            units: {
              where: {
                ...ownerFilter,
                status: 'AVAILABLE'
              }
            }
          }
        }
      }
    };

    if (skip !== undefined && take !== undefined) {
      queryOptions.skip = Number(skip);
      queryOptions.take = Number(take);
    }

    return prisma.product.findMany(queryOptions);
  }


  /**
   * Retrieves the total count of inventory items for a user based on search criteria.
   */
  async countInventory(userId, role, { search, includeOutOfStock }) {
    const ownerFilter = role === 'ADMIN' ? { owner: { role: 'ADMIN' } } : { ownerId: BigInt(userId) };

    const whereClause = {};
    if (!includeOutOfStock) {
      whereClause.units = {
        some: {
          ...ownerFilter,
          status: 'AVAILABLE'
        }
      };
    } else {
      whereClause.units = {
        some: {
          ...ownerFilter
        }
      };
    }

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
   */
  async findInventoryByProduct(userId, role, productId) {
    const ownerFilter = role === 'ADMIN' ? { owner: { role: 'ADMIN' } } : { ownerId: BigInt(userId) };

    return prisma.product.findFirst({
      where: {
        id: productId,
        units: {
          some: {
            ...ownerFilter,
            status: 'AVAILABLE'
          }
        }
      },
      include: {
        productName: true,
        productModel: true,
        units: {
          where: {
            ...ownerFilter,
            status: 'AVAILABLE'
          },
          select: { serialNumber: true }
        },
        _count: {
          select: {
            units: {
              where: {
                ...ownerFilter,
                status: 'AVAILABLE'
              }
            }
          }
        }
      }
    });
  }

  /**
   * Creates new inventory units in the database.
   */
  async createInventory(unitsData, tx = prisma) {
    return tx.productUnit.createManyAndReturn({
      data: unitsData
    });
  }

  /**
   * Updates inventory units status or ownership.
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
   * Retrieves available AVAILABLE units for a specific product and user.
   */
  async findAvailableUnits(userId, productId, quantity, tx = prisma) {
    return tx.productUnit.findMany({
      where: {
        ownerId: userId,
        productId: productId,
        status: 'AVAILABLE'
      },
      take: quantity
    });
  }

  /**
   * Finds a seller by ID
   */
  async findSeller(sellerId) {
    return prisma.user.findUnique({
      where: { id: sellerId }
    });
  }

  /**
   * Creates an inventory transaction record (audit log).
   */
  async createInventoryTransaction(data, tx = prisma) {
    return tx.inventoryTransaction.createMany({
      data
    });
  }

  /**
   * Retrieves inventory history.
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
      skip: skip !== undefined ? Number(skip) : undefined,
      take: take !== undefined ? Number(take) : undefined,
      orderBy: { timestamp: 'desc' }
    });
  }

  /**
   * Create a shipment record.
   */
  async createShipment(data, tx = prisma) {
    return tx.shipment.create({
      data
    });
  }

  /**
   * Create shipment item records.
   */
  async createShipmentItem(data, tx = prisma) {
    return tx.shipmentItem.createMany({
      data
    });
  }

  /**
   * Find available serial numbers for a product owned by a specific user.
   * Input: userId, productNameId, productModelId
   * Output: Array of strings representing serial numbers.
   */
  async findAvailableSerials(userId, { productNameId, productModelId }) {
    // 1. Find product
    const product = await prisma.product.findFirst({
      where: {
        productNameId: BigInt(productNameId),
        productModelId: BigInt(productModelId)
      }
    });

    if (!product) {
      return [];
    }

    // 2. Find units that are AVAILABLE
    const units = await prisma.productUnit.findMany({
      where: {
        productId: product.id,
        ownerId: BigInt(userId),
        status: 'AVAILABLE'
      },
      select: {
        serialNumber: true
      }
    });

    return units.map(u => u.serialNumber);
  }

  /**
   * Retrieves products for the inventory details summary, based on filters.
   */
  async findInventoryDetails({ productNameId, search, skip, take }) {
    const whereClause = {};

    if (productNameId) {
      whereClause.productNameId = BigInt(productNameId);
    }
    if (search) {
      whereClause.OR = [
        { productName: { name: { contains: search, mode: 'insensitive' } } },
        { productModel: { name: { contains: search, mode: 'insensitive' } } }
      ];
    }

    const queryOptions = {
      where: whereClause,
      include: {
        productName: true,
        productModel: true
      },
      orderBy: {
        id: 'asc'
      }
    };

    if (skip !== undefined && take !== undefined) {
      queryOptions.skip = Number(skip);
      queryOptions.take = Number(take);
    }

    return prisma.product.findMany(queryOptions);
  }

  /**
   * Counts the total number of products matching inventory details filters.
   */
  async countInventoryDetails({ productNameId, search }) {
    const whereClause = {};

    if (productNameId) {
      whereClause.productNameId = BigInt(productNameId);
    }
    if (search) {
      whereClause.OR = [
        { productName: { name: { contains: search, mode: 'insensitive' } } },
        { productModel: { name: { contains: search, mode: 'insensitive' } } }
      ];
    }

    return prisma.product.count({ where: whereClause });
  }

  /**
   * Aggregates unit counts for product IDs grouped by status, filtered by owner.
   */
  async aggregateUnitCounts(productIds, ownerFilter) {
    return prisma.productUnit.groupBy({
      by: ['productId', 'status'],
      where: {
        productId: { in: productIds },
        ...ownerFilter
      },
      _count: {
        id: true
      }
    });
  }

  /**
   * Counts total products and total available inventory units for a product name.
   */
  async getProductNameStats(productNameId, ownerFilter) {
    const [totalProducts, totalInventory] = await Promise.all([
      prisma.product.count({
        where: { productNameId: BigInt(productNameId) }
      }),
      prisma.productUnit.count({
        where: {
          product: { productNameId: BigInt(productNameId) },
          status: 'AVAILABLE',
          ...ownerFilter
        }
      })
    ]);
    return { totalProducts, totalInventory };
  }
}

module.exports = new InventoryRepository();
