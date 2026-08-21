const { z } = require('zod');

/**
 * Inventory Validation
 *
 * Defines Zod schemas for all inventory endpoints.
 */

// Schema for GET /inventory
const getInventorySchema = z.object({
  query: z.object({
    search: z.string().optional(),
    page: z.string().regex(/^\d+$/).transform(Number).refine(val => val > 0, { message: 'Page must be positive' }).optional(),
    limit: z.string().regex(/^\d+$/).transform(Number).refine(val => val > 0, { message: 'Limit must be positive' }).optional(),
    includeOutOfStock: z.string().optional(),
    /** SA/Admin: physical units at this location. Seller/Employee: ignored. */
    location_id: z.string().regex(/^\d+$/).transform(Number).optional(),
  })
});

// Schema for GET /inventory/:productId
const getInventoryItemSchema = z.object({
  params: z.object({
    productId: z.string().regex(/^\d+$/).transform(Number)
  })
});

// Schema for PATCH /inventory/adjust
const adjustInventorySchema = z.object({
  body: z.object({
    product_id: z.number().int().positive({ message: 'Invalid product id' }),
    user_id: z.number().int().positive({ message: 'Invalid user id' }),
    adjustment_quantity: z.number().int({ message: 'Invalid quantity' }) // Can be negative or positive
  })
});

// Schema for POST /inventory/transfer
const transferInventorySchema = z.object({
  body: z.object({
    seller_id: z.number().int().positive({ message: 'Invalid seller id' }),
    products: z.array(
      z.object({
        product_id: z.number().int().positive({ message: 'Invalid product id' }),
        quantity: z.number().int().positive({ message: 'Invalid quantity' })
      })
    ).min(1, { message: 'Empty products array not allowed' })
  })
});

// Schema for GET /inventory/history
const getHistorySchema = z.object({
  query: z.object({
    from_date: z.string().optional(),
    to_date: z.string().optional(),
    product_id: z.string().regex(/^\d+$/).transform(Number).optional(),
    seller_id: z.string().regex(/^\d+$/).transform(Number).optional(),
    page: z.string().regex(/^\d+$/).transform(Number).refine(val => val > 0, { message: 'Page must be positive' }).optional(),
    limit: z.string().regex(/^\d+$/).transform(Number).refine(val => val > 0, { message: 'Limit must be positive' }).optional(),
  })
});

// Schema for POST /inventory/update-stock
const updateStockSchema = z.object({
  body: z.object({
    productNameId: z.number().int().positive({ message: 'Invalid product name id' }),
    productModelId: z.number().int().positive({ message: 'Invalid product model id' }),
    quantity: z.number().int().positive({ message: 'Quantity must be a positive integer' }).optional(),
    serial_numbers: z
      .array(z.string().trim().min(1, { message: 'Serial number cannot be empty' }).max(100))
      .min(1)
      .max(500)
      .optional(),
    minSellPrice: z.number().nonnegative({ message: 'minSellPrice must be greater than or equal to 0' }).optional(),
    minUnitCountAdmin: z.number().int().nonnegative().optional(),
    minUnitCountSeller: z.number().int().nonnegative().optional(),
    onSale: z.boolean().optional(),
    /** Target warehouse (or any active location). Omit → actor location / default WH. */
    location_id: z.number().int().positive().optional().nullable(),
  }).superRefine((data, ctx) => {
    if (data.serial_numbers && data.quantity != null) {
      ctx.addIssue({
        code: 'custom',
        path: ['serial_numbers'],
        message: 'Send serial_numbers or quantity, not both',
      });
    }
    if (data.serial_numbers) {
      const set = new Set(data.serial_numbers);
      if (set.size !== data.serial_numbers.length) {
        ctx.addIssue({
          code: 'custom',
          path: ['serial_numbers'],
          message: 'Duplicate serial numbers in the request',
        });
      }
    }
  })
});

// Schema for GET /inventory/product-details
const getProductDetailsSchema = z.object({
  query: z.object({
    product_name_id: z.string().regex(/^\d+$/).transform(Number),
    product_model_id: z.string().regex(/^\d+$/).transform(Number),
  })
});

// Schema for GET /inventory/available-serials
const getAvailableSerialsSchema = z.object({
  query: z.object({
    product_name_id: z.string().regex(/^\d+$/).transform(Number),
    product_model_id: z.string().regex(/^\d+$/).transform(Number),
  })
});

// Schema for GET /inventory/details
const getInventoryDetailsSchema = z.object({
  query: z.object({
    product_name_id: z.string().regex(/^\d+$/).transform(Number).optional(),
    search: z.string().optional(),
    page: z.string().regex(/^\d+$/).transform(Number).refine(val => val > 0, { message: 'Page must be positive' }).optional(),
    limit: z.string().regex(/^\d+$/).transform(Number).refine(val => val > 0, { message: 'Limit must be positive' }).optional(),
  })
});

module.exports = {
  getInventorySchema,
  getInventoryItemSchema,
  adjustInventorySchema,
  transferInventorySchema,
  getHistorySchema,
  updateStockSchema,
  getProductDetailsSchema,
  getAvailableSerialsSchema,
  getInventoryDetailsSchema
};
