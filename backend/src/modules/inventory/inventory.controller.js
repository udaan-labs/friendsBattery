const service = require('./inventory.service');
const { successResponse } = require('../../shared/utils/response');

const transferInventory = async (req, res, next) => {
  try {
    const userId = req.user.id; // From auth middleware
    const result = await service.transferInventory(req.body, userId);
    return successResponse(res, 201, 'Inventory transfer successful', result);
  } catch (error) { next(error); }
};

const getHistoryByProductUnitId = async (req, res, next) => {
  try {
    const history = await service.getHistoryByProductUnitId(req.params.productUnitId);
    return successResponse(res, 200, 'Inventory history fetched', history);
  } catch (error) { next(error); }
};

const getHistoryBySerialNumber = async (req, res, next) => {
  try {
    const history = await service.getHistoryBySerialNumber(req.params.serialNumber);
    return successResponse(res, 200, 'Inventory history fetched', history);
  } catch (error) { next(error); }
};

module.exports = {
  transferInventory,
  getHistoryByProductUnitId,
  getHistoryBySerialNumber
};
