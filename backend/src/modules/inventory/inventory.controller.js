const inventoryService = require('./inventory.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

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
   * Admin: admin-owned units. Seller: owner_id. Employee: current_location_id.
   */
  async getInventory(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const locationId = req.user.locationId ?? null;
      const { search, page, limit, includeOutOfStock, location_id } = req.query;

      // Call business layer
      const inventory = await inventoryService.getInventory(userId, role, {
        search,
        page,
        limit,
        includeOutOfStock,
        locationId,
        filterLocationId: location_id ?? null,
        actor: req.user,
      });

      // Return standardized success response
      return successResponse(res, 200, 'Inventory fetched successfully', inventory);
    } catch (error) {
      return handleRouteError(res, error, 'Get Inventory Error:');
    }
  }

  /**
   * Return one inventory item.
   */
  async getInventoryItem(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const locationId = req.query.location_id ? Number(req.query.location_id) : (req.query.locationId ? Number(req.query.locationId) : (req.user.locationId ?? null));
      const { productId } = req.params;

      const inventoryItem = await inventoryService.getInventoryItem(
        userId,
        role,
        productId,
        locationId,
        req.user
      );

      return successResponse(res, 200, 'Inventory item fetched successfully', inventoryItem);
    } catch (error) {
      return handleRouteError(res, error, 'Get Inventory Item Error:');
    }
  }

  /**
   * Adjust inventory levels.
   * Admin only.
   */
  async adjustInventory(req, res) {
    try {
      const { product_id, user_id, adjustment_quantity } = req.body;

      const result = await inventoryService.adjustInventory(
        { product_id, user_id, adjustment_quantity },
        req.user
      );

      return successResponse(res, 200, 'Inventory adjusted successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Adjust Inventory Error:');
    }
  }

  /**
   * Update stock (Admin only).
   */
  async updateStock(req, res) {
    try {
      const adminId = Number(req.user.id);
      const {
        productNameId,
        productModelId,
        quantity,
        serial_numbers,
        minSellPrice,
        minUnitCountAdmin,
        minUnitCountSeller,
        onSale,
        location_id,
      } = req.body;

      // Call business layer
      const result = await inventoryService.updateStock(
        adminId,
        {
          productNameId,
          productModelId,
          quantity,
          serial_numbers,
          minSellPrice,
          minUnitCountAdmin,
          minUnitCountSeller,
          onSale,
          location_id,
        },
        { role: req.user.role, locationId: req.user.locationId ?? null }
      );

      // Return standardized success response
      return successResponse(res, 200, 'Stock updated successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Update Stock Error:');
    }
  }

  /**
   * Fetch details of a product (stock count & min sell price) by product name and model IDs
   */
  async getProductDetails(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const locationId = req.user.locationId ?? null;
      const { product_name_id, product_model_id } = req.query;

      const details = await inventoryService.getProductDetails(userId, role, {
        productNameId: Number(product_name_id),
        productModelId: Number(product_model_id),
        locationId,
      });

      return successResponse(res, 200, 'Product details fetched successfully', details);
    } catch (error) {
      return handleRouteError(res, error, 'Get Product Details Error:');
    }
  }

  /**
   * Fetch available serial numbers for a product in the logged-in user's inventory scope.
   */
  async getAvailableSerials(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const locationId = req.user.locationId ?? null;
      const { product_name_id, product_model_id } = req.query;

      const serials = await inventoryService.getAvailableSerials(userId, role, {
        productNameId: Number(product_name_id),
        productModelId: Number(product_model_id),
        locationId,
      });

      return successResponse(res, 200, 'Available serials fetched successfully', serials);
    } catch (error) {
      return handleRouteError(res, error, 'Get Available Serials Error:');
    }
  }

  /**
   * Fetch inventory details summary grouped by ProductName -> Product.
   */
  async getInventoryDetails(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const locationId = req.user.locationId ?? null;
      const { product_name_id, search, page, limit } = req.query;

      // Call business layer
      const details = await inventoryService.getInventoryDetails(userId, role, {
        product_name_id,
        search,
        page,
        limit,
        locationId,
      });

      // Return standardized success response
      return successResponse(res, 200, 'Inventory details fetched successfully', details);
    } catch (error) {
      return handleRouteError(res, error, 'Get Inventory Details Error:');
    }
  }
  /**
   * Scan a serial number to fetch product details for a sale
   */
  async scanForSale(req, res) {
    try {
      const { serial_number } = req.query;

      if (!serial_number) {
        return errorResponse(res, 400, 'Serial number is required');
      }

      const productDetails = await inventoryService.scanForSale(serial_number, {
        id: req.user.id,
        role: req.user.role,
        locationId: req.user.locationId ?? null,
      });
      return successResponse(res, 200, 'Product found successfully', productDetails);
    } catch (error) {
      return handleRouteError(res, error, 'Scan For Sale Error:');
    }
  }

  /**
   * Remove a specific serial number unit from inventory.
   */
  async removeUnit(req, res) {
    try {
      const { serialNumber } = req.params;
      const result = await inventoryService.removeUnit(serialNumber, req.user);
      return successResponse(res, 200, 'Unit removed successfully', result);
    } catch (error) {
      return handleRouteError(res, error, 'Remove Unit Error:');
    }
  }
}

module.exports = new InventoryController();

