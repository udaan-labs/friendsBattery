const { prisma } = require('../../config/db');

/**
 * Products Repository
 *
 * Handles all database operations for the products module.
 * Contains only Prisma queries.
 */
class ProductsRepository {
  /**
   * Find a category by name to prevent duplicates
   */
  async findCategoryByName(name) {
    return prisma.category.findUnique({
      where: { name }
    });
  }

  /**
   * Create a new category
   */
  async createCategory(data) {
    return prisma.category.create({
      data: {
        name: data.name
      }
    });
  }

  /**
   * Fetch all categories
   * Ordered alphabetically by name
   */
  async getCategories() {
    return prisma.category.findMany({
      orderBy: {
        name: 'asc'
      }
    });
  }

  /**
   * Find a product name by categoryId and name
   * Used to prevent duplicates under the same category
   */
  async findProductNameByNameAndCategory(categoryId, name) {
    return prisma.productName.findFirst({
      where: {
        categoryId,
        name
      }
    });
  }

  /**
   * Create a new product name under a category
   */
  async createProductName(data) {
    return prisma.productName.create({
      data: {
        categoryId: data.category_id,
        name: data.name
      }
    });
  }

  /**
   * Fetch all product names for a given category
   */
  async getProductNamesByCategory(categoryId) {
    return prisma.productName.findMany({
      where: {
        categoryId
      },
      orderBy: {
        name: 'asc'
      }
    });
  }

  /**
   * Find a product model by productNameId and name
   * Used to prevent duplicates under the same product name
   */
  async findProductModelByNameAndProductName(productNameId, name) {
    return prisma.productModel.findFirst({
      where: {
        productNameId,
        name
      }
    });
  }

  /**
   * Create a new product model
   */
  async createProductModel(data) {
    return prisma.productModel.create({
      data: {
        productNameId: data.product_name_id,
        name: data.name
      }
    });
  }

  /**
   * Fetch all product models for a given product name
   */
  async getProductModelsByProductName(productNameId) {
    return prisma.productModel.findMany({
      where: {
        productNameId
      },
      orderBy: {
        name: 'asc'
      }
    });
  }

  /**
   * Create a new product
   */
  async createProduct(data) {
    return prisma.product.create({
      data: {
        categoryId: data.category_id,
        productNameId: data.product_name_id,
        productModelId: data.product_model_id,
        minPrice: data.min_price,
        onSale: data.on_sale,
        offerPrice: data.offer_price,
        minQuantity: data.min_quantity
      }
    });
  }

  /**
   * Fetch all products
   */
  async getProducts() {
    return prisma.product.findMany({
      include: {
        category: true,
        productName: true,
        productModel: true
      },
      orderBy: {
        id: 'desc'
      }
    });
  }
}

module.exports = new ProductsRepository();
