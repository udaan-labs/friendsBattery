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

// Schema for GET /shops/locations/:locationId/staff
const locationStaffSchema = z.object({
  params: z.object({
    locationId: z.string().regex(/^\d+$/).transform(Number),
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

// Schema for POST /shops/employees
const createEmployeeSchema = z.object({
  body: z.object({
    user_id: z.string().min(1).max(50),
    username: z.string().min(1).max(100),
    user_number: z.string().regex(/^\d{10}$/, 'Mobile number must be exactly 10 digits'),
    password: z.string().min(6).max(100),
    employee_role_id: z.coerce.number().int().positive().optional().nullable(),
    /** Admin only — seller location is taken from the authenticated seller. */
    location_id: z.coerce.number().int().positive().optional().nullable(),
  }),
});

// Schema for GET /shops/locations?type=SHOP|WAREHOUSE
const listLocationsSchema = z.object({
  query: z
    .object({
      type: z.enum(['SHOP', 'WAREHOUSE']).optional(),
    })
    .optional()
    .default({}),
});

// Schema for POST /shops/locations
const createLocationSchema = z.object({
  body: z
    .object({
      code: z
        .string()
        .min(1)
        .max(50)
        .transform((s) => s.trim().toUpperCase()),
      name: z.string().min(1).max(150).transform((s) => s.trim()),
      type: z.enum(['SHOP', 'WAREHOUSE']),
      address: z.string().max(2000).optional().nullable(),
      phone: z.string().max(20).optional().nullable(),
      latitude: z.coerce.number().min(-90).max(90).optional().nullable(),
      longitude: z.coerce.number().min(-180).max(180).optional().nullable(),
      allowed_radius: z.coerce
        .number()
        .int()
        .min(10)
        .max(5000)
        .optional()
        .nullable(),
    })
    .refine(
      (b) =>
        (b.latitude == null && b.longitude == null) ||
        (b.latitude != null && b.longitude != null),
      { message: 'latitude and longitude must both be provided' }
    ),
});

module.exports = {
  viewSellerSchema,
  shopStaffSchema,
  locationStaffSchema,
  viewEmployeeSchema,
  createEmployeeSchema,
  listLocationsSchema,
  createLocationSchema,
};
