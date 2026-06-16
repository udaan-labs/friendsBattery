const salesRepo = require('./sales.repository');

const executeSale = async (saleData) => {
  try {
    return await salesRepo.executeSale(saleData);
  } catch (error) {
    // Standardize error handling for transaction failures
    error.statusCode = error.statusCode || 400;
    throw error;
  }
};

module.exports = {
  executeSale
};
