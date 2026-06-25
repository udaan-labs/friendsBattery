const crypto = require('crypto');
const inventoryRepository = require('./inventory.repository');
const { prisma } = require('../../config/db');

/**
 * Inventory Service
 *
 * Contains all business logic for the inventory module.
 * Orchestrates transactions and interacts with the repository layer.
 * Does not access Express req/res directly.
 */
class InventoryService {
  /**
   * Fetch inventory for a specific user.
   * Input: userId, search, page, limit
   * Output: Array of inventory items mapped to response format
   */
  async getInventory(userId, { search, page = 1, limit = 10 }) {
    const skip = (page - 1) * limit;
    const [products, total] = await Promise.all([
      inventoryRepository.findInventory(userId, { search, skip, take: limit }),
      inventoryRepository.countInventory(userId, { search })
    ]);

    return {
      data: products.map(p => ({
        product_id: Number(p.id),
        category: p.category?.name || '',
        brand: p.productName?.name || '',
        model: p.productModel?.name || '',
        quantity: p._count.units,
        min_price: Number(p.minPrice),
        offer_price: p.offerPrice ? Number(p.offerPrice) : null
      })),
      pagination: {
        total,
        page: Number(page),
        limit: Number(limit),
        total_pages: Math.ceil(total / limit)
      }
    };
  }

  /**
   * Fetch single inventory item details for a specific user.
   * Input: userId, productId
   * Output: Inventory item details
   */
  async getInventoryItem(userId, productId) {
    const product = await inventoryRepository.findInventoryByProduct(userId, productId);
    
    if (!product) {
      const error = new Error('Inventory item not found');
      error.statusCode = 404;
      throw error;
    }

    return {
      product_id: Number(product.id),
      category: product.category?.name || '',
      brand: product.productName?.name || '',
      model: product.productModel?.name || '',
      quantity: product._count.units,
      min_price: Number(product.minPrice),
      offer_price: product.offerPrice ? Number(product.offerPrice) : null
    };
  }

  /**
   * Adjust stock levels (Admin only).
   * Input: payload containing product_id, user_id, and adjustment_quantity
   * Output: adjustment result
   */
  async adjustInventory({ product_id, user_id, adjustment_quantity }) {
    if (adjustment_quantity === 0) {
      return { success: true, message: 'No adjustment needed' };
    }

    // Wrap in a transaction to ensure atomicity
    return prisma.$transaction(async (tx) => {
      if (adjustment_quantity > 0) {
        // Positive adjustment: increase stock by creating new product units
        const unitsData = Array.from({ length: adjustment_quantity }).map(() => ({
          productId: product_id,
          ownerId: user_id,
          serialNumber: `ADJ-${Date.now()}-${crypto.randomUUID()}`,
          status: 'IN_STOCK'
        }));

        const createdUnits = await inventoryRepository.createInventory(unitsData, tx);
        const auditLogs = createdUnits.map(unit => ({
          productUnitId: unit.id,
          toUserId: user_id,
          action: 'ADJUSTED_IN'
        }));
        await inventoryRepository.createInventoryTransaction(auditLogs, tx);
      } else {
        // Negative adjustment: decrease stock
        const decreaseAmount = Math.abs(adjustment_quantity);
        const availableUnits = await inventoryRepository.findAvailableUnits(user_id, product_id, decreaseAmount, tx);

        if (availableUnits.length < decreaseAmount) {
          const error = new Error('Not enough stock to decrease');
          error.statusCode = 400;
          throw error;
        }

        const unitIds = availableUnits.map(u => u.id);

        // Mark units as ADJUSTED_OUT to simulate decrease
        await inventoryRepository.updateInventory(unitIds, { status: 'ADJUSTED_OUT' }, tx);

        // Create audit logs
        const auditLogs = unitIds.map(unitId => ({
          productUnitId: unitId,
          toUserId: user_id,
          action: 'ADJUSTED_OUT'
        }));
        await inventoryRepository.createInventoryTransaction(auditLogs, tx);
      }
      
      return { adjusted: true, adjustment_quantity };
    });
  }

