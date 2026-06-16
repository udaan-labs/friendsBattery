const customerRepo = require('./customers.repository');

const createCustomer = async (data) => {
  return await customerRepo.createCustomer(data);
};

const getCustomers = async (filters) => {
  return await customerRepo.getCustomers(filters);
};

const getCustomerById = async (id) => {
  const customer = await customerRepo.getCustomerById(id);
  if (!customer) {
    const error = new Error('Customer not found');
    error.statusCode = 404;
    throw error;
  }
  return customer;
};

const updateCustomer = async (id, data) => {
  await getCustomerById(id); // Check existence
  return await customerRepo.updateCustomer(id, data);
};

module.exports = {
  createCustomer,
  getCustomers,
  getCustomerById,
  updateCustomer
};
