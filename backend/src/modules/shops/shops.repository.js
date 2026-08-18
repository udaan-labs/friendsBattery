const { prisma } = require('../../config/db');

/**
 * Shops Repository
 *
 * Handles all database operations for the shops module.
 * Does not contain any business logic or permission checks.
 * Uses Prisma Client for DB interactions.
 */
class ShopsRepository {
  /**
   * Fetch active sellers.
   * @param {{ OR?: object[] }|null} [scopeFilter] - e.g. { OR: [{ parentId }, { locationId }] }
   */
  async findSellers(scopeFilter = null) {
    const where = {
      role: 'SELLER',
      isActive: true,
    };
    if (scopeFilter?.OR) {
      where.OR = scopeFilter.OR;
    }
    return prisma.user.findMany({ where });
  }

  /** Set user's primary location (shop Admin first shop / employee move). */
  async updateUserLocationId(userId, locationId, shopName, parentId) {
    return prisma.user.update({
      where: { id: BigInt(userId) },
      data: {
        locationId: BigInt(locationId),
        ...(shopName !== undefined ? { shopName } : {}),
        ...(parentId !== undefined
          ? { parentId: parentId != null ? BigInt(parentId) : null }
          : {}),
      },
      select: { id: true, locationId: true },
    });
  }

  /**
   * Fetch a single seller by ID.
   * Input: sellerId (Number or BigInt)
   * Output: User object or null
   */
  async findSellerById(sellerId) {
    return prisma.user.findFirst({
      where: {
        id: BigInt(sellerId),
        role: 'SELLER'
      },
      include: {
        location: {
          select: { id: true, code: true, name: true, type: true, isActive: true },
        },
      },
    });
  }

  /**
   * Admin + sellers + employees assigned to a location.
   * @param {number|bigint} locationId
   */
  async findUsersByLocationId(locationId) {
    return prisma.user.findMany({
      where: {
        locationId: BigInt(locationId),
        role: { in: ['ADMIN', 'SELLER', 'EMPLOYEE'] },
      },
      select: {
        id: true,
        userId: true,
        userName: true,
        userNumber: true,
        shopName: true,
        role: true,
        parentId: true,
        locationId: true,
        isActive: true,
        isVerified: true,
        employeeRole: {
          select: { id: true, name: true, description: true },
        },
      },
      orderBy: [{ role: 'asc' }, { userName: 'asc' }],
    });
  }

  async findLocationById(locationId) {
    return prisma.location.findUnique({
      where: { id: BigInt(locationId) },
      select: {
        id: true,
        code: true,
        name: true,
        type: true,
        isActive: true,
        address: true,
        phone: true,
        latitude: true,
        longitude: true,
        allowedRadius: true,
        warehouseId: true,
      },
    });
  }

  async findLocationByCode(code) {
    return prisma.location.findUnique({
      where: { code },
      select: { id: true, code: true, name: true, type: true, isActive: true },
    });
  }

  async findCodesByType(type) {
    const rows = await prisma.location.findMany({
      where: { type },
      select: { code: true },
    });
    return rows.map((r) => r.code);
  }

  async findUserIdsByPrefix(prefix) {
    const rows = await prisma.user.findMany({
      where: { userId: { startsWith: prefix } },
      select: { userId: true },
    });
    return rows.map((r) => r.userId);
  }

  /**
   * Active locations for admin assignment (warehouse + shops).
   * @param {{ type?: 'SHOP'|'WAREHOUSE' }} [filter]
   */
  async findActiveLocations(filter = {}) {
    const where = { isActive: true };
    if (filter.type) {
      where.type = filter.type;
    }
    return prisma.location.findMany({
      where,
      select: {
        id: true,
        code: true,
        name: true,
        type: true,
        isActive: true,
        address: true,
        phone: true,
        latitude: true,
        longitude: true,
        allowedRadius: true,
        warehouseId: true,
      },
      orderBy: [{ type: 'asc' }, { name: 'asc' }],
    });
  }

  async updateLocation(locationId, data) {
    return prisma.location.update({
      where: { id: BigInt(locationId) },
      data: {
        name: data.name,
        address: data.address,
        latitude: data.latitude,
        longitude: data.longitude,
        allowedRadius: data.allowedRadius,
      },
      select: {
        id: true,
        code: true,
        name: true,
        type: true,
        isActive: true,
        address: true,
        phone: true,
        latitude: true,
        longitude: true,
        allowedRadius: true,
        warehouseId: true,
      },
    });
  }

