const prisma = require('../../config/db');

const createShop = async (data) => {
  return await prisma.shop.create({
    data
  });
};

const getShops = async () => {
  return await prisma.shop.findMany({
    orderBy: { created_at: 'desc' }
  });
};

const getShopById = async (id) => {
  return await prisma.shop.findUnique({
    where: { id }
  });
};

const updateShop = async (id, data) => {
  return await prisma.shop.update({
    where: { id },
    data
  });
};

const deleteShop = async (id) => {
  return await prisma.shop.delete({
    where: { id }
  });
};

module.exports = {
  createShop,
  getShops,
  getShopById,
  updateShop,
  deleteShop
};
