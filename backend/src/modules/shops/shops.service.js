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
    const dashboardRepository = require('../dashboard/dashboard.repository');

    // Fetch low stock sellers efficiently
    const lowStockSellerIds = await shopsRepository.getLowStockSellers();
    const lowStockSellerIdSet = new Set(lowStockSellerIds);

    // Enrich each seller with live stats in parallel
    const enriched = await Promise.all(
      sellers.map(async (user) => {
        const [totalStock, todaySales, pendingShipments] = await Promise.all([
          dashboardRepository.getSellerTotalStock(user.id),
          dashboardRepository.getSellerTodaySales(user.id),
          dashboardRepository.getSellerPendingShipmentsCount(user.id)
        ]);
        return {
          id: Number(user.id),
          user_name: user.userName,
          shop_name: user.shopName,
          user_number: user.userNumber,
          is_verified: user.isVerified,
          is_active: user.isActive,
          created_at: user.createdAt,
          totalStock,
          todaySales: todaySales.count,
          todaySalesAmount: todaySales.amount,
          pendingShipments,
          hasLowStock: lowStockSellerIdSet.has(Number(user.id))
        };
      })
    );

    return enriched;
  }

  /**
   * Fetch details of a single seller.
   * Input: sellerId
   * Output: Seller details mapped to response format
   */
  async viewSeller(sellerId, includeOutOfStock = false) {
    const inventoryService = require('../inventory/inventory.service');
    // We use Promise.all() to execute independent database queries in parallel.
    // This reduces the total response time instead of waiting for each query sequentially.
    const [
      user,
      stockCount,
      productsCount,
      salesCount,
      returnsCount,
      inventoryData
    ] = await Promise.all([
      shopsRepository.findSellerById(sellerId),
      shopsRepository.getSellerStock(sellerId),
      shopsRepository.getSellerProductsCount(sellerId),
      shopsRepository.getSellerSalesCount(sellerId),
      shopsRepository.getSellerReturnsCount(sellerId),
      inventoryService.getInventory(sellerId, 'SELLER', { page: 1, limit: 1000000, includeOutOfStock })
    ]);

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
      is_active: user.isActive,
      is_verified: user.isVerified,
      statistics: {
        stock: stockCount,
        products: productsCount,
        sales: salesCount,
        returns: returnsCount
      },
      inventory: inventoryData.data,
      created_at: user.createdAt
    };
  }
}

module.exports = new ShopsService();
