const productsRepository = require('./products.repository');
const { resolveUnitScope } = require('../inventory/inventory.scope');
const { httpError } = require('../../shared/utils/http-error');
const { isAdminLikeRole } = require('../../shared/utils/role.util');

/** First letter upper; rest unchanged. "amaron" → "Amaron". */
function capitalizeFirst(name) {
  const t = String(name ?? '').trim();
  if (!t) return t;
  return t[0].toLocaleUpperCase() + t.slice(1);
}

function configSnapshot(product, data) {
  if (product) {
    return {
      min_price: Number(product.minPrice),
      on_sale: product.onSale,
      offer_price: product.offerPrice == null ? null : Number(product.offerPrice),
      min_unit_count_admin: product.minUnitCountAdmin,
      min_unit_count_seller: product.minUnitCountSeller
    };
  }
  return {
    min_price: data.min_price,
    on_sale: data.on_sale ?? false,
    offer_price: data.offer_price ?? null,
    min_unit_count_admin: data.min_unit_count_admin,
    min_unit_count_seller: data.min_unit_count_seller
  };
}

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
  async createProductName(data, actorId) {
    const name = capitalizeFirst(data.name);
    const existing = await productsRepository.findProductNameByName(name);
    if (existing) {
      throw httpError(409, 'Product name already exists');
    }
    const productName = await productsRepository.createProductName({ ...data, name });
    await productsRepository.createCatalogEvent({
      action: 'NAME_CREATED',
      actorId,
      productNameId: productName.id,
      payload: { name: productName.name }
    });
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
  async createProductModel(data, actorId) {
    const name = capitalizeFirst(data.name);
    const existing = await productsRepository.findProductModelByNameAndProductName(
      data.product_name_id,
      name
    );
    if (existing) {
      throw httpError(409, 'Product model already exists under this product name');
    }
    const model = await productsRepository.createProductModel({ ...data, name });
    await productsRepository.createCatalogEvent({
      action: 'MODEL_CREATED',
      actorId,
      productNameId: model.productNameId,
      productModelId: model.id,
      payload: { name: model.name }
    });
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
  async createProduct(data, actorId) {
    const existing = await productsRepository.findByNameAndModel(
      data.product_name_id,
      data.product_model_id
    );
    const before = existing ? configSnapshot(existing) : null;
    const product = existing
      ? await productsRepository.updateProductConfig(existing.id, data)
      : await productsRepository.createProduct(data);
    const after = configSnapshot(product);
    await productsRepository.createCatalogEvent({
      action: existing ? 'PRODUCT_UPDATED' : 'PRODUCT_CREATED',
      actorId,
      productNameId: product.productNameId,
      productModelId: product.productModelId,
      productId: product.id,
      payload: existing ? { before, after } : { after }
    });
    return {
      id: Number(product.id),
      product_name_id: Number(product.productNameId),
      product_model_id: Number(product.productModelId),
      min_price: Number(product.minPrice),
      on_sale: product.onSale,
      offer_price: product.offerPrice == null ? null : Number(product.offerPrice),
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
    if (isAdminLikeRole(role)) {
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

      const availableQuantity = isAdminLikeRole(role)
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
      min_price: Number(p.minPrice),
      on_sale: p.onSale,
      offer_price: p.offerPrice == null ? null : Number(p.offerPrice),
      min_unit_count_admin: p.minUnitCountAdmin,
      min_unit_count_seller: p.minUnitCountSeller
    }));
  }
}

module.exports = new ProductsService();