  async createLocation(data) {
    return prisma.location.create({
      data: {
        code: data.code,
        name: data.name,
        type: data.type,
        address: data.address ?? null,
        phone: data.phone ?? null,
        latitude: data.latitude ?? null,
        longitude: data.longitude ?? null,
        ...(data.allowedRadius != null
          ? { allowedRadius: data.allowedRadius }
          : {}),
        warehouseId: data.warehouseId != null ? BigInt(data.warehouseId) : null,
        isActive: true,
      },
      select: {
        id: true,
        code: true,
        name: true,
        type: true,
        isActive: true,
        address: true,
        phone: true,
        latitude: true,
        longitude: true,
        allowedRadius: true,
        warehouseId: true,
        createdAt: true,
      },
    });
  }

  async findAllEmployeeRoles() {
    return prisma.employeeRole.findMany({
      select: { id: true, name: true, description: true },
      orderBy: { name: 'asc' },
    });
  }

  async findEmployeeRoleById(roleId) {
    return prisma.employeeRole.findUnique({
      where: { id: BigInt(roleId) },
      select: { id: true, name: true, description: true },
    });
  }

  async findUserById(id) {
    return prisma.user.findUnique({
      where: { id: BigInt(id) },
      select: {
        id: true,
        shopName: true,
        locationId: true,
        parentId: true,
        role: true,
      },
    });
  }

  /**
   * Create EMPLOYEE user at a location.
   * @param {object} data - Prisma create data (camelCase)
   */
  async createEmployeeUser(data) {
    return prisma.user.create({
      data,
      include: {
        location: {
          select: { id: true, code: true, name: true, type: true, isActive: true },
        },
        employeeRole: {
          select: { id: true, name: true, description: true },
        },
      },
    });
  }

  /**
   * Single staff user by id. Default EMPLOYEE only (admin view).
   * Pass roles `['ADMIN','EMPLOYEE']` for move.
   */
  async findEmployeeById(employeeId, roles = ['EMPLOYEE']) {
    return prisma.user.findFirst({
      where: {
        id: BigInt(employeeId),
        role: { in: roles },
      },
      include: {
        location: {
          select: { id: true, code: true, name: true, type: true, isActive: true },
        },
        employeeRole: {
          select: { id: true, name: true, description: true },
        },
      },
    });
  }

  /**
   * Fetch total stock count for a seller.
   * Input: sellerId (Number or BigInt)
   * Output: Number representing total available stock
   */
  async getSellerStock(sellerId) {
    return prisma.productUnit.count({
      where: {
        ownerId: BigInt(sellerId),
        status: 'AVAILABLE'
      }
    });
  }

  /**
   * Fetch total unique products count for a seller.
   * Input: sellerId (Number or BigInt)
   * Output: Number representing count of unique products
   */
  async getSellerProductsCount(sellerId) {
    const products = await prisma.productUnit.findMany({
      where: {
        ownerId: BigInt(sellerId),
        status: 'AVAILABLE'
      },
      distinct: ['productId'],
      select: {
        productId: true
      }
    });
    return products.length;
  }

  /**
   * Fetch total sales count for a seller.
   * Input: sellerId (Number or BigInt)
   * Output: Number representing total sales transactions
   */
  async getSellerSalesCount(sellerId) {
    return prisma.salesTransaction.count({
      where: {
        sellerId: BigInt(sellerId)
      }
    });
  }

  /**
   * Fetch total returns count for a seller.
   * Input: sellerId (Number or BigInt)
   * Output: Number representing total returned products
   */
  async getSellerReturnsCount(sellerId) {
    return prisma.returnProduct.count({
      where: {
        returnById: BigInt(sellerId)
      }
    });
  }
  /**
   * Fetch a list of seller IDs who have at least one product with available stock <= min_unit_count_seller.
   * Uses a single raw SQL query for performance.
   * Output: Array of Numbers representing seller IDs
   */
  async getLowStockSellers() {
    const rawResult = await prisma.$queryRaw`
      SELECT pu.owner_id as seller_id
      FROM product_units pu
      JOIN products p ON pu.product_id = p.id
      WHERE pu.owner_type = 'SELLER'
      GROUP BY pu.owner_id, pu.product_id, p.min_unit_count_seller
      HAVING COUNT(CASE WHEN pu.status = 'AVAILABLE' THEN 1 END) <= p.min_unit_count_seller
    `;
    return rawResult.map(r => Number(r.seller_id));
  }
}

module.exports = new ShopsRepository();
