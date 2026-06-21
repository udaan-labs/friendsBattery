const productsRepository = require('./products.repository');

/**
 * Products Service
 *
 * Contains all business logic for the products module.
 * Orchestrates validations and interacts with the repository layer.
 */
class ProductsService {
  /**
   * Create a new category
   * Ensures the category name is unique before creating
   */
  async createCategory(data) {
    const existing = await productsRepository.findCategoryByName(data.name);
    if (existing) {
      const error = new Error('Category already exists');
      error.statusCode = 409;
      throw error;
    }
    const category = await productsRepository.createCategory(data);
    return {
      id: Number(category.id),
      name: category.name
    };
  }

  /**
   * Get all categories
   */
  async getCategories() {
    const categories = await productsRepository.getCategories();
    return categories.map(c => ({
      id: Number(c.id),
      name: c.name
    }));
  }

  /**
   * Create a new product name under a category
   * Ensures the name is unique within the category
   */
  async createProductName(data) {
    const existing = await productsRepository.findProductNameByNameAndCategory(data.category_id, data.name);
    if (existing) {
      const error = new Error('Product name already exists under this category');
      error.statusCode = 409;
      throw error;
    }
    const productName = await productsRepository.createProductName(data);
    return {
      id: Number(productName.id),
      category_id: Number(productName.categoryId),
      name: productName.name
    };
  }

  /**
   * Get all product names for a category
   */
  async getProductNamesByCategory(categoryId) {
    const productNames = await productsRepository.getProductNamesByCategory(categoryId);
    return productNames.map(p => ({
      id: Number(p.id),
      name: p.name
    }));
  }

  /**
   * Create a new product model
   * Ensures the model is unique within the product name
   */
  async createProductModel(data) {
    const existing = await productsRepository.findProductModelByNameAndProductName(data.product_name_id, data.name);
    if (existing) {
      const error = new Error('Product model already exists under this product name');
      error.statusCode = 409;
      throw error;
    }
    const model = await productsRepository.createProductModel(data);
    return {
      id: Number(model.id),
      product_name_id: Number(model.productNameId),
      name: model.name
    };
  }

  /**
   * Get all product models for a product name
   */
  async getProductModelsByProductName(productNameId) {
    const models = await productsRepository.getProductModelsByProductName(productNameId);
    return models.map(m => ({
      id: Number(m.id),
      name: m.name
    }));
  }

  /**
   * Create a new product
   */
  async createProduct(data) {
    const product = await productsRepository.createProduct(data);
    return {
      id: Number(product.id),
      category_id: Number(product.categoryId),
      product_name_id: Number(product.productNameId),
      product_model_id: Number(product.productModelId),
      min_price: product.minPrice,
      on_sale: product.onSale,
      offer_price: product.offerPrice,
      min_quantity: product.minQuantity,
      created_at: product.createdAt
    };
  }

  /**
   * Get all products
   */
  async getProducts() {
    const products = await productsRepository.getProducts();
    return products.map(p => ({
      id: Number(p.id),
      category: {
        id: Number(p.category.id),
        name: p.category.name
      },
      product_name: {
        id: Number(p.productName.id),
        name: p.productName.name
      },
      product_model: {
        id: Number(p.productModel.id),
        name: p.productModel.name
      },
      min_price: p.minPrice,
      on_sale: p.onSale,
      offer_price: p.offerPrice,
      min_quantity: p.minQuantity,
      created_at: p.createdAt
    }));
  }
}

module.exports = new ProductsService();
