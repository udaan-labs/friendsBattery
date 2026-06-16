const { z } = require('zod');

const createStockRequestSchema = z.object({
  body: z.object({
    items: z.array(z.object({
      productId: z.string().uuid('Invalid product ID'),
      quantity: z.number().int().min(1, 'Quantity must be at least 1')
    })).min(1, 'At least one item is required')
  })
});

const updateStockRequestSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid stock request ID')
  }),
  body: z.object({
    status: z.enum(['APPROVED', 'REJECTED']),
    fulfilledUnits: z.array(z.string().uuid('Invalid product unit ID')).optional()
  })
});

module.exports = {
  createStockRequestSchema,
  updateStockRequestSchema
};
