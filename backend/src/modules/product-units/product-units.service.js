const repo = require('./product-units.repository');

const createProductUnit = async (data) => {
  // Enforce unique serial number check
  const existing = await repo.getProductUnitBySerialNumber(data.serialNumber);
  if (existing) {
    const error = new Error('Serial number already exists');
    error.statusCode = 409;
    throw error;
  }
  return await repo.createProductUnit(data);
};

const getProductUnits = async (query) => {
  const { page = 1, limit = 10, ...filters } = query;
  return await repo.getProductUnits(filters, page, limit);
};

const getProductUnitById = async (id) => {
  const unit = await repo.getProductUnitById(id);
  if (!unit) {
    const error = new Error('Product unit not found');
    error.statusCode = 404;
    throw error;
  }
  return unit;
};

const getProductUnitBySerialNumber = async (serialNumber) => {
  const unit = await repo.getProductUnitBySerialNumber(serialNumber);
  if (!unit) {
    const error = new Error('Product unit not found');
    error.statusCode = 404;
    throw error;
  }
  return unit;
};

const updateProductUnit = async (id, data) => {
  await getProductUnitById(id); // Ensure exists
  return await repo.updateProductUnit(id, data);
};

module.exports = {
  createProductUnit,
  getProductUnits,
  getProductUnitById,
  getProductUnitBySerialNumber,
  updateProductUnit
};
