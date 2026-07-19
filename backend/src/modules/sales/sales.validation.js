const { z } = require('zod');

/**
 * Validation schema for creating a sale
 */
const createSaleSchema = z.object({
  body: z.object({
    product_name_id: z.number().int().positive('Product Name ID must be a valid positive integer'),
    product_model_id: z.number().int().positive('Product Model ID must be a valid positive integer'),
    serial_number: z.string().min(1, 'Serial number is required').max(100, 'Serial number is too long'),
    customer_name: z.string().min(1, 'Customer name is required').max(100, 'Customer name is too long'),
    customer_number: z.string().length(10, 'Customer mobile number must be exactly 10 digits').regex(/^\d{10}$/, 'Customer mobile number must contain only digits'),
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
    page: z.string().optional().default('1').transform(Number),
    limit: z.string().optional().default('10').transform(Number),
    searchCustomer: z.string().optional(),
    searchSerial: z.string().optional(),
    fromDate: z.string().optional(),
    toDate: z.string().optional(),
  }),
});

/**
 * Validation schema for Admin sales history
 * Supports search by customer name, seller name/shop, product name, serial number
 * Filters by sellerId, date range, shipment status
 */
const adminSalesHistorySchema = z.object({
  query: z.object({
    page: z.string().optional().default('1').transform(Number),
    limit: z.string().optional().default('10').transform(Number),
    search: z.string().optional(),
    sellerId: z.string().regex(/^\d+$/, 'Seller ID must be numeric').transform(Number).optional(),
    fromDate: z.string().optional(),
    toDate: z.string().optional(),
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
