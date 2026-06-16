const prisma = require('../../config/db');
const auditLogRepo = require('../audit-logs/audit-logs.repository');

const createStockRequest = async (shopId, userId, items) => {
  return await prisma.$transaction(async (tx) => {
    const request = await tx.stockRequest.create({
      data: {
        shop_id: shopId,
        requested_by_user_id: userId,
        status: 'PENDING'
      }
    });

    await tx.stockRequestItem.createMany({
      data: items.map(item => ({
        stock_request_id: request.id,
        product_id: item.productId,
        requested_quantity: item.quantity
      }))
    });

    return request;
  });
};

const getStockRequests = async (filters) => {
  const where = {};
  if (filters.shopId) where.shop_id = filters.shopId;
  if (filters.status) where.status = filters.status;

  return await prisma.stockRequest.findMany({
    where,
    include: {
      items: { include: { product: true } },
      shop: true,
      requested_by: { select: { id: true, name: true } },
      reviewed_by: { select: { id: true, name: true } }
    },
    orderBy: { created_at: 'desc' }
  });
};

const getStockRequestById = async (id) => {
  return await prisma.stockRequest.findUnique({
    where: { id },
    include: { items: true }
  });
};

const updateStockRequestStatus = async (id, status, reviewerId, fulfilledUnits = []) => {
  return await prisma.$transaction(async (tx) => {
    const request = await tx.stockRequest.findUnique({
      where: { id },
      include: { items: true }
    });

    if (!request || request.status !== 'PENDING') {
      throw new Error('Stock request not found or not in PENDING state');
    }

    if (status === 'REJECTED') {
      return await tx.stockRequest.update({
        where: { id },
        data: { status: 'REJECTED', reviewed_by_user_id: reviewerId }
      });
    }

    if (status === 'APPROVED') {
      // 1. Differentiate serialized and non-serialized
      const products = await tx.product.findMany({
        where: { id: { in: request.items.map(i => i.product_id) } }
      });
      const productMap = {};
      products.forEach(p => productMap[p.id] = p);

      const requestedMap = {};
      const nonSerializedRequestedMap = {};
      let totalSerializedRequested = 0;

      for (const item of request.items) {
        if (productMap[item.product_id].is_serialized) {
          requestedMap[item.product_id] = (requestedMap[item.product_id] || 0) + item.requested_quantity;
          totalSerializedRequested += item.requested_quantity;
        } else {
          nonSerializedRequestedMap[item.product_id] = (nonSerializedRequestedMap[item.product_id] || 0) + item.requested_quantity;
        }
      }

      if (fulfilledUnits.length !== totalSerializedRequested) {
        throw new Error(`Expected exactly ${totalSerializedRequested} product units for serialized products, but got ${fulfilledUnits.length}`);
      }

      // 2. Fetch the actual product units to verify they match the requested products and are IN_WAREHOUSE
      if (fulfilledUnits.length > 0) {
        const units = await tx.productUnit.findMany({
          where: { id: { in: fulfilledUnits } }
        });

        if (units.length !== fulfilledUnits.length) {
          throw new Error('One or more product units not found');
        }

        const fulfilledMap = {};
        for (const unit of units) {
          if (unit.status !== 'IN_WAREHOUSE' || unit.current_owner_type !== 'WHOLESALER') {
            throw new Error(`Unit ${unit.serial_number} is not IN_WAREHOUSE / WHOLESALER`);
          }
          fulfilledMap[unit.product_id] = (fulfilledMap[unit.product_id] || 0) + 1;
        }

        // Compare requested and fulfilled for serialized
        for (const productId in requestedMap) {
          if (requestedMap[productId] !== fulfilledMap[productId]) {
            throw new Error('Provided units do not match requested serialized products quantities exactly');
          }
        }

        // 3. Process the transfer for serialized
        await tx.productUnit.updateMany({
          where: { id: { in: fulfilledUnits } },
          data: {
            status: 'AT_SHOP',
            current_owner_type: 'SHOP',
            current_owner_id: request.shop_id
          }
        });

        await tx.inventoryTransaction.createMany({
          data: units.map(unit => ({
            product_unit_id: unit.id,
            transaction_type: 'RESTOCK_APPROVED',
            from_owner_type: 'WHOLESALER',
            to_owner_type: 'SHOP',
            to_owner_id: request.shop_id,
            performed_by_user_id: reviewerId,
            notes: `Restock request ${id}`
          }))
        });
      }

      // 4. Process the transfer for non-serialized
      for (const productId in nonSerializedRequestedMap) {
        const qty = nonSerializedRequestedMap[productId];
        await tx.shopInventoryAggregate.upsert({
          where: { shop_id_product_id: { shop_id: request.shop_id, product_id: productId } },
          update: { quantity: { increment: qty } },
          create: { shop_id: request.shop_id, product_id: productId, quantity: qty }
        });

        await tx.inventoryTransaction.create({
          data: {
            product_id: productId,
            quantity: qty,
            transaction_type: 'RESTOCK_APPROVED',
            from_owner_type: 'WHOLESALER',
            to_owner_type: 'SHOP',
            to_owner_id: request.shop_id,
            performed_by_user_id: reviewerId,
            notes: `Bulk restock request ${id}`
          }
        });
      }

      // Update Request
      const updatedRequest = await tx.stockRequest.update({
        where: { id },
        data: { status: 'APPROVED', reviewed_by_user_id: reviewerId }
      });

      await auditLogRepo.createAuditLog(tx, {
        userId: reviewerId,
        entityName: 'StockRequest',
        entityId: id,
        action: 'APPROVED',
        newData: { status: 'APPROVED', fulfilledUnits }
      });

      return updatedRequest;
    }
  });
};

module.exports = {
  createStockRequest,
  getStockRequests,
  getStockRequestById,
  updateStockRequestStatus
};
