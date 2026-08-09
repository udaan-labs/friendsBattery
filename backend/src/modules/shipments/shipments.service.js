const shipmentsRepository = require('./shipments.repository');
const { prisma } = require('../../config/db');
const { httpError } = require('../../shared/utils/http-error');

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
      throw httpError(404, 'Seller not found');
    }

    // Flatten + normalize serials; reject duplicates in the request itself
    const allSerials = [];
    for (const item of data.items) {
      for (const raw of item.serial_numbers) {
        const serial = String(raw).trim();
        if (!serial) {
          throw httpError(400, 'Serial number cannot be empty');
        }
        allSerials.push(serial);
      }
    }

    const uniqueSerials = new Set(allSerials);
    if (uniqueSerials.size !== allSerials.length) {
      throw httpError(400, 'Duplicate serial numbers in the transfer request');
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
        throw httpError(400, 
          `Product not found for Name ID ${item.product_name_id} and Model ID ${item.product_model_id}`
        );
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
        throw httpError(400, 
          missing.length
            ? `Serial number(s) unavailable or not in admin inventory: ${missing.join(', ')}`
            : 'One or more serial numbers are unavailable'
        );
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
    return shipments.map((s) => this._mapSellerShipmentListItem(s));
  }

  /**
   * Employee: list shipments for sellers at the same location_id.
   */
  async getShipmentsForEmployeeLocation(locationId) {
    if (locationId == null) return [];
    const shipments = await shipmentsRepository.getShipmentsBySellerLocationId(locationId);
    return shipments.map((s) => this._mapSellerShipmentListItem(s));
  }

  _mapSellerShipmentListItem(s) {
    return {
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
    };
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

  async getShipmentById(shipmentId, userId, userRole, locationId = null) {
    const shipment = await shipmentsRepository.getShipmentById(shipmentId);

    if (!shipment) {
      throw httpError(404, 'Shipment not found');
    }

    // Explicit allow-list (default deny) — no fall-through for unknown roles
    if (userRole === 'ADMIN') {
      // ok
    } else if (userRole === 'SELLER') {
      if (Number(shipment.sellerId) !== Number(userId)) {
        throw httpError(403, 'Forbidden: You can only view your own shipments');
      }
    } else if (userRole === 'EMPLOYEE') {
      const allowed = await shipmentsRepository.sellerSharesLocation(
        shipment.sellerId,
        locationId
      );
      if (!allowed) {
        throw httpError(403, 'Forbidden: Shipment is not for your shop location');
      }
    } else {
      throw httpError(403, 'Forbidden: You do not have access to this shipment');
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
      throw httpError(404, 'Shipment not found');
    }

    if (Number(shipment.sellerId) !== Number(sellerId)) {
      throw httpError(403, 'Forbidden: You can only accept your own shipments');
    }

    // Status claim + unit lock happen atomically in repository (race-safe)
    await shipmentsRepository.acceptPendingShipment(shipmentId, shipment.items, sellerId);

    return {
      success: true,
      message: 'Shipment accepted successfully',
    };
  }
}

module.exports = new ShipmentsService();
