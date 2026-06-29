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

    // 2. Validate each item and prepare batch data
    const shipmentItemsData = [];
    const productUnitsToCreate = [];
    const productStockUpdates = [];

    for (const item of data.items) {
      // Find product to validate and get its ID
      const product = await prisma.product.findFirst({
        where: {
          productNameId: BigInt(item.product_name_id),
          productModelId: BigInt(item.product_model_id)
        }
      });
      if (!product) {
        const error = new Error(`Product not found for Name ID ${item.product_name_id} and Model ID ${item.product_model_id}`);
        error.statusCode = 400;
        throw error;
      }

      // Check if any of these serials already exist in the system
      const existingUnits = await prisma.productUnit.findMany({
        where: {
          serialNumber: { in: item.serial_numbers }
        }
      });
      if (existingUnits.length > 0) {
        const dupes = existingUnits.map(u => u.serialNumber).join(', ');
        const error = new Error(`The following serial numbers already exist in the system: ${dupes}`);
        error.statusCode = 400;
        throw error;
      }

      // Check sufficient stock
      if (Number(product.stockQuantity) < item.serial_numbers.length) {
        const error = new Error(`Insufficient stock for Product Name ID ${item.product_name_id} and Model ID ${item.product_model_id}. Required: ${item.serial_numbers.length}, Available: ${product.stockQuantity}`);
        error.statusCode = 400;
        throw error;
      }

      // Prepare ProductUnit records for batch creation
      const unitEntries = item.serial_numbers.map(serial => ({
        productId: product.id,
        ownerId: BigInt(adminId),
        ownerType: 'ADMIN',
        serialNumber: serial,
        status: 'IN_SHIPMENT'
      }));

      // Prepare shipment item entries (will link productUnit IDs after creation)
      const itemEntries = item.serial_numbers.map(() => ({
        productNameId: product.productNameId,
        productModelId: product.productModelId,
        productId: product.id,
        quantity: 1
      }));

      productUnitsToCreate.push(...unitEntries);
      shipmentItemsData.push(...itemEntries);

      // Track stock decrement per product
      productStockUpdates.push({
        productId: product.id,
        decrementBy: item.serial_numbers.length
      });
    }

    // 3. Generate unique shipment number
    const count = await prisma.newShipment.count();
    const shipmentNumber = `SHP-${100 + count + 1}`;

    // 4. Create shipment, product units, and update stock in a single transaction
    await shipmentsRepository.createShipment({
      shipmentNumber,
      sellerId: data.sellerId,
      createdByAdminId: adminId,
      items: shipmentItemsData,
      units: productUnitsToCreate,
      stockUpdates: productStockUpdates
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
