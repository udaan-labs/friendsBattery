const prisma = require('../../config/db');
const auditLogRepo = require('../audit-logs/audit-logs.repository');

const createReturn = async (data) => {
  return await prisma.return.create({
    data: {
      sale_id: data.saleId,
      product_unit_id: data.productUnitId,
      return_reason: data.returnReason
    }
  });
};

const updateReturnStatus = async (id, status, userId) => {
  return await prisma.$transaction(async (tx) => {
    const updatedReturn = await tx.return.update({
      where: { id },
      data: { status }
    });

    // Optionally sync the physical product status based on the new return status
    if (['UNDER_INSPECTION', 'SCRAPPED', 'RETURNED'].includes(status)) {
        await tx.productUnit.update({
            where: { id: updatedReturn.product_unit_id },
            data: { status }
        });
    }

    if (status === 'APPROVED') {
      await auditLogRepo.createAuditLog(tx, {
        userId,
        entityName: 'Return',
        entityId: id,
        action: 'APPROVED',
        newData: updatedReturn
      });
    }

    return updatedReturn;
  });
};

const getReturnById = async (id) => {
  return await prisma.return.findUnique({
    where: { id },
    include: {
      sale: true,
      product_unit: true,
      replacement: true
    }
  });
};

const processReplacement = async (returnId, newProductUnitId, userId, shopId) => {
  return await prisma.$transaction(async (tx) => {
    const returnRequest = await tx.return.findUnique({
      where: { id: returnId },
      include: { sale: true }
    });

    if (!returnRequest || returnRequest.status !== 'APPROVED') {
      throw new Error('Return request must be APPROVED before replacement');
    }

    const newUnit = await tx.productUnit.findUnique({
      where: { id: newProductUnitId }
    });

    if (!newUnit || newUnit.status !== 'AT_SHOP' || newUnit.current_owner_id !== shopId) {
      throw new Error('New product unit is not available at your shop');
    }

    const oldUnitId = returnRequest.product_unit_id;

    // 1. Update Old Unit -> REPLACED
    await tx.productUnit.update({
      where: { id: oldUnitId },
      data: {
        status: 'REPLACED',
        current_owner_type: 'SHOP',
        current_owner_id: shopId
      }
    });

    // 2. Update New Unit -> SOLD
    await tx.productUnit.update({
      where: { id: newProductUnitId },
      data: {
        status: 'SOLD',
        current_owner_type: 'CUSTOMER',
        current_owner_id: returnRequest.sale.customer_id
      }
    });

    // 3. Create Inventory Transactions
    // Old enters shop
    await tx.inventoryTransaction.create({
      data: {
        product_unit_id: oldUnitId,
        transaction_type: 'RETURNED',
        from_owner_type: 'CUSTOMER',
        from_owner_id: returnRequest.sale.customer_id,
        to_owner_type: 'SHOP',
        to_owner_id: shopId,
        performed_by_user_id: userId,
        notes: `Returned via return request ${returnId}`
      }
    });

    // New leaves shop
    await tx.inventoryTransaction.create({
      data: {
        product_unit_id: newProductUnitId,
        transaction_type: 'SOLD',
        from_owner_type: 'SHOP',
        from_owner_id: shopId,
        to_owner_type: 'CUSTOMER',
        to_owner_id: returnRequest.sale.customer_id,
        performed_by_user_id: userId,
        notes: `Replacement for ${oldUnitId} via return request ${returnId}`
      }
    });

    // 4. Update Return status -> REPLACED
    const updatedReturn = await tx.return.update({
      where: { id: returnId },
      data: { status: 'REPLACED' }
    });

    // 5. Create Replacement record
    const replacement = await tx.replacement.create({
      data: {
        return_id: returnId,
        old_product_unit_id: oldUnitId,
        new_product_unit_id: newProductUnitId
      }
    });

    return { updatedReturn, replacement };
  });
};

module.exports = {
  createReturn,
  updateReturnStatus,
  getReturnById,
  processReplacement
};
