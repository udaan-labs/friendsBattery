const productsService = require('./products.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

/**
 * Products Controller
 *
 * Handles HTTP requests for the products module.
 * Delegates all business logic to the service layer.
 */
class ProductsController {
  /**
   * Create a new category
   */
  async createCategory(req, res) {
    try {
      const category = await productsService.createCategory(req.body);
      return successResponse(res, 201, 'Category created successfully', category);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Create Category Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Get all categories
   */
  async getCategories(req, res) {
    try {
      const categories = await productsService.getCategories();
      return successResponse(res, 200, 'Categories fetched successfully', categories);
    } catch (error) {
      console.error('Get Categories Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Create a new product name under a category
   */
  async createProductName(req, res) {
    try {
      const productName = await productsService.createProductName(req.body);
      return successResponse(res, 201, 'Product name created successfully', productName);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Create Product Name Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Get all product names for a category
   */
  async getProductNamesByCategory(req, res) {
    try {
      const { category_id } = req.body;
      const productNames = await productsService.getProductNamesByCategory(category_id);
      return successResponse(res, 200, 'Product names fetched successfully', productNames);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Get Product Names Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Create a new product model
   */
  async createProductModel(req, res) {
    try {
      const productModel = await productsService.createProductModel(req.body);
      return successResponse(res, 201, 'Product model created successfully', productModel);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Create Product Model Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Get all product models for a product name
   */
  async getProductModelsByProductName(req, res) {
    try {
      const { category_id, product_name_id } = req.body;
      const productModels = await productsService.getProductModelsByProductName(category_id, product_name_id);
      return successResponse(res, 200, 'Product models fetched successfully', productModels);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Get Product Models Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Create a new product
   */
  async createProduct(req, res) {
    try {
      const product = await productsService.createProduct(req.body);
      return successResponse(res, 201, 'Product created successfully', product);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Create Product Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * Get all products
   */
  async getProducts(req, res) {
    try {
      const { category_id, product_name_id, product_model_id } = req.body;
      const products = await productsService.getProducts(category_id, product_name_id, product_model_id);
      return successResponse(res, 200, 'Products fetched successfully', products);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Get Products Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }
}

module.exports = new ProductsController();
