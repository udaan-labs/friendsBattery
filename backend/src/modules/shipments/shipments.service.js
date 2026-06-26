const shipmentsRepository = require('./shipments.repository');
const { prisma } = require('../../config/db');

class ShipmentsService {
  async createShipment(data, adminId) {
    // 1. Validate Seller exists
    const seller = await shipmentsRepository.findSellerById(data.sellerId);
    if (!seller) {
      const error = new Error('Seller not found');
      error.statusCode = 404;
      throw error;
    }

    // 2. Fetch available units and map to shipment items
    const shipmentItems = [];
    
    for (const item of data.items) {
      // Find product to get its relations
      const product = await shipmentsRepository.findProductById(item.product_id);
      if (!product) {
        const error = new Error(`Product ID ${item.product_id} not found`);
        error.statusCode = 400;
        throw error;
      }

      // Find available units for this admin
      const availableUnits = await shipmentsRepository.getAvailableUnits(item.product_id, adminId, item.quantity);
      if (availableUnits.length < item.quantity) {
        const error = new Error(`Insufficient stock for Product ID ${item.product_id}. Requested: ${item.quantity}, Available: ${availableUnits.length}`);
        error.statusCode = 400;
        throw error;
      }

      // Create one shipment item per unit
      for (const unit of availableUnits) {
        shipmentItems.push({
          productCategoryId: product.categoryId,
          productNameId: product.productNameId,
          productModelId: product.productModelId,
          productId: product.id,
          productItemId: unit.id,
          quantity: 1
        });
      }
    }

    // 3. Generate unique shipment number
    const count = await prisma.newShipment.count();
    const shipmentNumber = `SHP-${100 + count + 1}`;

    // 4. Create shipment record
    await shipmentsRepository.createShipment({
      shipmentNumber,
      sellerId: data.sellerId,
      createdByAdminId: adminId,
      items: shipmentItems
    });

    return {
      success: true,
      message: 'Shipment created successfully'
    };
  }

  async getPendingShipmentsCount(sellerId) {
    const count = await shipmentsRepository.getPendingShipmentsCount(sellerId);
    return {
      pendingShipments: count
    };
  }

  async getShipments(sellerId) {
    const shipments = await shipmentsRepository.getShipmentsBySeller(sellerId);
    return shipments.map(s => ({
      shipmentId: Number(s.id),
      shipmentNumber: s.shipmentNumber,
      status: s.status,
      createdAt: s.createdAt.toISOString().split('T')[0],
      acceptedAt: s.acceptedAt ? s.acceptedAt.toISOString() : null,
      items: s.items.map(item => ({
        productName: item.product?.productName?.name || '',
        productModel: item.product?.productModel?.name || '',
        quantity: item.quantity
      }))
    }));
  }

  /**
   * Get all shipments (Admin view).
   */
  async getAllShipments() {
    const shipments = await shipmentsRepository.getAllShipments();
    return shipments.map(s => ({
      shipmentId: Number(s.id),
      shipmentNumber: s.shipmentNumber,
      status: s.status,
      createdAt: s.createdAt.toISOString(),
      acceptedAt: s.acceptedAt ? s.acceptedAt.toISOString() : null,
      seller: {
        id: Number(s.seller.id),
        userName: s.seller.userName,
        shopName: s.seller.shopName || '',
      },
      totalProducts: s.items.length,
      totalQuantity: s.items.reduce((sum, item) => sum + item.quantity, 0),
      items: s.items.map(item => ({
        productName: item.product?.productName?.name || '',
        productModel: item.product?.productModel?.name || '',
        quantity: item.quantity
      }))
    }));
  }

  /**
   * Get a single shipment by ID with role-based access.
   * Admin can view any shipment; Seller can only view their own.
   */
  async getShipmentById(shipmentId, userId, userRole) {
    const shipment = await shipmentsRepository.getShipmentById(shipmentId);

    if (!shipment) {
      const error = new Error('Shipment not found');
      error.statusCode = 404;
      throw error;
    }

    // Sellers can only access their own shipments
    if (userRole === 'SELLER' && Number(shipment.sellerId) !== Number(userId)) {
      const error = new Error('Forbidden: You can only view your own shipments');
      error.statusCode = 403;
      throw error;
    }

    const totalQuantity = shipment.items.reduce((sum, item) => sum + item.quantity, 0);

    return {
      shipmentId: Number(shipment.id),
      shipmentNumber: shipment.shipmentNumber,
      status: shipment.status,
      createdAt: shipment.createdAt.toISOString(),
      acceptedAt: shipment.acceptedAt ? shipment.acceptedAt.toISOString() : null,
      seller: {
        id: Number(shipment.seller.id),
        userName: shipment.seller.userName,
        shopName: shipment.seller.shopName || '',
        userNumber: shipment.seller.userNumber || null,
      },
      createdByAdmin: {
        id: Number(shipment.admin.id),
        userName: shipment.admin.userName,
      },
      totalProducts: shipment.items.length,
      totalQuantity,
      items: shipment.items.map(item => ({
        id: Number(item.id),
        category: item.category?.name || '',
        productGroup: item.product?.group?.name || '',
        productName: item.name?.name || '',
        productModel: item.model?.name || '',
        quantity: item.quantity,
        serialNumber: item.productUnit?.serialNumber || null,
      }))
    };
  }

  async acceptShipment(shipmentId, sellerId) {
    // 1. Fetch shipment
    const shipment = await shipmentsRepository.findShipmentById(shipmentId);
    if (!shipment) {
      const error = new Error('Shipment not found');
      error.statusCode = 404;
      throw error;
    }

    // 2. Verify shipment belongs to logged-in Seller
    if (Number(shipment.sellerId) !== Number(sellerId)) {
      const error = new Error('Forbidden: You can only accept your own shipments');
      error.statusCode = 403;
      throw error;
    }

    // 3. Verify status = PENDING
    if (shipment.status !== 'PENDING') {
      const error = new Error(`Shipment cannot be accepted. Current status: ${shipment.status}`);
      error.statusCode = 400;
      throw error;
    }

    // 4. Accept shipment and update inventory
    await shipmentsRepository.acceptShipment(shipmentId, shipment.items, sellerId);

    return {
      success: true,
      message: 'Shipment accepted successfully'
    };
  }
}

module.exports = new ShipmentsService();
