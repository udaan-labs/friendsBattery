const productsService = require('./products.service');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

/**
 * Products Controller
 *
 * Handles HTTP requests for the products module.
 * Delegates all business logic to the service layer.
 */
class ProductsController {
  /**
   * Create a new product name
   */
  async createProductName(req, res) {
    try {
      const productName = await productsService.createProductName(req.body, req.user.id);
      return successResponse(res, 201, 'Product name created successfully', productName);
    } catch (error) {
      return handleRouteError(res, error, 'Create Product Name Error:');
    }
  }

  /**
   * Get all product names
   */
  async getProductNames(req, res) {
    try {
      const productNames = await productsService.getProductNames();
      return successResponse(res, 200, 'Product names fetched successfully', productNames);
    } catch (error) {
      return handleRouteError(res, error, 'Get Product Names Error:');
    }
  }

  /**
   * Create a new product model
   */
  async createProductModel(req, res) {
    try {
      const productModel = await productsService.createProductModel(req.body, req.user.id);
      return successResponse(res, 201, 'Product model created successfully', productModel);
    } catch (error) {
      return handleRouteError(res, error, 'Create Product Model Error:');
    }
  }

  /**
   * Get all product models for a product name
   */
  async getProductModelsByProductName(req, res) {
    try {
      const { product_name_id } = req.body;
      const productModels = await productsService.getProductModelsByProductName(product_name_id);
      return successResponse(res, 200, 'Product models fetched successfully', productModels);
    } catch (error) {
      return handleRouteError(res, error, 'Get Product Models Error:');
    }
  }

  /**
   * Create a new product
   */
  async createProduct(req, res) {
    try {
      const product = await productsService.createProduct(req.body, req.user.id);
      return successResponse(res, 201, 'Product created successfully', product);
    } catch (error) {
      return handleRouteError(res, error, 'Create Product Error:');
    }
  }

  /**
   * Get products available in the authenticated user's inventory.
   * Returns data grouped by product name with model details and stock counts.
   */
  async getInventoryProducts(req, res) {
    try {
      const userId = Number(req.user.id);
      const role = req.user.role;
      const products = await productsService.getInventoryProducts(userId, role);
      return successResponse(res, 200, 'Inventory products fetched successfully', products);
    } catch (error) {
      return handleRouteError(res, error, 'Get Inventory Products Error:');
    }
  }

  /**
   * Get all products matching filters
   */
  async getProducts(req, res) {
    try {
      const { product_name_id, product_model_id } = req.body;
      const products = await productsService.getProducts(product_name_id, product_model_id);
      return successResponse(res, 200, 'Products fetched successfully', products);
    } catch (error) {
      return handleRouteError(res, error, 'Get Products Error:');
    }
  }
}

module.exports = new ProductsController();
