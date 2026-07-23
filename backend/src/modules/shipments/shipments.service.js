const shipmentsRepository = require('./shipments.repository');
const { prisma } = require('../../config/db');

/**
 * Admin → Seller stock transfer (serial-based).
 * Uses existing product_units only — does not invent serials.
 */
class ShipmentsService {
  /**
   * Admin confirms transfer:
   * - Validates seller + each serial (exists, AVAILABLE, admin-owned, matches product)
   * - Atomically moves ownership to seller, writes inventory_transactions, shipment record
   * - Returns transferred count + remaining admin / seller inventory counts per product
   */
  async createShipment(data, adminId) {
    const seller = await shipmentsRepository.findSellerById(data.sellerId);
    if (!seller) {
      const error = new Error('Seller not found');
      error.statusCode = 404;
      throw error;
    }

    // Flatten + normalize serials; reject duplicates in the request itself
    const allSerials = [];
    for (const item of data.items) {
      for (const raw of item.serial_numbers) {
        const serial = String(raw).trim();
        if (!serial) {
          const error = new Error('Serial number cannot be empty');
          error.statusCode = 400;
          throw error;
        }
        allSerials.push(serial);
      }
    }

    const uniqueSerials = new Set(allSerials);
    if (uniqueSerials.size !== allSerials.length) {
      const error = new Error('Duplicate serial numbers in the transfer request');
      error.statusCode = 400;
      throw error;
    }

    // Resolve products and units for every line item
    const resolvedItems = []; // { product, units: ProductUnit[] }

    for (const item of data.items) {
      const product = await prisma.product.findFirst({
        where: {
          productNameId: BigInt(item.product_name_id),
          productModelId: BigInt(item.product_model_id),
        },
        include: {
          productName: { select: { name: true } },
          productModel: { select: { name: true } },
        },
      });

      if (!product) {
        const error = new Error(
          `Product not found for Name ID ${item.product_name_id} and Model ID ${item.product_model_id}`
        );
        error.statusCode = 400;
        throw error;
      }

      const serials = item.serial_numbers.map((s) => String(s).trim());

      const units = await prisma.productUnit.findMany({
        where: {
          serialNumber: { in: serials },
          productId: product.id,
          status: 'AVAILABLE',
          owner: { role: 'ADMIN' },
        },
      });

      if (units.length !== serials.length) {
        const found = new Set(units.map((u) => u.serialNumber));
        const missing = serials.filter((s) => !found.has(s));
        const error = new Error(
          missing.length
            ? `Serial number(s) unavailable or not in admin inventory: ${missing.join(', ')}`
            : 'One or more serial numbers are unavailable'
        );
        error.statusCode = 400;
        throw error;
      }

      resolvedItems.push({
        product,
        units,
        pricePerPiece: item.price_per_piece,
      });
    }

    const result = await shipmentsRepository.transferUnitsToSeller({
      sellerId: data.sellerId,
      adminId,
      resolvedItems,
    });

    return result;
  }

  async getPendingShipmentsCount(sellerId) {
    const count = await shipmentsRepository.getPendingShipmentsCount(sellerId);
    return {
      pendingShipments: count,
    };
  }

  async getShipments(sellerId) {
    const shipments = await shipmentsRepository.getShipmentsBySeller(sellerId);
    return shipments.map((s) => ({
      shipmentId: Number(s.id),
      shipmentNumber: s.shipmentNumber,
      status: s.status,
      createdAt: s.createdAt.toISOString().split('T')[0],
      acceptedAt: s.acceptedAt ? s.acceptedAt.toISOString() : null,
      items: s.items.map((item) => ({
        productName: item.product?.productName?.name || '',
        productModel: item.product?.productModel?.name || '',
        quantity: item.quantity,
      })),
    }));
  }

  async getAllShipments() {
    const shipments = await shipmentsRepository.getAllShipments();
    return shipments.map((s) => ({
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
      items: s.items.map((item) => ({
        productName: item.product?.productName?.name || '',
        productModel: item.product?.productModel?.name || '',
        quantity: item.quantity,
      })),
    }));
  }

  async getShipmentById(shipmentId, userId, userRole) {
    const shipment = await shipmentsRepository.getShipmentById(shipmentId);

    if (!shipment) {
      const error = new Error('Shipment not found');
      error.statusCode = 404;
      throw error;
    }

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
      items: shipment.items.map((item) => ({
        id: Number(item.id),
        productName: item.name?.name || '',
        productModel: item.model?.name || '',
        quantity: item.quantity,
        serialNumber: item.productUnit?.serialNumber || null,
      })),
    };
  }

  /**
   * Seller accept kept for any legacy PENDING shipments.
   * New transfers complete ownership on admin create (see createShipment).
   */
  async acceptShipment(shipmentId, sellerId) {
    const shipment = await shipmentsRepository.findShipmentById(shipmentId);
    if (!shipment) {
      const error = new Error('Shipment not found');
      error.statusCode = 404;
      throw error;
    }

    if (Number(shipment.sellerId) !== Number(sellerId)) {
      const error = new Error('Forbidden: You can only accept your own shipments');
      error.statusCode = 403;
      throw error;
    }

    if (shipment.status !== 'PENDING') {
      const error = new Error(`Shipment cannot be accepted. Current status: ${shipment.status}`);
      error.statusCode = 400;
      throw error;
    }

    await shipmentsRepository.acceptPendingShipment(shipmentId, shipment.items, sellerId);

    return {
      success: true,
      message: 'Shipment accepted successfully',
    };
  }
}

module.exports = new ShipmentsService();
