const productsRepository = require('./products.repository');
const { resolveUnitScope } = require('../inventory/inventory.scope');
const { httpError } = require('../../shared/utils/http-error');

/**
 * Products Service
 *
 * Contains all business logic for the products module.
 * Orchestrates validations and interacts with the repository layer.
 */
class ProductsService {
  /**
   * Create a new product name
   * Ensures the name is globally unique before creating
   */
  async createProductName(data) {
    const existing = await productsRepository.findProductNameByName(data.name);
    if (existing) {
      throw httpError(409, 'Product name already exists');
    }
    const productName = await productsRepository.createProductName(data);
    return {
      id: Number(productName.id),
      name: productName.name
    };
  }

  /**
   * Get all product names
   */
  async getProductNames() {
    const productNames = await productsRepository.getProductNames();
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
      throw httpError(409, 'Product model already exists under this product name');
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
   *
   * Input:
   *  productNameId
   *
   * Returns:
   *  Array of product models.
   */
  async getProductModelsByProductName(productNameId) {
    const productName = await productsRepository.findProductNameById(productNameId);
    if (!productName) {
      throw httpError(404, 'Product name not found');
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
   * Get products available in the authenticated user's inventory.
   * Admin: product stockQuantity. Seller: owner_id. Employee: current_location_id.
   */
  async getInventoryProducts(userId, role) {
    let products;
    if (role === 'ADMIN' || role === 'SUPER_ADMIN') {
      products = await productsRepository.findAdminInventoryProducts();
    } else {
      const unitScope = await resolveUnitScope(userId, role);
      if (!unitScope) {
        return [];
      }
      products = await productsRepository.findInventoryProducts(unitScope);
    }

    const groupedMap = new Map();

    for (const product of products) {
      const nameKey = product.productName.name;
      if (!groupedMap.has(nameKey)) {
        groupedMap.set(nameKey, {
          productName: nameKey,
          productNameId: Number(product.productNameId),
          models: []
        });
      }

      const availableQuantity = (role === 'ADMIN' || role === 'SUPER_ADMIN')
        ? Number(product.stockQuantity)
        : product._count.units;

      groupedMap.get(nameKey).models.push({
        id: Number(product.id),
        productModelId: Number(product.productModelId),
        productModel: product.productModel.name,
        availableQuantity,
        minSellPrice: Number(product.minPrice)
      });
    }

    return Array.from(groupedMap.values());
  }

  /**
   * Fetch matching products by product name and product model
   *
   * Input:
   *  productNameId, productModelId
   *
   * Returns:
   *  Array of products.
   */
  async getProducts(productNameId, productModelId) {
    const productName = await productsRepository.findProductNameById(productNameId);
    if (!productName) {
      throw httpError(404, 'Product name not found');
    }

    const productModel = await productsRepository.findProductModelById(productModelId);
    if (!productModel || Number(productModel.productNameId) !== productNameId) {
      throw httpError(404, 'Product model not found or does not belong to the selected product name');
    }

    const products = await productsRepository.getProductsByFilters(productNameId, productModelId);
    return products.map(p => ({
      id: Number(p.id),
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
