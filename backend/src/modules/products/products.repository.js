const prisma = require('../../config/db');
const auditLogRepo = require('../audit-logs/audit-logs.repository');

// Product Group
const createProductGroup = async (data) => {
  return await prisma.productGroup.create({ data });
};
const getProductGroups = async () => {
  return await prisma.productGroup.findMany({ orderBy: { created_at: 'desc' } });
};

// Product Subgroup
const createProductSubgroup = async (data) => {
  return await prisma.productSubgroup.create({ data });
};
const getProductSubgroups = async () => {
  return await prisma.productSubgroup.findMany({
    include: { group: true },
    orderBy: { created_at: 'desc' }
  });
};

// Product
const createProduct = async (data, userId) => {
  return await prisma.$transaction(async (tx) => {
    const product = await tx.product.create({ data });
    
    if (userId) {
      await auditLogRepo.createAuditLog(tx, {
        userId,
        entityName: 'Product',
        entityId: product.id,
        action: 'CREATED',
        newData: product
      });
    }

    return product;
  });
};
const getProducts = async () => {
  return await prisma.product.findMany({
    include: { subgroup: { include: { group: true } } },
    orderBy: { created_at: 'desc' }
  });
};
const getProductById = async (id) => {
  return await prisma.product.findUnique({
    where: { id },
    include: { subgroup: { include: { group: true } } }
  });
};
const updateProduct = async (id, data) => {
  return await prisma.product.update({
    where: { id },
    data
  });
};

module.exports = {
  createProductGroup,
  getProductGroups,
  createProductSubgroup,
  getProductSubgroups,
  createProduct,
  getProducts,
  getProductById,
  updateProduct
};
