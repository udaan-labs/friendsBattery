const { prisma } = require('../../config/db');
const { httpError } = require('../../shared/utils/http-error');

/**
 * Inventory Repository
 *
 * Handles all database operations for the inventory module.
 * Does not contain any business logic or permission checks.
 * Uses Prisma Client for DB interactions.
 */
class InventoryRepository {
  /**
   * Retrieves inventory grouped by product for a unit scope filter.
   * unitScope: Prisma filter on product_units (owner or current_location_id).
   */
  async findInventory(unitScope, { search, skip, take, includeOutOfStock }) {
    const whereClause = {};
    if (!includeOutOfStock) {
      whereClause.units = {
        some: {
          ...unitScope,
          status: 'AVAILABLE'
        }
      };
    } else {
      whereClause.units = {
        some: {
          ...unitScope
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
                ...unitScope,
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
   * Retrieves the total count of inventory items for a unit scope.
   */
  async countInventory(unitScope, { search, includeOutOfStock }) {
    const whereClause = {};
    if (!includeOutOfStock) {
      whereClause.units = {
        some: {
          ...unitScope,
          status: 'AVAILABLE'
        }
      };
    } else {
      whereClause.units = {
        some: {
          ...unitScope
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
   * Retrieves a single inventory item details for a unit scope.
   */
  async findInventoryByProduct(unitScope, productId) {
    const prodId = BigInt(productId);
    return prisma.product.findUnique({
      where: {
        id: prodId,
      },
      include: {
        productName: true,
        productModel: true,
        units: {
          where: {
            ...unitScope,
            status: 'AVAILABLE'
          },
          select: { serialNumber: true }
        },
        _count: {
          select: {
            units: {
              where: {
                ...unitScope,
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
   * Atomic claim: UPDATE WHERE id + claimWhere (status/owner), like sales.
   */
  async claimUnits(unitIds, claimWhere, data, tx = prisma) {
    return tx.productUnit.updateMany({
      where: {
        id: { in: unitIds },
        ...claimWhere,
      },
      data,
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
   * Finds a product unit by serial number.
   */
  async findUnitBySerial(serialNumber) {
    return prisma.productUnit.findUnique({
      where: {
        serialNumber
      },
      include: {
        product: true
      }
    });
  }

  /**
   * Removes a unit by atomic AVAILABLE→DEFECTIVE claim + audit log.
   */
  async removeUnit(unitId, actorId) {
    return prisma.$transaction(async (tx) => {
      const claimed = await tx.productUnit.updateMany({
        where: { id: unitId, status: 'AVAILABLE' },
        data: { status: 'DEFECTIVE' },
      });
      if (claimed.count !== 1) {
        throw httpError(409, 'Unit is no longer AVAILABLE');
      }
      const unit = await tx.productUnit.findUnique({ where: { id: unitId } });
      await tx.inventoryTransaction.create({
        data: {
          productUnitId: unitId,
          toUserId: actorId,
          action: 'ADJUSTED',
        }
      });
      return unit;
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
   * Find available serial numbers for a product within a unit scope.
   */
  async findAvailableSerials(unitScope, { productNameId, productModelId }) {
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

    // 2. Find units that are AVAILABLE in scope
    const units = await prisma.productUnit.findMany({
      where: {
        productId: product.id,
        ...unitScope,
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
   * Aggregates unit counts for product IDs grouped by status, filtered by unit scope.
   */
  async aggregateUnitCounts(productIds, unitScope) {
    return prisma.productUnit.groupBy({
      by: ['productId', 'status'],
      where: {
        productId: { in: productIds },
        ...unitScope
      },
      _count: {
        id: true
      }
    });
  }

  /**
   * Counts total products and total available inventory units for a product name.
   */
  async getProductNameStats(productNameId, unitScope) {
    const [totalProducts, totalInventory] = await Promise.all([
      prisma.product.count({
        where: { productNameId: BigInt(productNameId) }
      }),
      prisma.productUnit.count({
        where: {
          product: { productNameId: BigInt(productNameId) },
          status: 'AVAILABLE',
          ...unitScope
        }
      })
    ]);
    return { totalProducts, totalInventory };
  }
}

module.exports = new InventoryRepository();
