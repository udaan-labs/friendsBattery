const inventoryService = require('./inventory.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

/**
 * Inventory Controller
 *
 * Handles incoming inventory HTTP requests.
 * Delegates business logic to InventoryService.
 * Does not contain business logic.
 */
class InventoryController {
  /**
   * Return logged-in user's inventory.
   * Admin returns admin inventory.
   * Seller returns only seller inventory.
   */
  async getInventory(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const { search, page, limit, includeOutOfStock } = req.query;

      // Call business layer
      const inventory = await inventoryService.getInventory(userId, role, { search, page, limit, includeOutOfStock });

      // Return standardized success response
      return successResponse(res, 200, 'Inventory fetched successfully', inventory);
    } catch (error) {
      console.error('Get Inventory Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Return one inventory item.
   */
  async getInventoryItem(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const { productId } = req.params;

      // Call business layer
      const inventoryItem = await inventoryService.getInventoryItem(userId, role, productId);

      // Return standardized success response
      return successResponse(res, 200, 'Inventory item fetched successfully', inventoryItem);
    } catch (error) {
      if (error.statusCode === 404) {
        return errorResponse(res, 404, error.message);
      }
      console.error('Get Inventory Item Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Adjust inventory levels.
   * Admin only.
   */
  async adjustInventory(req, res) {
    try {
      const { product_id, user_id, adjustment_quantity } = req.body;

      // Call business layer
      const result = await inventoryService.adjustInventory({ product_id, user_id, adjustment_quantity });

      // Return standardized success response
      return successResponse(res, 200, 'Inventory adjusted successfully', result);
    } catch (error) {
      if (error.statusCode === 400) {
        return errorResponse(res, 400, error.message);
      }
      console.error('Adjust Inventory Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Transfer inventory from admin to seller.
   * Admin only.
   */
  async transferInventory(req, res) {
    try {
      const adminId = Number(req.user.id);
      const { seller_id, products } = req.body;

      // Call business layer
      const result = await inventoryService.transferInventory(adminId, seller_id, products);

      // Return standardized success response
      return successResponse(res, 200, 'Inventory transferred successfully', result);
    } catch (error) {
      if (error.statusCode === 400) {
        return errorResponse(res, 400, error.message);
      }
      console.error('Transfer Inventory Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Return inventory movement history.
   */
  async getHistory(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const filters = req.query;

      // Call business layer
      const history = await inventoryService.getHistory(userId, role, filters);

      // Return standardized success response
      return successResponse(res, 200, 'Inventory history fetched successfully', history);
    } catch (error) {
      console.error('Get Inventory History Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Update stock (Admin only).
   */
  async updateStock(req, res) {
    try {
      const adminId = Number(req.user.id);
      const { productNameId, productModelId, quantity, minSellPrice, minUnitCountAdmin, minUnitCountSeller, onSale } = req.body;

      // Call business layer
      const result = await inventoryService.updateStock(adminId, {
        productNameId,
        productModelId,
        quantity,
        minSellPrice,
        minUnitCountAdmin,
        minUnitCountSeller,
        onSale
      });

      // Return standardized success response
      return successResponse(res, 200, 'Stock updated successfully', result);
    } catch (error) {
      if (error.statusCode === 400 || error.statusCode === 404) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Update Stock Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Fetch details of a product (stock count & min sell price) by product name and model IDs
   */
  async getProductDetails(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const { product_name_id, product_model_id } = req.query;

      const details = await inventoryService.getProductDetails(userId, role, {
        productNameId: Number(product_name_id),
        productModelId: Number(product_model_id)
      });

      return successResponse(res, 200, 'Product details fetched successfully', details);
    } catch (error) {
      console.error('Get Product Details Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Fetch available serial numbers for a product owned by the logged-in user.
   */
  async getAvailableSerials(req, res) {
    try {
      const userId = Number(req.user.id);
      const { product_name_id, product_model_id } = req.query;

      const serials = await inventoryService.getAvailableSerials(userId, {
        productNameId: Number(product_name_id),
        productModelId: Number(product_model_id)
      });

      return successResponse(res, 200, 'Available serials fetched successfully', serials);
    } catch (error) {
      console.error('Get Available Serials Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Fetch inventory details summary grouped by ProductName -> Product.
   */
  async getInventoryDetails(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const { product_name_id, search, page, limit } = req.query;

      // Call business layer
      const details = await inventoryService.getInventoryDetails(userId, role, {
        product_name_id,
        search,
        page,
        limit
      });

      // Return standardized success response
      return successResponse(res, 200, 'Inventory details fetched successfully', details);
    } catch (error) {
      console.error('Get Inventory Details Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }
  /**
   * Scan a serial number to fetch product details for a sale
   */
  async scanForSale(req, res) {
    try {
      const { serial_number } = req.query;
      const sellerId = req.user.id;

      if (!serial_number) {
        return errorResponse(res, 400, 'Serial number is required');
      }

      const productDetails = await inventoryService.scanForSale(serial_number, sellerId);
      return successResponse(res, 200, 'Product found successfully', productDetails);
    } catch (error) {
      if (error.message === 'Product not found in your available inventory') {
        return errorResponse(res, 404, error.message);
      }
      console.error('Scan For Sale Error:', error);
      return errorResponse(res, 500, 'Internal server error while scanning product');
    }
  }
}

module.exports = new InventoryController();

