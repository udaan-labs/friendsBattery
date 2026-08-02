const { prisma } = require('../../config/db');

/**
 * Products Repository
 *
 * Handles all database operations for the products module.
 * Contains only Prisma queries.
 */
class ProductsRepository {
  /**
   * Find a product name by name to prevent duplicates
   */
  async findProductNameByName(name) {
    return prisma.productName.findUnique({
      where: { name }
    });
  }

  /**
   * Find a product name by ID
   */
  async findProductNameById(id) {
    return prisma.productName.findUnique({
      where: { id: BigInt(id) }
    });
  }

  /**
   * Create a new product name
   */
  async createProductName(data) {
    return prisma.productName.create({
      data: {
        name: data.name
      }
    });
  }

  /**
   * Fetch all product names
   * Ordered alphabetically by name
   */
  async getProductNames() {
    return prisma.productName.findMany({
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
        productNameId: BigInt(productNameId),
        name
      }
    });
  }

  /**
   * Find a product model by ID
   */
  async findProductModelById(id) {
    return prisma.productModel.findUnique({
      where: { id: BigInt(id) }
    });
  }

  /**
   * Create a new product model
   */
  async createProductModel(data) {
    return prisma.productModel.create({
      data: {
        productNameId: BigInt(data.product_name_id),
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
        productNameId: BigInt(productNameId)
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
        productNameId: BigInt(data.product_name_id),
        productModelId: BigInt(data.product_model_id),
        minPrice: data.min_price,
        onSale: data.on_sale,
        offerPrice: data.offer_price,
        minUnitCountAdmin: data.min_unit_count_admin,
        minUnitCountSeller: data.min_unit_count_seller
      }
    });
  }

  /**
   * Find products that the admin has stock for (stockQuantity > 0)
   */
  async findAdminInventoryProducts() {
    return prisma.product.findMany({
      where: {
        stockQuantity: { gt: 0 }
      },
      include: {
        productName: true,
        productModel: true
      },
      orderBy: [
        { productName: { name: 'asc' } },
        { productModel: { name: 'asc' } }
      ]
    });
  }

  /**
   * Find products that have available (AVAILABLE) units matching unitScope.
   * unitScope: e.g. { ownerId } for seller or { currentLocationId } for employee.
   */
  async findInventoryProducts(unitScope) {
    return prisma.product.findMany({
      where: {
        units: {
          some: {
            ...unitScope,
            status: 'AVAILABLE'
          }
        }
      },
      include: {
        productName: true,
        productModel: true,
        _count: {
          select: {
            units: {
              where: {
                ...unitScope,
                status: 'AVAILABLE'
              }
            }
          }
        }
      },
      orderBy: [
        { productName: { name: 'asc' } },
        { productModel: { name: 'asc' } }
      ]
    });
  }

  /**
   * Fetch all products
   */
  async getProducts() {
    return prisma.product.findMany({
      include: {
        productName: true,
        productModel: true
      },
      orderBy: {
        id: 'desc'
      }
    });
  }

  /**
   * Fetch products by product name and product model
   */
  async getProductsByFilters(productNameId, productModelId) {
    return prisma.product.findMany({
      where: {
        productNameId: BigInt(productNameId),
        productModelId: BigInt(productModelId)
      },
      include: {
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
