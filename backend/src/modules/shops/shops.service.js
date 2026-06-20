const shopsRepository = require('./shops.repository');

/**
 * Shops Service
 *
 * Contains all business logic for the shops module.
 * Orchestrates transactions and interacts with the repository layer.
 * Does not access Express req/res directly.
 */
class ShopsService {
  /**
   * Fetch all active sellers.
   * Output: Array of sellers mapped to response format
   */
  async getSellers() {
    const sellers = await shopsRepository.findSellers();

    return sellers.map(user => ({
      id: Number(user.id),
      user_name: user.userName,
      shop_name: user.shopName,
      user_number: user.userNumber,
      is_verified: user.isVerified,
      created_at: user.createdAt
    }));
  }

  /**
   * Fetch details of a single seller.
   * Input: sellerId
   * Output: Seller details mapped to response format
   */
  async viewSeller(sellerId) {
    const user = await shopsRepository.findSellerById(sellerId);

    if (!user) {
      const error = new Error('Seller not found');
      error.statusCode = 404;
      throw error;
    }

    return {
      id: Number(user.id),
      user_name: user.userName,
      shop_name: user.shopName,
      user_number: user.userNumber,
      is_verified: user.isVerified,
      is_active: user.isActive,
      created_at: user.createdAt
    };
  }
}

module.exports = new ShopsService();
