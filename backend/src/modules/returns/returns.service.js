const returnsRepository = require('./returns.repository');
const { httpError } = require('../../shared/utils/http-error');

class ReturnsService {
  /**
   * Process a product return
   * 
   * @param {Object} data - The return data (serial_number, reason)
   * @param {number} sellerId - The authenticated seller's ID
   */
  async processReturn(data, sellerId) {
    const { serial_number: serialNumber, reason } = data;

    if (!serialNumber || !reason) {
      throw httpError(400, 'serial_number and reason are required');
    }

    // 1. Find the product unit
    const productUnit = await returnsRepository.getProductUnitBySerialNumber(serialNumber);
    
    if (!productUnit) {
      throw httpError(404, `Product unit with serial number ${serialNumber} not found`);
    }

    // 2. Ensure it's currently sold
    if (productUnit.status !== 'SOLD') {
      throw httpError(400, `Product unit is not in SOLD status. Current status: ${productUnit.status}`);
    }

    // 3. Find the latest sales transaction
    const latestSale = await returnsRepository.getLatestSalesTransaction(productUnit.id);

    if (!latestSale) {
      throw httpError(400, 'No sales transaction found for this product unit');
    }

    // 4. Verify that this seller actually sold this item
    // In our YAGNI approach, we just check the latest sale's sellerId
    if (latestSale.sellerId.toString() !== sellerId.toString()) {
      throw httpError(403, 'You cannot return a product that you did not sell');
    }

    // 5. Process the return via transaction
    const result = await returnsRepository.processReturn({
      productUnitId: productUnit.id,
      productId: productUnit.productId,
      transactionId: latestSale.id,
      serialNumber,
      reason,
      sellerId
    });

    // Serialize BigInt for JSON response
    return {
      message: 'Return processed successfully',
      returnRecordId: result.returnRecord.id.toString(),
      productUnitId: result.updatedUnit.id.toString(),
      status: result.updatedUnit.status
    };
  }

  /**
   * Get return history based on user role
   */
  async getReturns(user) {
    const where = {};
    
    // If not Admin, filter by user's own returns
    if (user.role !== 'ADMIN') {
      where.returnById = user.id;
    }
    
    const returns = await returnsRepository.getReturns(where);
    
    // Serialize BigInt to string
    return returns.map(r => ({
      ...r,
      id: r.id.toString(),
      transactionId: r.transactionId ? r.transactionId.toString() : null,
      productId: r.productId ? r.productId.toString() : null,
      returnById: r.returnById ? r.returnById.toString() : null,
      returnToId: r.returnToId ? r.returnToId.toString() : null,
      product: r.product ? {
        ...r.product,
        id: r.product.id.toString(),
        productNameId: r.product.productNameId.toString(),
        productModelId: r.product.productModelId.toString(),
        productName: r.product.productName ? {
          ...r.product.productName,
          id: r.product.productName.id.toString()
        } : null,
        productModel: r.product.productModel ? {
          ...r.product.productModel,
          id: r.product.productModel.id.toString(),
          productNameId: r.product.productModel.productNameId.toString()
        } : null
      } : null
    }));
  }
}

module.exports = new ReturnsService();
