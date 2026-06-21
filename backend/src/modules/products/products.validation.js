const { z } = require('zod');

/**
 * Validation schema for creating a new category
 */
const createCategorySchema = z.object({
  body: z.object({
    name: z.string().min(1, 'Category name is required').max(100, 'Category name is too long')
  })
});

/**
 * Validation schema for creating a new product name
 */
const createProductNameSchema = z.object({
  body: z.object({
    category_id: z.number().int().positive('Category ID must be a positive integer'),
    name: z.string().min(1, 'Product name is required').max(100, 'Product name is too long')
  })
});

/**
 * Validation schema for creating a new product model
 */
const createProductModelSchema = z.object({
  body: z.object({
    product_name_id: z.number().int().positive('Product Name ID must be a positive integer'),
    name: z.string().min(1, 'Model name is required').max(100, 'Model name is too long')
  })
});

/**
 * Validation schema for creating a product
 */
const createProductSchema = z.object({
  body: z.object({
    category_id: z.number().int().positive('Category ID is required'),
    product_name_id: z.number().int().positive('Product Name ID is required'),
    product_model_id: z.number().int().positive('Product Model ID is required'),
    min_price: z.number().positive('Min price must be a positive number'),
    on_sale: z.boolean().optional().default(false),
    offer_price: z.number().positive('Offer price must be a positive number').optional().nullable(),
    min_quantity: z.number().int().positive('Min quantity must be a positive integer').optional().default(1)
  })
});

module.exports = {
  createCategorySchema,
  createProductNameSchema,
  createProductModelSchema,
  createProductSchema
};
