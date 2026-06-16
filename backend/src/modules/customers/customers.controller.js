const customerService = require('./customers.service');
const { successResponse } = require('../../shared/utils/response');

const createCustomer = async (req, res, next) => {
  try {
    const customer = await customerService.createCustomer(req.body);
    return successResponse(res, 201, 'Customer created successfully', customer);
  } catch (error) { next(error); }
};

const getCustomers = async (req, res, next) => {
  try {
    const customers = await customerService.getCustomers(req.query);
    return successResponse(res, 200, 'Customers fetched successfully', customers);
  } catch (error) { next(error); }
};

const getCustomerById = async (req, res, next) => {
  try {
    const customer = await customerService.getCustomerById(req.params.id);
    return successResponse(res, 200, 'Customer fetched successfully', customer);
  } catch (error) { next(error); }
};

const updateCustomer = async (req, res, next) => {
  try {
    const customer = await customerService.updateCustomer(req.params.id, req.body);
    return successResponse(res, 200, 'Customer updated successfully', customer);
  } catch (error) { next(error); }
};

module.exports = {
  createCustomer,
  getCustomers,
  getCustomerById,
  updateCustomer
};