  /**
   * Transfer inventory from Admin to Seller.
   * Input: adminId, sellerId, array of products (with product_id, quantity)
   * Output: shipment details
   */
  async transferInventory(adminId, sellerId, products) {
    // Validate seller existence
    const seller = await inventoryRepository.findSeller(sellerId);
    if (!seller || seller.role !== 'SELLER') {
      const error = new Error('Invalid seller');
      error.statusCode = 400;
      throw error;
    }

    // Atomicity is required for inventory transfers to avoid partial stock updates
    return prisma.$transaction(async (tx) => {
      const unitIdsToTransfer = [];
      const shipmentItemsData = [];
      let totalProductsShipped = 0;

      // Validate admin stock for each product
      for (const item of products) {
        const availableUnits = await inventoryRepository.findAvailableUnits(adminId, item.product_id, item.quantity, tx);

        if (availableUnits.length < item.quantity) {
          const error = new Error(`Not enough stock for product ID: ${item.product_id}`);
          error.statusCode = 400;
          throw error;
        }

        const ids = availableUnits.map(u => u.id);
        unitIdsToTransfer.push(...ids);

        shipmentItemsData.push({
          productId: item.product_id,
          quantity: item.quantity
        });

        totalProductsShipped += item.quantity;
      }

      // Decrease admin inventory & Increase seller inventory (Changing ownerId)
      await inventoryRepository.updateInventory(unitIdsToTransfer, { ownerId: sellerId }, tx);

      // Create shipment record
      const shipment = await inventoryRepository.createShipment({
        fromUserId: adminId,
        toUserId: sellerId,
        totalProductsShipped,
        shipmentPrice: 0, // Simplified for now
        status: 'SHIPPED',
        shippedOn: new Date()
      }, tx);

      // Create shipment items
      const itemsToCreate = shipmentItemsData.map(item => ({
        shipmentId: shipment.id,
        productId: item.productId,
        quantity: item.quantity,
        isShipmentRequested: false
      }));
      await inventoryRepository.createShipmentItem(itemsToCreate, tx);

      // Create audit logs (InventoryTransaction)
      const auditLogs = unitIdsToTransfer.map(unitId => ({
        productUnitId: unitId,
        fromUserId: adminId,
        toUserId: sellerId,
        action: 'TRANSFERRED'
      }));
      await inventoryRepository.createInventoryTransaction(auditLogs, tx);

      return {
        shipment_id: Number(shipment.id),
        total_products_shipped: totalProductsShipped,
        status: shipment.status
      };
    });
  }

  /**
   * Fetch inventory history (Audit logs).
   * Input: userId, role, filters (from_date, to_date, product_id, seller_id, page, limit)
   * Output: Array of history records
   */
  async getHistory(userId, role, { from_date, to_date, product_id, seller_id, page = 1, limit = 10 }) {
    const filters = {};

    // Apply role-based filtering
    if (role === 'SELLER') {
      filters.OR = [
        { fromUserId: userId },
        { toUserId: userId }
      ];
    } else if (role === 'ADMIN' && seller_id) {
      filters.OR = [
        { fromUserId: seller_id },
        { toUserId: seller_id }
      ];
    }

    // Apply product filter
    if (product_id) {
      filters.productUnit = { productId: product_id };
    }

    // Apply date filters
    if (from_date || to_date) {
      filters.timestamp = {};
      if (from_date) filters.timestamp.gte = new Date(from_date);
      if (to_date) filters.timestamp.lte = new Date(to_date);
    }

    const skip = (page - 1) * limit;
    const history = await inventoryRepository.findHistory(filters, { skip, take: limit });

    return history.map(record => ({
      transaction_id: Number(record.id),
      product_id: Number(record.productUnit.productId),
      serial_number: record.productUnit.serialNumber,
      action: record.action,
      from_user: record.fromUser ? record.fromUser.userName : null,
      to_user: record.toUser ? record.toUser.userName : null,
      timestamp: record.timestamp
    }));
  }

