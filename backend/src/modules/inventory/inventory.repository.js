const prisma = require('../../config/db');
const auditLogRepo = require('../audit-logs/audit-logs.repository');

// Execute an atomic transaction to transfer inventory
const transferInventory = async (data, userId) => {
  return await prisma.$transaction(async (tx) => {
    let updatedUnit;
    let transaction;
    let newStatus;

    if (data.transactionType === 'RECEIVED') newStatus = 'IN_WAREHOUSE';
    else if (data.transactionType === 'TRANSFERRED' && data.toType === 'SHOP') newStatus = 'AT_SHOP';
    else if (data.transactionType === 'SOLD') newStatus = 'SOLD';
    else if (data.transactionType === 'RETURNED') newStatus = 'RETURNED';
    else if (data.transactionType === 'REPLACED') newStatus = 'REPLACED';
    else if (data.transactionType === 'SCRAPPED') newStatus = 'SCRAPPED';
    else newStatus = 'IN_WAREHOUSE';

    if (data.productUnitId) {
      // Serialized logic
      updatedUnit = await tx.productUnit.update({
        where: { id: data.productUnitId },
        data: {
          current_owner_type: data.toType,
          current_owner_id: data.toId,
          status: newStatus
        }
      });
      
      transaction = await tx.inventoryTransaction.create({
        data: {
          product_unit_id: data.productUnitId,
          transaction_type: data.transactionType,
          from_owner_type: data.fromType,
          from_owner_id: data.fromId,
          to_owner_type: data.toType,
          to_owner_id: data.toId,
          performed_by_user_id: userId,
          notes: data.notes
        }
      });

      // 4. Audit Log
      await auditLogRepo.createAuditLog(tx, {
        userId,
        entityName: 'ProductUnit',
        entityId: data.productUnitId,
        action: 'TRANSFERRED',
        oldData: { previous_owner_type: data.fromType, previous_owner_id: data.fromId },
        newData: { current_owner_type: data.toType, current_owner_id: data.toId, status: newStatus }
      });
    } else if (data.productId && data.quantity) {
      // Bulk logic
      if (data.fromType === 'SHOP') {
        const inventory = await tx.shopInventoryAggregate.findUnique({
          where: { shop_id_product_id: { shop_id: data.fromId, product_id: data.productId } }
        });
        if (!inventory || inventory.quantity < data.quantity) throw new Error('Not enough bulk inventory');
        
        await tx.shopInventoryAggregate.update({
          where: { id: inventory.id },
          data: { quantity: inventory.quantity - data.quantity }
        });
      }

      if (data.toType === 'SHOP') {
        await tx.shopInventoryAggregate.upsert({
          where: { shop_id_product_id: { shop_id: data.toId, product_id: data.productId } },
          update: { quantity: { increment: data.quantity } },
          create: { shop_id: data.toId, product_id: data.productId, quantity: data.quantity }
        });
      }

      transaction = await tx.inventoryTransaction.create({
        data: {
          product_id: data.productId,
          quantity: data.quantity,
          transaction_type: data.transactionType,
          from_owner_type: data.fromType,
          from_owner_id: data.fromId,
          to_owner_type: data.toType,
          to_owner_id: data.toId,
          performed_by_user_id: userId,
          notes: data.notes
        }
      });

      updatedUnit = { productId: data.productId, quantity: data.quantity, status: newStatus };
    } else {
      throw new Error('Either productUnitId or (productId and quantity) required');
    }

    return { transaction, updatedUnit };
  });
};

const getHistoryByProductUnitId = async (productUnitId) => {
  return await prisma.inventoryTransaction.findMany({
    where: { product_unit_id: productUnitId },
    orderBy: { created_at: 'desc' },
    include: {
      performed_by: {
        select: { id: true, name: true, email: true }
      }
    }
  });
};

const getHistoryBySerialNumber = async (serialNumber) => {
  const productUnit = await prisma.productUnit.findUnique({
    where: { serial_number: serialNumber },
    select: { id: true }
  });
  
  if (!productUnit) return null;

  return await getHistoryByProductUnitId(productUnit.id);
};

module.exports = {
  transferInventory,
  getHistoryByProductUnitId,
  getHistoryBySerialNumber
};
