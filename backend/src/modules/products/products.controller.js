const productService = require('./products.service');
const { successResponse } = require('../../shared/utils/response');

// Product Group
const createProductGroup = async (req, res, next) => {
  try {
    const group = await productService.createProductGroup(req.body);
    return successResponse(res, 201, 'Product group created', group);
  } catch (error) { next(error); }
};
const getProductGroups = async (req, res, next) => {
  try {
    const groups = await productService.getProductGroups();
    return successResponse(res, 200, 'Product groups fetched', groups);
  } catch (error) { next(error); }
};

// Product Subgroup
const createProductSubgroup = async (req, res, next) => {
  try {
    const subgroup = await productService.createProductSubgroup(req.body);
    return successResponse(res, 201, 'Product subgroup created', subgroup);
  } catch (error) { next(error); }
};
const getProductSubgroups = async (req, res, next) => {
  try {
    const subgroups = await productService.getProductSubgroups();
    return successResponse(res, 200, 'Product subgroups fetched', subgroups);
  } catch (error) { next(error); }
};

// Product
const createProduct = async (req, res, next) => {
  try {
    const userId = req.user ? req.user.id : null;
    const product = await productService.createProduct(req.body, userId);
    return successResponse(res, 201, 'Product created', product);
  } catch (error) { next(error); }
};
const getProducts = async (req, res, next) => {
  try {
    const products = await productService.getProducts();
    return successResponse(res, 200, 'Products fetched', products);
  } catch (error) { next(error); }
};
const getProductById = async (req, res, next) => {
  try {
    const product = await productService.getProductById(req.params.id);
    return successResponse(res, 200, 'Product fetched', product);
  } catch (error) { next(error); }
};
const updateProduct = async (req, res, next) => {
  try {
    const product = await productService.updateProduct(req.params.id, req.body);
    return successResponse(res, 200, 'Product updated', product);
  } catch (error) { next(error); }
};

module.exports = {
  createProductGroup,
  getProductGroups,
  createProductSubgroup,
  getProductSubgroups,
  createProduct,
  getProducts,
  getProductById,
  updateProduct
};
