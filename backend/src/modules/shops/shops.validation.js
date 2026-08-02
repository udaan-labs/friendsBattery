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

// Schema for GET /shops/sellers/:sellerId/staff
const shopStaffSchema = z.object({
  params: z.object({
    sellerId: z.string().regex(/^\d+$/).transform(Number),
  }),
});

// Schema for GET /shops/employees/:employeeId
const viewEmployeeSchema = z.object({
  params: z.object({
    employeeId: z.string().regex(/^\d+$/).transform(Number),
  }),
  query: z
    .object({
      limit: z.coerce.number().int().min(1).max(100).optional(),
    })
    .optional()
    .default({}),
});

module.exports = {
  viewSellerSchema,
  shopStaffSchema,
  viewEmployeeSchema,
};
