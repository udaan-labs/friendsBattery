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

module.exports = {
  createSaleSchema,
  viewSaleSchema,
  customerSalesSchema
};
