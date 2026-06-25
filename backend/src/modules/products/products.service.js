const productsRepository = require('./products.repository');

/**
 * Products Service
 *
 * Contains all business logic for the products module.
 * Orchestrates validations and interacts with the repository layer.
 */
class ProductsService {
  /**
   * Create a new group
   * Ensures the group name is unique before creating
   */
  async createGroup(data) {
    const existing = await productsRepository.findGroupByName(data.name);
    if (existing) {
      const error = new Error('Group already exists');
      error.statusCode = 409;
      throw error;
    }
    const group = await productsRepository.createGroup(data);
    return {
      id: Number(group.id),
      name: group.name
    };
  }

  /**
   * Get all groups
   */
  async getGroups() {
    const groups = await productsRepository.getGroups();
    return groups.map(g => ({
      id: Number(g.id),
      name: g.name
    }));
  }

  /**
   * Create a new category
   * Ensures the category name is unique before creating
   */
  async createCategory(data) {
    const group = await productsRepository.findGroupById(data.group_id);
    if (!group) {
      const error = new Error('Group not found');
      error.statusCode = 404;
      throw error;
    }

    const existing = await productsRepository.findCategoryByName(data.name);
    if (existing) {
      const error = new Error('Category already exists');
      error.statusCode = 409;
      throw error;
    }
    const category = await productsRepository.createCategory(data);
    return {
      id: Number(category.id),
      name: category.name,
      group_id: Number(category.groupId)
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
   * Get all categories for a given group
   * Validates if the group exists before querying
   *
   * Input:
   *  groupId
   *
   * Returns:
   *  Array of categories.
   */
  async getCategoriesByGroup(groupId) {
    const group = await productsRepository.findGroupById(groupId);
    if (!group) {
      const error = new Error('Group not found');
      error.statusCode = 404;
      throw error;
    }

    const categories = await productsRepository.getCategoriesByGroup(groupId);
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
   * Validates if the category exists before querying
   *
   * Input:
   *  categoryId
   *
   * Returns:
   *  Array of product names.
   */
  async getProductNamesByCategory(categoryId) {
    const category = await productsRepository.findCategoryById(categoryId);
    if (!category) {
      const error = new Error('Category not found');
      error.statusCode = 404;
      throw error;
    }

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
   * Validates parent entities exist before querying
   *
   * Input:
   *  categoryId, productNameId
   *
   * Returns:
   *  Array of product models.
   */
  async getProductModelsByProductName(categoryId, productNameId) {
    const category = await productsRepository.findCategoryById(categoryId);
    if (!category) {
      const error = new Error('Category not found');
      error.statusCode = 404;
      throw error;
    }

    const productName = await productsRepository.findProductNameById(productNameId);
    if (!productName || Number(productName.categoryId) !== categoryId) {
      const error = new Error('Product name not found or does not belong to the selected category');
      error.statusCode = 404;
      throw error;
    }

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
      min_unit_count_admin: product.minUnitCountAdmin,
      min_unit_count_seller: product.minUnitCountSeller,
      created_at: product.createdAt
    };
  }

  /**
   * Fetch matching products by category, product name, and product model
   * Validates parent entities exist before querying child data
   *
   * Input:
   *  categoryId, productNameId, productModelId
   *
   * Returns:
   *  Array of products.
   */
  async getProducts(categoryId, productNameId, productModelId) {
    const category = await productsRepository.findCategoryById(categoryId);
    if (!category) {
      const error = new Error('Category not found');
      error.statusCode = 404;
      throw error;
    }

    const productName = await productsRepository.findProductNameById(productNameId);
    if (!productName || Number(productName.categoryId) !== categoryId) {
      const error = new Error('Product name not found or does not belong to the selected category');
      error.statusCode = 404;
      throw error;
    }

    const productModel = await productsRepository.findProductModelById(productModelId);
    if (!productModel || Number(productModel.productNameId) !== productNameId) {
      const error = new Error('Product model not found or does not belong to the selected product name');
      error.statusCode = 404;
      throw error;
    }

    const products = await productsRepository.getProductsByFilters(categoryId, productNameId, productModelId);
    return products.map(p => ({
      id: Number(p.id),
      category: p.category.name,
      product_name: p.productName.name,
      product_model: p.productModel.name,
      min_price: p.minPrice,
      on_sale: p.onSale,
      offer_price: p.offerPrice,
      min_unit_count_admin: p.minUnitCountAdmin,
      min_unit_count_seller: p.minUnitCountSeller
    }));
  }
}

module.exports = new ProductsService();
