const { z } = require('zod');

/**
 * Validation schema for creating a new product name
 */
const createProductNameSchema = z.object({
  body: z.object({
    name: z.string().trim().min(1, 'Product name is required').max(100, 'Product name is too long')
  })
});

/**
 * Validation schema for creating a new product model
 */
const createProductModelSchema = z.object({
  body: z.object({
    product_name_id: z.number().int().positive('Product Name ID must be a positive integer'),
    name: z.string().trim().min(1, 'Model name is required').max(100, 'Model name is too long')
  })
});

/**
 * Validation schema for creating a product
 */
const createProductSchema = z.object({
  body: z.object({
    product_name_id: z.number().int().positive('Product Name ID is required'),
    product_model_id: z.number().int().positive('Product Model ID is required'),
    min_price: z.number().positive('Min price must be a positive number'),
    on_sale: z.boolean().optional().default(false),
    offer_price: z.number().positive('Offer price must be a positive number').optional().nullable(),
    min_unit_count_admin: z.number().int().min(0, 'Min unit count admin cannot be negative'),
    min_unit_count_seller: z.number().int().min(0, 'Min unit count seller cannot be negative')
  })
});

/**
 * Validation schema for getting product models by product name
 */
const getProductModelsRequest = z.object({
  body: z.object({
    product_name_id: z.number().int().positive('Product Name ID is required')
  })
});

/**
 * Validation schema for getting products by filters
 */
const getProductsRequest = z.object({
  body: z.object({
    product_name_id: z.number().int().positive('Product Name ID is required'),
    product_model_id: z.number().int().positive('Product Model ID is required')
  })
});

module.exports = {
  createProductNameSchema,
  createProductModelSchema,
  createProductSchema,
  getProductModelsRequest,
  getProductsRequest
};
