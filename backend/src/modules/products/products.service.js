const productRepo = require('./products.repository');

const createProductGroup = async (data) => {
  return await productRepo.createProductGroup(data);
};
const getProductGroups = async () => {
  return await productRepo.getProductGroups();
};

const createProductSubgroup = async (data) => {
  return await productRepo.createProductSubgroup(data);
};
const getProductSubgroups = async () => {
  return await productRepo.getProductSubgroups();
};

const createProduct = async (data, userId) => {
  return await productRepo.createProduct(data, userId);
};
const getProducts = async () => {
  return await productRepo.getProducts();
};
const getProductById = async (id) => {
  const product = await productRepo.getProductById(id);
  if (!product) {
    const error = new Error('Product not found');
    error.statusCode = 404;
    throw error;
  }
  return product;
};
const updateProduct = async (id, data) => {
  await getProductById(id); // Ensure existence
  return await productRepo.updateProduct(id, data);
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
