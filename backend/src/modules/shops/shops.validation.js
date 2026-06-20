const { z } = require('zod');

/**
 * Shops Validation
 *
 * Defines Zod schemas for all shops endpoints.
 */

// Schema for GET /shops/sellers/:sellerId
const viewSellerSchema = z.object({
  params: z.object({
    sellerId: z.string().regex(/^\d+$/).transform(Number)
  })
});

module.exports = {
  viewSellerSchema
};
