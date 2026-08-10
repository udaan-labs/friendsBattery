const salesRepository = require('./sales.repository');
const { httpError } = require('../../shared/utils/http-error');
const { parsePagination } = require('../../shared/utils/pagination');
const ROLES = require('../../shared/constants/roles');
const {
  resolveAdminShopScope,
  resolveShopSellerIds,
} = require('../../shared/utils/shop-scope.util');
const { prisma } = require('../../config/db');

/**
 * Sales Service
 *
 * Contains all business logic for the sales module.
 */
class SalesService {
  /**
   * Format sale object for consistent API response
   */
  _formatSale(sale) {
    return {
      id: Number(sale.id),
      product_id: Number(sale.productId),
      product_unit_id: Number(sale.productUnitId),
      sell_price: sale.sellPrice,
      serial_number: sale.serialNumber,
      vehicle_number: sale.vehicleNumber,
      sale_type: sale.saleType || 'NORMAL',
      scrap_serial: sale.scrapSerial || null,
      sold_at: sale.soldAt,
      quantity: 1,
      customer: sale.customer ? {
        id: Number(sale.customer.id),
        name: sale.customer.name,
        phone: sale.customer.phone
      } : null,
      seller: sale.seller ? {
        id: Number(sale.seller.id),
        user_name: sale.seller.userName,
        shop_name: sale.seller.shopName
      } : null,
      product: sale.product ? {
        id: Number(sale.product.id),
        product_name: sale.product.productName.name,
        product_model: sale.product.productModel.name
      } : null
    };
  }

  /**
   * Create a new sale transaction.
   * SA/Admin/Seller: claim unit by ownerId = actor.id.
   * EMPLOYEE: claim AVAILABLE unit at actor.locationId; sellerId on sale = employee.
   * @param {Object} data Request body
   * @param {{ id: number|bigint, role: string, locationId?: number|null }} actor
   */
  async createSale(data, actor) {
    const sellerId = actor.id;
    const isEmployee = actor.role === ROLES.EMPLOYEE;
    const sellPrice = Number(data.sell_price);

    let customer = await salesRepository.findCustomerByMobile(data.customer_number);
    if (!customer) {
      customer = await salesRepository.createCustomer({
        name: data.customer_name,
        phone: data.customer_number,
      });
    }

    if (isEmployee && actor.locationId == null) {
      throw httpError(400, 'Your account has no shop location. Contact admin.');
    }

    const productUnit = await salesRepository.findAvailableProductUnit(
      data.serial_number,
      isEmployee ? { locationId: actor.locationId } : { ownerId: sellerId }
    );
    if (!productUnit) {
      throw httpError(404, 'The scanned serial number is not available in your inventory.');
    }

    if (
      Number(productUnit.product.productNameId) !== Number(data.product_name_id) ||
      Number(productUnit.product.productModelId) !== Number(data.product_model_id)
    ) {
      throw httpError(400, 'The scanned serial number does not match the selected Product Name or Model.');
    }

    // NORMAL enforces min price; SCRAP/MECHANIC allow reduced (scrap_serial required in Zod)
    const saleType = data.sale_type || 'NORMAL';
    const minPrice = Number(productUnit.product?.minPrice);
    if (
      saleType === 'NORMAL' &&
      Number.isFinite(minPrice) &&
      sellPrice < minPrice
    ) {
      throw httpError(
        400,
        `Selling price (₹${sellPrice}) cannot be less than minimum allowed price (₹${minPrice}).`
      );
    }

    const sale = await salesRepository.createSaleTransaction({
      productUnitId: productUnit.id,
      productId: productUnit.productId,
      customerId: customer.id,
      sellerId,
      ownerId: productUnit.ownerId,
      sellPrice,
      serialNumber: productUnit.serialNumber,
      vehicleNumber: data.vehicle_number,
      saleType,
      scrapSerial: saleType === 'SCRAP' ? data.scrap_serial || null : null,
      claimByLocationId: isEmployee ? actor.locationId : null,
    });

    return { transaction_id: Number(sale.id) };
  }

  /**
   * Service bill (check / charge / jumpstart / inverter) — no inventory move.
   * @param {Object} data Request body
   * @param {{ id: number|bigint }} actor
   */
  async createServiceBill(data, actor) {
    let customer = await salesRepository.findCustomerByMobile(data.customer_number);
    if (!customer) {
      customer = await salesRepository.createCustomer({
        name: data.customer_name,
        phone: data.customer_number,
      });
    }

    const bill = await salesRepository.createServiceBill({
      sellerId: actor.id,
      customerId: customer.id,
      serviceType: data.service_type,
      amount: Number(data.amount),
      vehicleNumber: data.vehicle_number,
      place: data.place,
    });

    return { service_bill_id: Number(bill.id) };
  }

  /**
   * Get all sales based on user role
   * @param {Object} user Authenticated user
   */
  async getSales(user) {
    let sales;
    if (user.role === ROLES.SUPER_ADMIN) {
      sales = await salesRepository.getAllSales();
    } else if (user.role === ROLES.ADMIN) {
      const scope = resolveAdminShopScope(user);
      const sellerIds = await resolveShopSellerIds(prisma, scope);
      sales = await salesRepository.getSalesBySellerIds(sellerIds || []);
    } else {
      sales = await salesRepository.getSalesBySeller(user.id);
    }
    return sales.map(this._formatSale);
  }

