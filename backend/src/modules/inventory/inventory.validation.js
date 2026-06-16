const { z } = require('zod');

const transferSchema = z.object({
  body: z.object({
    productUnitId: z.string().uuid('Invalid product unit ID'),
    fromType: z.enum(['WHOLESALER', 'SHOP']),
    fromId: z.string().uuid('Invalid from ID').optional().nullable(),
    toType: z.enum(['WHOLESALER', 'SHOP']),
    toId: z.string().uuid('Invalid to ID').optional().nullable(),
    transactionType: z.enum(['RECEIVED', 'TRANSFERRED', 'SOLD', 'RETURNED', 'REPLACED', 'SCRAPPED']),
    notes: z.string().optional()
  })
});

const getHistorySchema = z.object({
  params: z.object({
    productUnitId: z.string().uuid('Invalid product unit ID')
  })
});

const getHistoryBySerialSchema = z.object({
  params: z.object({
    serialNumber: z.string().min(1, 'Serial number is required')
  })
});

module.exports = {
  transferSchema,
  getHistorySchema,
  getHistoryBySerialSchema
};
