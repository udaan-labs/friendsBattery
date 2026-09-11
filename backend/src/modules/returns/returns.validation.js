const { z } = require('zod');

const processReturnSchema = z.object({
  body: z.object({
    serial_number: z.string().trim().min(1, 'serial_number is required').max(100),
    reason: z.string().trim().min(1, 'reason is required').max(500),
    /** Restock as sellable AVAILABLE (default) or DEFECTIVE scrap. */
    restock_as: z.enum(['AVAILABLE', 'DEFECTIVE']).optional(),
  }),
});

module.exports = { processReturnSchema };
