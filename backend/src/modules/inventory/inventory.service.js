const repo = require('./inventory.repository');

const transferInventory = async (data, userId) => {
  return await repo.transferInventory(data, userId);
};

const getHistoryByProductUnitId = async (productUnitId) => {
  return await repo.getHistoryByProductUnitId(productUnitId);
};

const getHistoryBySerialNumber = async (serialNumber) => {
  const history = await repo.getHistoryBySerialNumber(serialNumber);
  if (!history) {
    const error = new Error('Product unit not found');
    error.statusCode = 404;
    throw error;
  }
  return history;
};

module.exports = {
  transferInventory,
  getHistoryByProductUnitId,
  getHistoryBySerialNumber
};
