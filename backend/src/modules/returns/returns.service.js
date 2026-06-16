const returnRepo = require('./returns.repository');

const createReturn = async (data) => {
  return await returnRepo.createReturn(data);
};

const updateReturnStatus = async (id, status, userId) => {
  const returnReq = await returnRepo.getReturnById(id);
  if (!returnReq) {
    const error = new Error('Return request not found');
    error.statusCode = 404;
    throw error;
  }
  return await returnRepo.updateReturnStatus(id, status, userId);
};

const processReplacement = async (returnId, newProductUnitId, userId, shopId) => {
  try {
    return await returnRepo.processReplacement(returnId, newProductUnitId, userId, shopId);
  } catch (error) {
    error.statusCode = error.statusCode || 400;
    throw error;
  }
};

module.exports = {
  createReturn,
  updateReturnStatus,
  processReplacement
};
