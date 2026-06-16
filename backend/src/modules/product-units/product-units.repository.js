const prisma = require('../../config/db');

const createProductUnit = async (data) => {
  return await prisma.productUnit.create({
    data: {
      product_id: data.productId,
      serial_number: data.serialNumber,
      manufacturingDate: data.manufacturingDate ? new Date(data.manufacturingDate) : undefined,
      receivedDate: data.receivedDate ? new Date(data.receivedDate) : undefined,
      status: data.status,
      current_owner_type: data.currentOwnerType,
      current_owner_id: data.currentOwnerId
    }
  });
};

const getProductUnits = async (filters, page = 1, limit = 10) => {
  const skip = (page - 1) * limit;
  const where = {};
  
  if (filters.productId) where.product_id = filters.productId;
  if (filters.serialNumber) where.serial_number = { contains: filters.serialNumber, mode: 'insensitive' };
  if (filters.status) where.status = filters.status;
  if (filters.currentOwnerId) where.current_owner_id = filters.currentOwnerId;

  const [data, total] = await Promise.all([
    prisma.productUnit.findMany({
      where,
      skip,
      take: limit,
      orderBy: { created_at: 'desc' },
      include: { product: true }
    }),
    prisma.productUnit.count({ where })
  ]);

  return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
};

const getProductUnitById = async (id) => {
  return await prisma.productUnit.findUnique({
    where: { id },
    include: { product: true }
  });
};

const getProductUnitBySerialNumber = async (serialNumber) => {
  return await prisma.productUnit.findUnique({
    where: { serial_number: serialNumber },
    include: { product: true }
  });
};

const updateProductUnit = async (id, data) => {
  const updateData = {};
  if (data.status) updateData.status = data.status;
  if (data.currentOwnerType) updateData.current_owner_type = data.currentOwnerType;
  if (data.currentOwnerId !== undefined) updateData.current_owner_id = data.currentOwnerId;
  if (data.manufacturingDate) updateData.manufacturingDate = new Date(data.manufacturingDate);
  if (data.receivedDate) updateData.receivedDate = new Date(data.receivedDate);

  return await prisma.productUnit.update({
    where: { id },
    data: updateData
  });
};

module.exports = {
  createProductUnit,
  getProductUnits,
  getProductUnitById,
  getProductUnitBySerialNumber,
  updateProductUnit
};
