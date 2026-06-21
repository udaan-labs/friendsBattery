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
      sell_price: sale.sellPrice,
      serial_number: sale.serialNumber,
      vehicle_number: sale.vehicleNumber,
      sold_at: sale.soldAt,
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
        category: sale.product.category.name,
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

    // 2. Verify serial number exists in seller inventory
    const productUnit = await salesRepository.findAvailableProductUnit(data.serial_number, sellerId);
    
    if (!productUnit) {
      const error = new Error('Serial number not found in your available inventory');
      error.statusCode = 404;
      throw error;
    }

    // 3. Verify the product unit matches the requested product ID
    if (Number(productUnit.productId) !== data.product_id) {
      const error = new Error('Serial number does not match the specified product');
      error.statusCode = 400;
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
  async getCustomerHistory(mobile) {
    const sales = await salesRepository.getSalesByCustomerMobile(mobile);
    return sales.map(this._formatSale);
  }
}

module.exports = new SalesService();