  /**
   * Get sale details by transaction ID.
   * SA: any. Shop Admin: shop sellers + self. Seller: own only.
   */
  async getSaleById(transactionId, user) {
    const sale = await salesRepository.findSaleById(transactionId);
    if (!sale) {
      throw httpError(404, 'Transaction not found');
    }
    if (user?.role === ROLES.SUPER_ADMIN) {
      return this._formatSale(sale);
    }
    if (user?.role === ROLES.ADMIN) {
      const scope = resolveAdminShopScope(user);
      const sellerIds = await resolveShopSellerIds(prisma, scope);
      const allowed = new Set((sellerIds || []).map((id) => Number(id)));
      if (allowed.has(Number(sale.sellerId))) {
        return this._formatSale(sale);
      }
      throw httpError(403, 'Forbidden: You cannot view this sale');
    }
    if (user?.role === 'SELLER' && Number(sale.sellerId) === Number(user.id)) {
      return this._formatSale(sale);
    }
    throw httpError(403, 'Forbidden: You cannot view this sale');
  }

  /**
   * Get sales history for a specific customer mobile
   */

  async getSalesHistory(sellerId, query) {
    const { page, limit, skip, take } = parsePagination(query, { defaultLimit: 10 });
    let { searchCustomer, searchSerial, fromDate, toDate, filter, date } = query;

    if (filter === 'today') {
      const start = new Date();
      start.setHours(0, 0, 0, 0);
      const end = new Date();
      end.setHours(23, 59, 59, 999);
      fromDate = start.toISOString();
      toDate = end.toISOString();
    } else if (filter === 'date' && date) {
      const selectedDate = new Date(date);
      selectedDate.setHours(0, 0, 0, 0);
      const end = new Date(selectedDate);
      end.setHours(23, 59, 59, 999);
      fromDate = selectedDate.toISOString();
      toDate = end.toISOString();
    } else if (filter === 'all') {
      fromDate = undefined;
      toDate = undefined;
    }

    const filters = {
      searchCustomer,
      searchSerial,
      fromDate,
      toDate,
    };

    const pagination = { skip, take };

    const sales = await salesRepository.getSalesHistoryBySeller(
      sellerId,
      filters,
      pagination
    );
    const total = await salesRepository.countSalesHistoryBySeller(sellerId, filters);

    const totalPages = Math.ceil(total / limit);

    return {
      data: sales.map(this._formatSale),
      total: total,
      page: page,
      limit: limit,
      total_pages: totalPages,
    };
  }

  /**
   * Format a sale record for the Admin sales history response.
   * Extends _formatSale with shipment info traced via productUnit → NewShipmentItem → NewShipment.
   */
  _formatAdminSale(sale) {
    const base = {
      id: Number(sale.id),
      sold_at: sale.soldAt,
      quantity: 1,
      sell_price: sale.sellPrice,
      serial_number: sale.serialNumber,
      vehicle_number: sale.vehicleNumber,
      seller: sale.seller
        ? {
            id: Number(sale.seller.id),
            user_name: sale.seller.userName,
            shop_name: sale.seller.shopName,
          }
        : null,
      customer: sale.customer
        ? {
            name: sale.customer.name,
            phone: sale.customer.phone,
          }
        : null,
      product: sale.product
        ? {
            id: Number(sale.product.id),
            product_name: sale.product.productName.name,
            product_model: sale.product.productModel.name,
          }
        : null,
      shipment: null,
    };

    // Trace shipment via productUnit → NewShipmentItem → NewShipment
    const shipmentItem =
      sale.productUnit &&
      sale.productUnit.newShipmentItems &&
      sale.productUnit.newShipmentItems.length > 0
        ? sale.productUnit.newShipmentItems[0]
        : null;

    if (shipmentItem && shipmentItem.shipment) {
      const s = shipmentItem.shipment;
      base.shipment = {
        id: Number(s.id),
        shipment_number: s.shipmentNumber,
        shipment_date: s.createdAt,
        arrival_date: s.acceptedAt,
        status: s.status,
      };
    }

    return base;
  }

  /**
   * Get paginated sales history for Admin — SA all shops; shop Admin own shop.
   * @param {object} query
   * @param {{ id: number, role: string, locationId?: number|null }} [user]
   */
  async getAdminSalesHistory(query, user) {
    const { page, limit, skip, take } = parsePagination(query, { defaultLimit: 10 });
    const { search, sellerId, fromDate, toDate, shipmentStatus } = query;

    const filters = { search, sellerId, fromDate, toDate, shipmentStatus };

    const scope = resolveAdminShopScope(user || {});
    if (scope?.kind === 'shop') {
      const sellerIds = await resolveShopSellerIds(prisma, scope);
      filters.sellerIds = sellerIds || [];
    }

    const pagination = { skip, take };

    const [sales, total] = await Promise.all([
      salesRepository.getAdminSalesHistory(filters, pagination),
      salesRepository.countAdminSalesHistory(filters),
    ]);

    return {
      data: sales.map((s) => this._formatAdminSale(s)),
      total,
      page,
      limit,
      total_pages: Math.ceil(total / limit),
    };
  }
}

module.exports = new SalesService();
