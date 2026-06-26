const { z } = require('zod');

/**
 * Validation schema for creating a sale
 */
const createSaleSchema = z.object({
  body: z.object({
    product_id: z.number().int().positive('Product ID must be a valid positive integer'),
    serial_number: z.string().min(1, 'Serial number is required').max(100, 'Serial number is too long'),
    customer_name: z.string().min(1, 'Customer name is required').max(100, 'Customer name is too long'),
    customer_number: z.string().min(10, 'Customer number must be at least 10 characters').max(20, 'Customer number is too long'),
    vehicle_number: z.string().max(50, 'Vehicle number is too long').optional().nullable(),
    sell_price: z.number().positive('Sell price must be a positive number')
  })
});

/**
 * Validation schema for viewing a single sale
 */
const viewSaleSchema = z.object({
  params: z.object({
    transactionId: z.string().regex(/^\d+$/, 'Transaction ID must be numeric').transform(Number)
  })
});

/**
 * Validation schema for viewing customer sales
 */
const customerSalesSchema = z.object({
  params: z.object({
    mobile: z.string().min(10, 'Mobile number must be at least 10 characters')
  })
});

const salesHistorySchema = z.object({
  query: z.object({
    page: z.string().regex(/^\d+$/, 'Page must be numeric').transform(Number).default('1').transform(Number),
    limit: z.string().regex(/^\d+$/, 'Limit must be numeric').transform(Number).default('10').transform(Number),
    searchCustomer: z.string().optional(),
    searchSerial: z.string().optional(),
    fromDate: z.string().datetime().optional(),
    toDate: z.string().datetime().optional(),
  }),
});

/**
 * Validation schema for Admin sales history
 * Supports search by customer name, seller name/shop, product name, serial number
 * Filters by sellerId, date range, shipment status
 */
const adminSalesHistorySchema = z.object({
  query: z.object({
    page: z.string().regex(/^\d+$/, 'Page must be numeric').transform(Number).default('1').transform(Number),
    limit: z.string().regex(/^\d+$/, 'Limit must be numeric').transform(Number).default('10').transform(Number),
    search: z.string().optional(),
    sellerId: z.string().regex(/^\d+$/, 'Seller ID must be numeric').transform(Number).optional(),
    fromDate: z.string().datetime().optional(),
    toDate: z.string().datetime().optional(),
    shipmentStatus: z.enum(['PENDING', 'ACCEPTED', 'REJECTED']).optional(),
  }),
});

module.exports = {
  createSaleSchema,
  viewSaleSchema,
  customerSalesSchema,
  salesHistorySchema,
  adminSalesHistorySchema,
};
