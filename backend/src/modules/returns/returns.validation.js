const { z } = require('zod');

const createReturnSchema = z.object({
  body: z.object({
    saleId: z.string().uuid('Invalid sale ID'),
    productUnitId: z.string().uuid('Invalid product unit ID'),
    returnReason: z.string().min(5, 'Return reason must be detailed')
  })
});

const updateReturnStatusSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid return ID')
  }),
  body: z.object({
    status: z.enum(['PENDING', 'UNDER_INSPECTION', 'APPROVED', 'REJECTED', 'REPLACED', 'REPAIRED', 'SCRAPPED'])
  })
});

const replaceReturnSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid return ID')
  }),
  body: z.object({
    newProductUnitId: z.string().uuid('Invalid new product unit ID')
  })
});

module.exports = {
  createReturnSchema,
  updateReturnStatusSchema,
  replaceReturnSchema
};
