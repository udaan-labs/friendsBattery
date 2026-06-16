const { z } = require('zod');

const createSaleSchema = z.object({
  body: z.object({
    productUnitId: z.string().uuid('Invalid product unit ID'),
    customerId: z.string().uuid('Invalid customer ID'),
    salePrice: z.number().min(0, 'Sale price must be positive')
  })
});

module.exports = {
  createSaleSchema
};
