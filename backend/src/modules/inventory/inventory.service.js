const crypto = require('crypto');
const inventoryRepository = require('./inventory.repository');
const { resolveUnitScope } = require('./inventory.scope');
const { getDefaultWarehouseId, getUserLocationId } = require('../../shared/utils/location.util');
const { prisma } = require('../../config/db');
const { httpError } = require('../../shared/utils/http-error');
const { isAdminLikeRole } = require('../../shared/utils/role.util');

/**
 * Inventory Service
 *
 * Contains all business logic for the inventory module.
 * Orchestrates transactions and interacts with the repository layer.
 * Does not access Express req/res directly.
 */
class InventoryService {
  _emptyInventoryPage(page, limit) {
    return {
      data: [],
      pagination: {
        total: 0,
        page: Number(page),
        limit: Number(limit),
        total_pages: 0
      }
    };
  }

  /**
   * Fetch inventory for a specific user.
   * Seller: owner_id = seller. Employee: current_location_id = employee.location_id.
   */
  async getInventory(userId, role, { search, page = 1, limit = 10, includeOutOfStock = false, locationId } = {}) {
    const skip = (page - 1) * limit;
    const includeOOS = String(includeOutOfStock) === 'true';

    const unitScope = await resolveUnitScope(userId, role, locationId);
    if (!unitScope) {
      return this._emptyInventoryPage(page, limit);
    }

    let products, total;
    [products, total] = await Promise.all([
      inventoryRepository.findInventory(unitScope, { search, skip, take: limit, includeOutOfStock: includeOOS }),
      inventoryRepository.countInventory(unitScope, { search, includeOutOfStock: includeOOS })
    ]);

    return {
      data: products.map(p => ({
        product_id: Number(p.id),
        product_name_id: Number(p.productNameId),
        product_model_id: Number(p.productModelId),
        brand: p.productName?.name || '',
        model: p.productModel?.name || '',
        quantity: p._count.units,
        min_price: Number(p.minPrice),
        offer_price: p.offerPrice ? Number(p.offerPrice) : null,
        min_unit_count_seller: Number(p.minUnitCountSeller),
        min_unit_count_admin: Number(p.minUnitCountAdmin),
        on_sale: p.onSale,
        is_low_stock: isAdminLikeRole(role)
          ? p._count.units <= Number(p.minUnitCountAdmin)
          : p._count.units <= Number(p.minUnitCountSeller)
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
  async getInventoryItem(userId, role, productId, locationId) {
    const unitScope = await resolveUnitScope(userId, role, locationId);
    if (!unitScope) {
      throw httpError(404, 'Inventory item not found');
    }

    const product = await inventoryRepository.findInventoryByProduct(unitScope, productId);
    
    if (!product) {
      throw httpError(404, 'Inventory item not found');
    }

    return {
      product_id: Number(product.id),
      product_name_id: Number(product.productNameId),
      product_model_id: Number(product.productModelId),
      brand: product.productName?.name || '',
      model: product.productModel?.name || '',
      quantity: product._count.units,
      min_price: Number(product.minPrice),
      offer_price: product.offerPrice ? Number(product.offerPrice) : null,
      min_unit_count_seller: Number(product.minUnitCountSeller),
      min_unit_count_admin: Number(product.minUnitCountAdmin),
      on_sale: product.onSale,
      is_low_stock: isAdminLikeRole(role)
        ? product._count.units <= Number(product.minUnitCountAdmin)
        : product._count.units <= Number(product.minUnitCountSeller),
      serial_numbers: product.units?.map(u => u.serialNumber) || []
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

    // Hard cap — prevents accidental / abusive million-unit inserts
    if (Math.abs(Number(adjustment_quantity)) > 500) {
      throw httpError(400, 'Adjustment quantity cannot exceed 500 units per request');
    }

    const productIdBig = BigInt(product_id);
    const userIdBig = BigInt(user_id);

    // Never assign inventory ownership to EMPLOYEE / unknown roles
    const owner = await prisma.user.findUnique({
      where: { id: userIdBig },
      select: { id: true, role: true },
    });
    if (
      !owner ||
      (owner.role !== 'ADMIN' &&
        owner.role !== 'SUPER_ADMIN' &&
        owner.role !== 'SELLER')
    ) {
      throw httpError(400, 'Adjustment target must be an ADMIN, SUPER_ADMIN, or SELLER user');
    }

    // Wrap in a transaction to ensure atomicity
    return prisma.$transaction(async (tx) => {
      if (adjustment_quantity > 0) {
        const locationId =
          (await getUserLocationId(userIdBig, tx)) || (await getDefaultWarehouseId(tx));
        // Positive adjustment: increase stock by creating new product units
        const unitsData = Array.from({ length: adjustment_quantity }).map(() => ({
          productId: productIdBig,
          ownerId: userIdBig,
          serialNumber: `ADJ-${Date.now()}-${crypto.randomUUID()}`,
          status: 'AVAILABLE',
          ...(locationId ? { currentLocationId: locationId } : {}),
        }));

        const createdUnits = await inventoryRepository.createInventory(unitsData, tx);
        const auditLogs = createdUnits.map(unit => ({
          productUnitId: unit.id,
          toUserId: userIdBig,
          action: 'RECEIVED', // Using RECEIVED as fallback for ADJUSTED_IN
          ...(locationId ? { toLocationId: locationId } : {}),
        }));
        await inventoryRepository.createInventoryTransaction(auditLogs, tx);
      } else {
        // Negative adjustment: decrease stock
        const decreaseAmount = Math.abs(adjustment_quantity);
        const availableUnits = await inventoryRepository.findAvailableUnits(userIdBig, productIdBig, decreaseAmount, tx);

        if (availableUnits.length < decreaseAmount) {
          throw httpError(400, 'Not enough stock to decrease');
        }

        const unitIds = availableUnits.map(u => u.id);

        // Mark units as DEFECTIVE to simulate decrease (since ADJUSTED_OUT is not in schema)
        await inventoryRepository.updateInventory(unitIds, { status: 'DEFECTIVE' }, tx);

        // Create audit logs
        const auditLogs = unitIds.map(unitId => ({
          productUnitId: unitId,
          toUserId: userIdBig,
          action: 'RETURNED' // Using RETURNED as fallback
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
      throw httpError(400, 'Invalid seller');
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
          throw httpError(400, `Not enough stock for product ID: ${item.product_id}`);
        }

        const ids = availableUnits.map(u => u.id);
        unitIdsToTransfer.push(...ids);

        shipmentItemsData.push({
          productId: item.product_id,
          quantity: item.quantity
        });

        totalProductsShipped += item.quantity;
      }

      const fromLoc = await getDefaultWarehouseId(tx);
      const toLoc = (await getUserLocationId(sellerId, tx)) || null;

      // Ownership + location (seller location if set)
      await inventoryRepository.updateInventory(
        unitIdsToTransfer,
        {
          ownerId: sellerId,
          ownerType: 'SELLER',
          ...(toLoc ? { currentLocationId: toLoc } : {}),
        },
        tx
      );

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
        action: 'TRANSFERRED',
        ...(fromLoc ? { fromLocationId: fromLoc } : {}),
        ...(toLoc ? { toLocationId: toLoc } : {}),
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

    // Apply role-based filtering (EMPLOYEE / unknown → no full-ledger dump)
    if (role === 'SELLER') {
      filters.OR = [
        { fromUserId: userId },
        { toUserId: userId }
      ];
    } else if (isAdminLikeRole(role)) {
      if (seller_id) {
        filters.OR = [
          { fromUserId: seller_id },
          { toUserId: seller_id }
        ];
      }
    } else {
      // EMPLOYEE must not see admin/seller ledger via this endpoint
      return [];
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
   * Update stock (Admin / Super Admin).
   * SA: optional location_id (any active location / warehouse).
   * Shop Admin: always own users.location_id (client location_id ignored).
   *
   * @param {number} adminId
   * @param {object} payload
   * @param {{ role?: string, locationId?: number|null }} [actor]
   */
  async updateStock(adminId, { productNameId, productModelId, quantity, minSellPrice, minUnitCountAdmin, minUnitCountSeller, onSale, location_id }, actor = {}) {
    const role = actor.role;
    const actorLocationId = actor.locationId != null ? Number(actor.locationId) : null;

    // 1. Validate product name existence
    const productName = await prisma.productName.findUnique({
      where: { id: BigInt(productNameId) }
    });
    if (!productName) {
      throw httpError(404, 'Product name not found');
    }

    // 2. Validate product model existence and that it belongs to the product name
    const productModel = await prisma.productModel.findUnique({
      where: { id: BigInt(productModelId) }
    });
    if (!productModel || Number(productModel.productNameId) !== productNameId) {
      throw httpError(404, 'Product model not found or does not belong to the selected product name');
    }

    // Resolve target location (req.user.locationId is DB-fresh each request)
    let resolvedLocationId = null;
    if (role === 'ADMIN') {
      if (actorLocationId == null) {
        throw httpError(400, 'Your account has no shop location. Contact Super Admin before adding stock.');
      }
      const loc = await prisma.location.findFirst({
        where: { id: BigInt(actorLocationId), isActive: true },
        select: { id: true },
      });
      if (!loc) {
        throw httpError(400, 'Shop location not found or inactive');
      }
      resolvedLocationId = loc.id;
    } else if (location_id != null) {
      const loc = await prisma.location.findFirst({
        where: { id: BigInt(location_id), isActive: true },
        select: { id: true },
      });
      if (!loc) {
        throw httpError(400, 'Location not found or inactive');
      }
      resolvedLocationId = loc.id;
    }

    return prisma.$transaction(async (tx) => {
      // Find or create product
      let product = await tx.product.findFirst({
        where: {
          productNameId: BigInt(productNameId),
          productModelId: BigInt(productModelId)
        }
      });

      if (!product) {
        // Create new product with stockQuantity
        product = await tx.product.create({
          data: {
            productNameId: BigInt(productNameId),
            productModelId: BigInt(productModelId),
            minPrice: minSellPrice !== undefined ? minSellPrice : 0,
            onSale: onSale !== undefined ? onSale : false,
            stockQuantity: quantity ?? 0,
            minUnitCountAdmin: minUnitCountAdmin !== undefined ? minUnitCountAdmin : 0,
            minUnitCountSeller: minUnitCountSeller !== undefined ? minUnitCountSeller : 0
          }
        });
      } else {
        // Update existing product - increment stockQuantity
        product = await tx.product.update({
          where: { id: product.id },
          data: {
            ...(quantity ? { stockQuantity: { increment: quantity } } : {}),
            ...(minSellPrice !== undefined ? { minPrice: minSellPrice } : {}),
            ...(onSale !== undefined ? { onSale } : {}),
            ...(minUnitCountAdmin !== undefined ? { minUnitCountAdmin } : {}),
            ...(minUnitCountSeller !== undefined ? { minUnitCountSeller } : {})
          }
        });
      }

      let placedLocationId = resolvedLocationId;
      if (quantity && quantity > 0) {
        if (!placedLocationId) {
          placedLocationId =
            (await getUserLocationId(adminId, tx)) || (await getDefaultWarehouseId(tx));
        }
        const unitsData = Array.from({ length: quantity }).map(() => ({
          productId: product.id,
          ownerId: adminId,
          serialNumber: `STK-${Date.now()}-${crypto.randomUUID()}`,
          status: 'AVAILABLE',
          ...(placedLocationId ? { currentLocationId: placedLocationId } : {}),
        }));
        await inventoryRepository.createInventory(unitsData, tx);
      }

      return {
        productNameId,
        productModelId,
        quantity: Number(product.stockQuantity),
        minSellPrice: Number(product.minPrice),
        minUnitCountAdmin: Number(product.minUnitCountAdmin),
        minUnitCountSeller: Number(product.minUnitCountSeller),
        onSale: product.onSale,
        location_id: placedLocationId != null ? Number(placedLocationId) : null,
      };
    });
  }

  /**
   * Fetch details of a product (stock count & min sell price) by product name and model IDs
   */
  async getProductDetails(userId, role, { productNameId, productModelId, locationId }) {
    // 1. Find product
    const product = await prisma.product.findFirst({
      where: {
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

    const unitScope = await resolveUnitScope(userId, role, locationId);
    const stockCount = unitScope
      ? await prisma.productUnit.count({
          where: {
            productId: product.id,
            ...unitScope,
            status: 'AVAILABLE'
          }
        })
      : 0;

    return {
      productId: Number(product.id),
      currentStock: stockCount,
      minSellPrice: Number(product.minPrice)
    };
  }

  /**
   * Fetch available serial numbers for a product in the user's inventory scope.
   */
  async getAvailableSerials(userId, role, { productNameId, productModelId, locationId }) {
    const unitScope = await resolveUnitScope(userId, role, locationId);
    if (!unitScope) {
      return [];
    }
    return inventoryRepository.findAvailableSerials(unitScope, { productNameId, productModelId });
  }

  /**
   * Fetch inventory details grouped by ProductName -> Product.
   * Seller: by owner. Employee: by current_location_id.
   */
  async getInventoryDetails(userId, role, { product_name_id, search, page = 1, limit = 10, locationId } = {}) {
    const pageNum = Number(page);
    const limitNum = Number(limit);
    const skip = (pageNum - 1) * limitNum;

    const unitScope = await resolveUnitScope(userId, role, locationId);
    if (!unitScope) {
      return {
        productNames: [],
        pagination: {
          total: 0,
          page: Number(page),
          limit: Number(limit),
          total_pages: 0
        }
      };
    }

    const filters = {
      productNameId: product_name_id,
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
        productNames: [],
        pagination: {
          total,
          page: Number(page),
          limit: Number(limit),
          total_pages: Math.ceil(total / limit)
        }
      };
    }

    // 2. Extract unique product and product name IDs in the current page
    const productIds = products.map(p => p.id);
    const productNameIds = [...new Set(products.map(p => p.productNameId))];

    // 3. Fetch product unit aggregates (total, sold, remaining)
    const unitGroups = await inventoryRepository.aggregateUnitCounts(productIds, unitScope);
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
      } else if (status === 'AVAILABLE') {
        countMap[pid].remaining += count;
      }
    }

    // 4. Fetch ProductName Stats (Total products and total available inventory)
    const productNameStats = await Promise.all(
      productNameIds.map(async (nameId) => {
        const stats = await inventoryRepository.getProductNameStats(nameId, unitScope);
        return { productNameId: nameId, ...stats };
      })
    );

    const productNameMap = new Map(productNameStats.map(s => [s.productNameId, s]));

    // 5. Build hierarchy: ProductName -> Product
    const productNames = [];
    for (const product of products) {
      const nameId = product.productNameId;
      const prodId = product.id;

      // Find or create ProductName node
      let nameNode = productNames.find(n => n.productNameId === Number(nameId));
      if (!nameNode) {
        const nameStats = productNameMap.get(nameId) || { totalProducts: 0, totalInventory: 0 };
        nameNode = {
          productNameId: Number(nameId),
          productNameLabel: product.productName.name,
          totalProducts: nameStats.totalProducts,
          totalInventory: nameStats.totalInventory,
          products: []
        };
        productNames.push(nameNode);
      }

      // Add Product node
      const counts = countMap[Number(prodId)] || { total: 0, sold: 0, remaining: 0 };
      nameNode.products.push({
        productId: Number(prodId),
        productModel: product.productModel.name,
        totalQuantity: counts.total,
        soldQuantity: counts.sold,
        remainingQuantity: counts.remaining
      });
    }

    return {
      productNames,
      pagination: {
        total,
        page: Number(page),
        limit: Number(limit),
        total_pages: Math.ceil(total / limit)
      }
    };
  }

  /**
   * Scan a serial number to fetch product details for a sale
   * @param {string} serialNumber
   * @param {number|string|bigint} sellerId
   * @returns {Promise<Object>}
   */
  async scanForSale(serialNumber, sellerId) {
    const cleanSerial = serialNumber ? serialNumber.trim() : '';
    const unit = await prisma.productUnit.findFirst({
      where: {
        serialNumber: { equals: cleanSerial, mode: 'insensitive' },
        ownerId: BigInt(sellerId),
        status: 'AVAILABLE'
      },
      include: {
        product: {
          include: {
            productName: true,
            productModel: true
          }
        }
      }
    });

    if (!unit) {
      throw httpError(404, 'Product not found in your available inventory');
    }

    return {
      productId: Number(unit.productId),
      productNameId: Number(unit.product.productNameId),
      productModelId: Number(unit.product.productModelId),
      productName: unit.product.productName.name,
      productModel: unit.product.productModel.name,
      minSellPrice: Number(unit.product.minPrice)
    };
  }
}

module.exports = new InventoryService();
