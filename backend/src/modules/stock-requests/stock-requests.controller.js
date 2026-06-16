const service = require('./stock-requests.service');
const { successResponse } = require('../../shared/utils/response');
const { SELLER } = require('../../shared/constants/roles');

const createStockRequest = async (req, res, next) => {
  try {
    if (!req.user.shop_id) {
      throw new Error('User does not belong to a shop');
    }
    const request = await service.createStockRequest(req.user.shop_id, req.user.id, req.body.items);
    return successResponse(res, 201, 'Stock request created', request);
  } catch (error) { next(error); }
};

const getStockRequests = async (req, res, next) => {
  try {
    const filters = {};
    if (req.query.status) filters.status = req.query.status;
    if (req.user.role === SELLER) {
      filters.shopId = req.user.shop_id;
    }
    const requests = await service.getStockRequests(filters);
    return successResponse(res, 200, 'Stock requests fetched', requests);
  } catch (error) { next(error); }
};

const updateStockRequestStatus = async (req, res, next) => {
  try {
    const { status, fulfilledUnits } = req.body;
    
    // Only APPROVED requires fulfilledUnits. REJECTED does not.
    if (status === 'APPROVED' && (!fulfilledUnits || fulfilledUnits.length === 0)) {
        throw new Error('fulfilledUnits are required when approving');
    }

    const request = await service.updateStockRequestStatus(req.params.id, status, req.user.id, fulfilledUnits);
    return successResponse(res, 200, `Stock request ${status.toLowerCase()}`, request);
  } catch (error) { next(error); }
};

module.exports = {
  createStockRequest,
  getStockRequests,
  updateStockRequestStatus
};
