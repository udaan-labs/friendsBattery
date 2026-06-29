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
        id: BigInt(sellerId),
        role: 'SELLER'
      }
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
}

module.exports = new ShopsRepository();
