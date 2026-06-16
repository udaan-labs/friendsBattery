const repo = require('./stock-requests.repository');

const createStockRequest = async (shopId, userId, items) => {
  return await repo.createStockRequest(shopId, userId, items);
};

const getStockRequests = async (filters) => {
  return await repo.getStockRequests(filters);
};

const updateStockRequestStatus = async (id, status, reviewerId, fulfilledUnits) => {
  try {
    return await repo.updateStockRequestStatus(id, status, reviewerId, fulfilledUnits);
  } catch (error) {
    error.statusCode = 400;
    throw error;
  }
};

module.exports = {
  createStockRequest,
  getStockRequests,
  updateStockRequestStatus
};
