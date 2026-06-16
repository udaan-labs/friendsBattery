const { z } = require('zod');

const createProductGroupSchema = z.object({
  body: z.object({
    name: z.string().min(1, 'Product group name is required')
  })
});

const createProductSubgroupSchema = z.object({
  body: z.object({
    product_group_id: z.string().uuid('Invalid product group ID'),
    name: z.string().min(1, 'Product subgroup name is required')
  })
});

const createProductSchema = z.object({
  body: z.object({
    product_subgroup_id: z.string().uuid('Invalid product subgroup ID'),
    brandName: z.string().min(1, 'Brand name is required'),
    modelName: z.string().min(1, 'Model name is required'),
    capacity: z.string().min(1, 'Capacity is required'),
    warrantyMonths: z.number().int().min(0, 'Warranty months must be positive'),
    minimumSellingPrice: z.number().positive('Minimum selling price must be positive'),
    is_serialized: z.boolean().optional()
  })
});

const updateProductSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid product ID')
  }),
  body: z.object({
    brandName: z.string().min(1).optional(),
    modelName: z.string().min(1).optional(),
    capacity: z.string().min(1).optional(),
    warrantyMonths: z.number().int().min(0).optional(),
    minimumSellingPrice: z.number().positive().optional(),
    is_serialized: z.boolean().optional()
  })
});

const productIdParamSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid ID format')
  })
});

module.exports = {
  createProductGroupSchema,
  createProductSubgroupSchema,
  createProductSchema,
  updateProductSchema,
  productIdParamSchema
};
