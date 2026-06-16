const salesService = require('./sales.service');
const { successResponse } = require('../../shared/utils/response');

const createSale = async (req, res, next) => {
  try {
    const saleData = {
      productUnitId: req.body.productUnitId,
      productId: req.body.productId,
      quantity: req.body.quantity,
      customerId: req.body.customerId,
      salePrice: req.body.salePrice,
      sellerId: req.user.id,
      shopId: req.user.shop_id
    };

    if (!saleData.shopId) {
      const error = new Error('User does not belong to a shop');
      error.statusCode = 403;
      throw error;
    }

    const sale = await salesService.executeSale(saleData);
    return successResponse(res, 201, 'Sale executed successfully', sale);
  } catch (error) { next(error); }
};

module.exports = {
  createSale
};
