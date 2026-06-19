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
}

module.exports = new InventoryService();
