const shipmentsRepository = require('./shipments.repository');
const { prisma } = require('../../config/db');
const { httpError } = require('../../shared/utils/http-error');
const ROLES = require('../../shared/constants/roles');
const {
  resolveAdminShopScope,
  resolveShopSellerIds,
  isUserInShopScope,
} = require('../../shared/utils/shop-scope.util');

/**
 * Admin → Seller stock transfer (serial-based).
 * Uses existing product_units only — does not invent units.
 */
class ShipmentsService {
  /**
   * Transfer serials owned by adminId → seller. SA: any seller; shop Admin: own sellers only.
   */
  async createShipment(data, adminId, actor = null) {
    const seller = await shipmentsRepository.findSellerById(data.sellerId);
    if (!seller) {
      throw httpError(404, 'Seller not found');
    }

    if (actor?.role === ROLES.ADMIN) {
      const scope = resolveAdminShopScope(actor);
      if (!isUserInShopScope(seller, scope)) {
        throw httpError(403, 'Forbidden: seller is not under your shop');
      }
    }

    const serials = (data.serial_numbers || []).map((raw) => String(raw).trim());

    return shipmentsRepository.transferUnitsToSeller({
      sellerId: data.sellerId,
      adminId,
      serials,
    });
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

  /**
   * @param {{ id: number, role: string, locationId?: number|null }} [user]
   */
  async getAllShipments(user) {
    const scope = resolveAdminShopScope(user || {});
    let shipments;
    if (scope?.kind === 'shop') {
      const sellerIds = await resolveShopSellerIds(prisma, scope);
      const pureSellers = (sellerIds || []).filter(
        (id) => Number(id) !== Number(scope.adminId)
      );
      shipments = await shipmentsRepository.getShipmentsForShopAdmin(
        scope.adminId,
        pureSellers
      );
    } else {
      shipments = await shipmentsRepository.getAllShipments();
    }
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
    if (userRole === ROLES.SUPER_ADMIN) {
      // ok
    } else if (userRole === ROLES.ADMIN) {
      if (Number(shipment.createdByAdminId) === Number(userId)) {
        // ok — this admin sent it
      } else {
        const seller = await prisma.user.findUnique({
          where: { id: BigInt(shipment.sellerId) },
          select: { id: true, parentId: true, locationId: true },
        });
        const scope = resolveAdminShopScope({
          id: userId,
          role: userRole,
          locationId,
        });
        if (!seller || !isUserInShopScope(seller, scope)) {
          throw httpError(403, 'Forbidden: You do not have access to this shipment');
        }
      }
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
