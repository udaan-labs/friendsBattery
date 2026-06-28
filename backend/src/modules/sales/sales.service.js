const salesRepository = require('./sales.repository');

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
      sold_at: sale.soldAt,
      quantity: 1, // As confirmed, each transaction represents a quantity of 1
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
   * Create a new sale transaction
   * @param {Object} data Request body
   * @param {Number|BigInt} sellerId Authenticated user ID
   */
  async createSale(data, sellerId) {
    // 1. Find or create customer
    let customer = await salesRepository.findCustomerByMobile(data.customer_number);
    if (!customer) {
      customer = await salesRepository.createCustomer({
        name: data.customer_name,
        phone: data.customer_number
      });
    }

    // 2. Check if the provided real serial number is already in use
    const existingUnit = await salesRepository.checkSerialNumberExists(data.serial_number);
    if (existingUnit) {
      const error = new Error('This serial number is already registered in the system.');
      error.statusCode = 400;
      throw error;
    }

    // 3. Find an available product unit for the requested product
    const productUnit = await salesRepository.findAvailableProductUnitByProductId(data.product_id, sellerId);
    
    if (!productUnit) {
      const error = new Error('No available stock for this product in your inventory.');
      error.statusCode = 404;
      throw error;
    }

    // 4. Create sale transaction & update inventory (Atomically handled in repository)
    const sale = await salesRepository.createSaleTransaction({
      productUnitId: productUnit.id,
      productId: productUnit.productId,
      customerId: customer.id,
      sellerId: sellerId,
      sellPrice: data.sell_price,
      serialNumber: data.serial_number,
      vehicleNumber: data.vehicle_number
    });

    // 5. Return transaction ID
    return { transaction_id: Number(sale.id) };
  }

  /**
   * Get all sales based on user role
   * @param {Object} user Authenticated user
   */
  async getSales(user) {
    let sales;
    if (user.role === 'ADMIN') {
      sales = await salesRepository.getAllSales();
    } else {
      sales = await salesRepository.getSalesBySeller(user.id);
    }
    return sales.map(this._formatSale);
  }

  /**
   * Get sale details by transaction ID
   */
  async getSaleById(transactionId) {
    const sale = await salesRepository.findSaleById(transactionId);
    if (!sale) {
      const error = new Error('Transaction not found');
      error.statusCode = 404;
      throw error;
    }
    return this._formatSale(sale);
  }

  /**
   * Get sales history for a specific customer mobile
   */

  async getSalesHistory(sellerId, query) {
    const page = parseInt(query.page, 10) || 1;
    const limit = parseInt(query.limit, 10) || 10;
    const { searchCustomer, searchSerial, fromDate, toDate } = query;

    const filters = {
      searchCustomer,
      searchSerial,
      fromDate,
      toDate,
    };

    const pagination = {
      skip: (page - 1) * limit,
      take: limit,
    };

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
   * Get paginated sales history for Admin — all sellers, with shipment tracing
   */
  async getAdminSalesHistory(query) {
    const page = parseInt(query.page, 10) || 1;
    const limit = parseInt(query.limit, 10) || 10;
    const { search, sellerId, fromDate, toDate, shipmentStatus } = query;

    const filters = { search, sellerId, fromDate, toDate, shipmentStatus };

    const pagination = {
      skip: (page - 1) * limit,
      take: limit,
    };

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
