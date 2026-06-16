const service = require('./product-units.service');
const { successResponse } = require('../../shared/utils/response');

const createProductUnit = async (req, res, next) => {
  try {
    const unit = await service.createProductUnit(req.body);
    return successResponse(res, 201, 'Product unit created', unit);
  } catch (error) { next(error); }
};

const getProductUnits = async (req, res, next) => {
  try {
    const result = await service.getProductUnits(req.query);
    return successResponse(res, 200, 'Product units fetched', result);
  } catch (error) { next(error); }
};

const getProductUnitById = async (req, res, next) => {
  try {
    const unit = await service.getProductUnitById(req.params.id);
    return successResponse(res, 200, 'Product unit fetched', unit);
  } catch (error) { next(error); }
};

const getProductUnitBySerialNumber = async (req, res, next) => {
  try {
    const unit = await service.getProductUnitBySerialNumber(req.params.serialNumber);
    return successResponse(res, 200, 'Product unit fetched', unit);
  } catch (error) { next(error); }
};

const updateProductUnit = async (req, res, next) => {
  try {
    const unit = await service.updateProductUnit(req.params.id, req.body);
    return successResponse(res, 200, 'Product unit updated', unit);
  } catch (error) { next(error); }
};

module.exports = {
  createProductUnit,
  getProductUnits,
  getProductUnitById,
  getProductUnitBySerialNumber,
  updateProductUnit
};
