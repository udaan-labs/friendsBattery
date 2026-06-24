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
    sort: z.string().optional(),
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
    productCategoryId: z.number().int().positive({ message: 'Invalid product category id' }),
    productNameId: z.number().int().positive({ message: 'Invalid product name id' }),
    productModelId: z.number().int().positive({ message: 'Invalid product model id' }),
    quantity: z.number().int().positive({ message: 'Quantity must be greater than 0' }),
    minSellPrice: z.number().nonnegative({ message: 'minSellPrice must be greater than or equal to 0' }).optional()
  })
});

// Schema for GET /inventory/product-details
const getProductDetailsSchema = z.object({
  query: z.object({
    category_id: z.string().regex(/^\d+$/).transform(Number),
    product_name_id: z.string().regex(/^\d+$/).transform(Number),
    product_model_id: z.string().regex(/^\d+$/).transform(Number),
  })
});

// Schema for GET /inventory/available-serials
const getAvailableSerialsSchema = z.object({
  query: z.object({
    category_id: z.string().regex(/^\d+$/).transform(Number),
    product_name_id: z.string().regex(/^\d+$/).transform(Number),
    product_model_id: z.string().regex(/^\d+$/).transform(Number),
  })
});

// Schema for GET /inventory/details
const getInventoryDetailsSchema = z.object({
  query: z.object({
    category_id: z.string().regex(/^\d+$/).transform(Number).optional(),
    subcategory_id: z.string().regex(/^\d+$/).transform(Number).optional(),
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

