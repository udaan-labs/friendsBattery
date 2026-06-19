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
      const { search, page, limit } = req.query;

      // Call business layer
      const inventory = await inventoryService.getInventory(userId, { search, page, limit });

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
      const { productId } = req.params;

      // Call business layer
      const inventoryItem = await inventoryService.getInventoryItem(userId, productId);

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
}

module.exports = new InventoryController();
