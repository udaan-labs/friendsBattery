const shopService = require('./shops.service');
const { successResponse } = require('../../shared/utils/response');

const createShop = async (req, res, next) => {
  try {
    const shop = await shopService.createShop(req.body);
    return successResponse(res, 201, 'Shop created successfully', shop);
  } catch (error) {
    next(error);
  }
};

const getShops = async (req, res, next) => {
  try {
    const shops = await shopService.getShops();
    return successResponse(res, 200, 'Shops fetched successfully', shops);
  } catch (error) {
    next(error);
  }
};

const getShopById = async (req, res, next) => {
  try {
    const shop = await shopService.getShopById(req.params.id);
    return successResponse(res, 200, 'Shop fetched successfully', shop);
  } catch (error) {
    next(error);
  }
};

const updateShop = async (req, res, next) => {
  try {
    const shop = await shopService.updateShop(req.params.id, req.body);
    return successResponse(res, 200, 'Shop updated successfully', shop);
  } catch (error) {
    next(error);
  }
};

const deleteShop = async (req, res, next) => {
  try {
    await shopService.deleteShop(req.params.id);
    return successResponse(res, 200, 'Shop deleted successfully', null);
  } catch (error) {
    next(error);
  }
};

module.exports = {
  createShop,
  getShops,
  getShopById,
  updateShop,
  deleteShop
};
