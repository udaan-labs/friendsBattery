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
   * Fetch all active sellers.
   * Output: Array of User objects with role 'SELLER' and isActive true
   */
  async findSellers() {
    return prisma.user.findMany({
      where: {
        role: 'SELLER',
        isActive: true
      }
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
        id: sellerId,
        role: 'SELLER'
      }
    });
  }
}

module.exports = new ShopsRepository();
