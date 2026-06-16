const prisma = require('../../config/db');

const createCustomer = async (data) => {
  return await prisma.customer.create({ data });
};

const getCustomers = async (filters) => {
  const where = {};
  if (filters.mobile) where.mobile = { contains: filters.mobile, mode: 'insensitive' };
  if (filters.vehicleNumber) where.vehicleNumber = { contains: filters.vehicleNumber, mode: 'insensitive' };

  return await prisma.customer.findMany({
    where,
    orderBy: { created_at: 'desc' }
  });
};

const getCustomerById = async (id) => {
  return await prisma.customer.findUnique({
    where: { id }
  });
};

const updateCustomer = async (id, data) => {
  return await prisma.customer.update({
    where: { id },
    data
  });
};

module.exports = {
  createCustomer,
  getCustomers,
  getCustomerById,
  updateCustomer
};
