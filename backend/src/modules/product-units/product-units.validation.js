const { z } = require('zod');

const createProductUnitSchema = z.object({
  body: z.object({
    productId: z.string().uuid('Invalid product ID'),
    serialNumber: z.string().min(1, 'Serial number is required'),
    manufacturingDate: z.string().datetime().optional(),
    receivedDate: z.string().datetime().optional(),
    status: z.enum(['IN_WAREHOUSE', 'AT_SHOP', 'SOLD', 'RETURNED', 'UNDER_INSPECTION', 'REPLACED', 'SCRAPPED']).optional(),
    currentOwnerType: z.enum(['WHOLESALER', 'SHOP']),
    currentOwnerId: z.string().uuid('Invalid owner ID').optional().nullable()
  })
});

const updateProductUnitSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid product unit ID')
  }),
  body: z.object({
    status: z.enum(['IN_WAREHOUSE', 'AT_SHOP', 'SOLD', 'RETURNED', 'UNDER_INSPECTION', 'REPLACED', 'SCRAPPED']).optional(),
    currentOwnerType: z.enum(['WHOLESALER', 'SHOP']).optional(),
    currentOwnerId: z.string().uuid('Invalid owner ID').optional().nullable(),
    manufacturingDate: z.string().datetime().optional(),
    receivedDate: z.string().datetime().optional()
  })
});

const getProductUnitsSchema = z.object({
  query: z.object({
    page: z.string().regex(/^\d+$/).optional().transform(Number),
    limit: z.string().regex(/^\d+$/).optional().transform(Number),
    productId: z.string().uuid().optional(),
    serialNumber: z.string().optional(),
    status: z.enum(['IN_WAREHOUSE', 'AT_SHOP', 'SOLD', 'RETURNED', 'UNDER_INSPECTION', 'REPLACED', 'SCRAPPED']).optional(),
    currentOwnerId: z.string().uuid().optional()
  })
});

const productUnitIdParamSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid ID format')
  })
});

const serialNumberParamSchema = z.object({
  params: z.object({
    serialNumber: z.string().min(1, 'Serial number is required')
  })
});

module.exports = {
  createProductUnitSchema,
  updateProductUnitSchema,
  getProductUnitsSchema,
  productUnitIdParamSchema,
  serialNumberParamSchema
};