  /**
   * Update stock (Admin only).
   * Input: adminId, payload
   * Output: updated stock details
   */
  async updateStock(adminId, { productCategoryId, productNameId, productModelId, quantity, minSellPrice }) {
    // 1. Validate category existence
    const category = await prisma.category.findUnique({
      where: { id: BigInt(productCategoryId) }
    });
    if (!category) {
      const error = new Error('Category not found');
      error.statusCode = 404;
      throw error;
    }

    // 2. Validate product name existence and that it belongs to the category
    const productName = await prisma.productName.findUnique({
      where: { id: BigInt(productNameId) }
    });
    if (!productName || Number(productName.categoryId) !== productCategoryId) {
      const error = new Error('Product name not found or does not belong to the selected category');
      error.statusCode = 404;
      throw error;
    }

    // 3. Validate product model existence and that it belongs to the product name
    const productModel = await prisma.productModel.findUnique({
      where: { id: BigInt(productModelId) }
    });
    if (!productModel || Number(productModel.productNameId) !== productNameId) {
      const error = new Error('Product model not found or does not belong to the selected product name');
      error.statusCode = 404;
      throw error;
    }

    return prisma.$transaction(async (tx) => {
      // Find or create product
      let product = await tx.product.findFirst({
        where: {
          categoryId: BigInt(productCategoryId),
          productNameId: BigInt(productNameId),
          productModelId: BigInt(productModelId)
        }
      });

      if (!product) {
        // Create new product
        product = await tx.product.create({
          data: {
            categoryId: BigInt(productCategoryId),
            productNameId: BigInt(productNameId),
            productModelId: BigInt(productModelId),
            minPrice: minSellPrice !== undefined ? minSellPrice : 0,
            onSale: false,
            minUnitCountAdmin: 0,
            minUnitCountSeller: 0
          }
        });
      } else if (minSellPrice !== undefined) {
        // Update minPrice
        product = await tx.product.update({
          where: { id: product.id },
          data: { minPrice: minSellPrice }
        });
      }

      // Count existing units for this admin
      const existingQuantity = await tx.productUnit.count({
        where: {
          productId: product.id,
          ownerId: BigInt(adminId),
          status: 'IN_STOCK'
        }
      });

      // Create new product units
      const unitsData = Array.from({ length: quantity }).map(() => ({
        productId: product.id,
        ownerId: BigInt(adminId),
        serialNumber: `STOCK-${Date.now()}-${crypto.randomUUID()}`,
        status: 'IN_STOCK'
      }));

      const createdUnits = await tx.productUnit.createManyAndReturn({
        data: unitsData
      });

      // Create inventory transactions for the immutable ledger
      const transactionLogs = createdUnits.map(unit => ({
        productUnitId: unit.id,
        fromUserId: null,
        toUserId: BigInt(adminId),
        action: 'RECEIVED'
      }));

      await tx.inventoryTransaction.createMany({
        data: transactionLogs
      });

      return {
        productCategoryId,
        productNameId,
        productModelId,
        quantity: existingQuantity + quantity,
        minSellPrice: Number(product.minPrice)
      };
    });
  }

  /**
   * Fetch details of a product (stock count & min sell price) by category, product name, and model IDs
   */
  async getProductDetails(userId, { categoryId, productNameId, productModelId }) {
    // 1. Find product
    const product = await prisma.product.findFirst({
      where: {
        categoryId: BigInt(categoryId),
        productNameId: BigInt(productNameId),
        productModelId: BigInt(productModelId)
      }
    });

    if (!product) {
      return {
        productId: null,
        currentStock: 0,
        minSellPrice: 0
      };
    }

    // 2. Count stock
    const stockCount = await prisma.productUnit.count({
      where: {
        productId: product.id,
        ownerId: BigInt(userId),
        status: 'IN_STOCK'
      }
    });

    return {
      productId: Number(product.id),
      currentStock: stockCount,
      minSellPrice: Number(product.minPrice)
    };
  }

  /**
   * Fetch available serial numbers for a product owned by a specific user.
   */
  async getAvailableSerials(userId, { categoryId, productNameId, productModelId }) {
    return inventoryRepository.findAvailableSerials(userId, { categoryId, productNameId, productModelId });
  }

