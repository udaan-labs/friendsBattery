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

    // 2. Validate products exist
    for (const item of data.items) {
      const product = await shipmentsRepository.findProduct(
        item.productCategoryId,
        item.productNameId,
        item.productModelId
      );
      if (!product) {
        const error = new Error(`Product combo not found: Category ${item.productCategoryId}, Name ${item.productNameId}, Model ${item.productModelId}`);
        error.statusCode = 400;
        throw error;
      }
    }

    // 3. Generate unique shipment number (e.g. SHP-101)
    const count = await prisma.newShipment.count();
    const shipmentNumber = `SHP-${100 + count + 1}`;

    // 4. Create shipment record
    await shipmentsRepository.createShipment({
      shipmentNumber,
      sellerId: data.sellerId,
      createdByAdminId: adminId,
      items: data.items
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
      items: s.items.map(item => ({
        productModel: item.model?.name || '',
        quantity: item.quantity
      }))
    }));
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
