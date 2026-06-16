const shopRepo = require('./shops.repository');

const createShop = async (data) => {
  return await shopRepo.createShop(data);
};

const getShops = async () => {
  return await shopRepo.getShops();
};

const getShopById = async (id) => {
  const shop = await shopRepo.getShopById(id);
  if (!shop) {
    const error = new Error('Shop not found');
    error.statusCode = 404;
    throw error;
  }
  return shop;
};

const updateShop = async (id, data) => {
  await getShopById(id); // Check existence
  return await shopRepo.updateShop(id, data);
};

const deleteShop = async (id) => {
  await getShopById(id); // Check existence
  return await shopRepo.deleteShop(id);
};

module.exports = {
  createShop,
  getShops,
  getShopById,
  updateShop,
  deleteShop
};