  /**
   * Fetch inventory details grouped by Category -> Subcategory -> Product.
   * Input: userId, role, filters
   * Output: Grouped inventory details and pagination
   */
  async getInventoryDetails(userId, role, { category_id, subcategory_id, search, page = 1, limit = 10 }) {
    const pageNum = Number(page);
    const limitNum = Number(limit);
    const skip = (pageNum - 1) * limitNum;

    // Filter stock counts to only show the logged-in user's own stock
    const ownerFilter = {
      ownerId: BigInt(userId)
    };

    const filters = {
      categoryId: category_id,
      subcategoryId: subcategory_id,
      search,
      skip,
      take: limitNum
    };

    // 1. Fetch paginated products and total product count
    const [products, total] = await Promise.all([
      inventoryRepository.findInventoryDetails(filters),
      inventoryRepository.countInventoryDetails(filters)
    ]);

    if (products.length === 0) {
      return {
        categories: [],
        pagination: {
          total,
          page: Number(page),
          limit: Number(limit),
          total_pages: Math.ceil(total / limit)
        }
      };
    }

    // 2. Extract unique product, category, and subcategory IDs in the current page
    const productIds = products.map(p => p.id);
    const categoryIds = [...new Set(products.map(p => p.categoryId))];
    const subcategoryIds = [...new Set(products.map(p => p.productNameId))];

    // 3. Fetch product unit aggregates (total, sold, remaining)
    const unitGroups = await inventoryRepository.aggregateUnitCounts(productIds, ownerFilter);
    const countMap = {};
    for (const group of unitGroups) {
      const pid = Number(group.productId);
      const status = group.status;
      const count = group._count.id;

      if (!countMap[pid]) {
        countMap[pid] = { total: 0, sold: 0, remaining: 0 };
      }

      countMap[pid].total += count;

      if (status === 'SOLD') {
        countMap[pid].sold += count;
      } else if (status === 'IN_STOCK') {
        countMap[pid].remaining += count;
      }
    }

    // 4. Fetch Category and Subcategory Stats (Total products and total available inventory)
    const [categoryStats, subcategoryStats] = await Promise.all([
      Promise.all(categoryIds.map(async (catId) => {
        const stats = await inventoryRepository.getCategoryStats(catId, ownerFilter);
        return { categoryId: catId, ...stats };
      })),
      Promise.all(subcategoryIds.map(async (subCatId) => {
        const stats = await inventoryRepository.getSubcategoryStats(subCatId, ownerFilter);
        return { subcategoryId: subCatId, ...stats };
      }))
    ]);

    const categoryMap = new Map(categoryStats.map(s => [s.categoryId, s]));
    const subcategoryMap = new Map(subcategoryStats.map(s => [s.subcategoryId, s]));

    // 5. Build hierarchy: Category -> Subcategory -> Product
    const categories = [];
    for (const product of products) {
      const catId = product.categoryId;
      const subcatId = product.productNameId;
      const prodId = product.id;

      // Find or create Category node
      let catNode = categories.find(c => c.categoryId === Number(catId));
      if (!catNode) {
        const catStats = categoryMap.get(catId) || { totalProducts: 0, totalInventory: 0 };
        catNode = {
          categoryId: Number(catId),
          categoryName: product.category.name,
          totalProducts: catStats.totalProducts,
          totalInventory: catStats.totalInventory,
          subcategories: []
        };
        categories.push(catNode);
      }

      // Find or create Subcategory node
      let subcatNode = catNode.subcategories.find(s => s.subcategoryId === Number(subcatId));
      if (!subcatNode) {
        const subcatStats = subcategoryMap.get(subcatId) || { totalProducts: 0, totalInventory: 0 };
        subcatNode = {
          subcategoryId: Number(subcatId),
          subcategoryName: product.productName.name,
          totalProducts: subcatStats.totalProducts,
          totalInventory: subcatStats.totalInventory,
          products: []
        };
        catNode.subcategories.push(subcatNode);
      }

      // Add Product node
      const counts = countMap[Number(prodId)] || { total: 0, sold: 0, remaining: 0 };
      subcatNode.products.push({
        productId: Number(prodId),
        productName: product.productModel.name,
        totalQuantity: counts.total,
        soldQuantity: counts.sold,
        remainingQuantity: counts.remaining
      });
    }

    return {
      categories,
      pagination: {
        total,
        page: Number(page),
        limit: Number(limit),
        total_pages: Math.ceil(total / limit)
      }
    };
  }
}

module.exports = new InventoryService();

