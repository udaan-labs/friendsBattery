const prisma = require('../../config/db');
const auditLogRepo = require('../audit-logs/audit-logs.repository');

// Execute sale using atomic transaction
const executeSale = async (data) => {
  return await prisma.$transaction(async (tx) => {
    let sale;
    if (data.productUnitId) {
      // 1. Fetch the product unit
      const productUnit = await tx.productUnit.findUnique({
        where: { id: data.productUnitId }
      });

      if (!productUnit) {
        throw new Error('Product unit not found');
      }

      // 2. Check if product belongs to the seller's shop
      if (productUnit.current_owner_type !== 'SHOP' || productUnit.current_owner_id !== data.shopId) {
        throw new Error('Product unit does not belong to your shop');
      }

      // 3. Check if product is AT_SHOP
      if (productUnit.status !== 'AT_SHOP') {
        throw new Error('Product unit is not available at the shop for sale');
      }

      // 4. Update ProductUnit (status = SOLD, owner = CUSTOMER)
      const updatedUnit = await tx.productUnit.update({
        where: { id: data.productUnitId },
        data: {
          status: 'SOLD',
          current_owner_type: 'CUSTOMER',
          current_owner_id: data.customerId
        }
      });

      // 5. Create Inventory Transaction
      await tx.inventoryTransaction.create({
        data: {
          product_unit_id: data.productUnitId,
          transaction_type: 'SOLD',
          from_owner_type: 'SHOP',
          from_owner_id: data.shopId,
          to_owner_type: 'CUSTOMER',
          to_owner_id: data.customerId,
          performed_by_user_id: data.sellerId,
          notes: `Sold to customer ${data.customerId} for ${data.salePrice}`
        }
      });

      // 6. Create Sale record
      sale = await tx.sale.create({
        data: {
          product_unit_id: data.productUnitId,
          customer_id: data.customerId,
          shop_id: data.shopId,
          sold_by_user_id: data.sellerId,
          sale_price: data.salePrice
        }
      });
    } else if (data.productId && data.quantity) {
      // Non-Serialized Flow
      const inventory = await tx.shopInventoryAggregate.findUnique({
        where: { shop_id_product_id: { shop_id: data.shopId, product_id: data.productId } }
      });
      if (!inventory || inventory.quantity < data.quantity) {
        throw new Error('Not enough bulk inventory in shop');
      }

      await tx.shopInventoryAggregate.update({
        where: { id: inventory.id },
        data: { quantity: inventory.quantity - data.quantity }
      });

      sale = await tx.sale.create({
        data: {
          product_id: data.productId,
          quantity: data.quantity,
          customer_id: data.customerId,
          shop_id: data.shopId,
          sold_by_user_id: data.sellerId,
          sale_price: data.salePrice
        }
      });

      await tx.inventoryTransaction.create({
        data: {
          product_id: data.productId,
          quantity: data.quantity,
          transaction_type: 'SOLD',
          from_owner_type: 'SHOP',
          from_owner_id: data.shopId,
          to_owner_type: 'CUSTOMER',
          to_owner_id: data.customerId,
          performed_by_user_id: data.sellerId,
          notes: `Bulk sale of ${data.quantity} to customer ${data.customerId} for ${data.salePrice}`
        }
      });
    } else {
      throw new Error('Either productUnitId or (productId and quantity) is required');
    }

    // 7. Audit Log
    await auditLogRepo.createAuditLog(tx, {
      userId: data.sellerId,
      entityName: 'Sale',
      entityId: sale.id,
      action: 'COMPLETED',
      newData: sale
    });

    return sale;
  });
};

module.exports = {
  executeSale
};
