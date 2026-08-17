const { z } = require('zod');
const { strongPassword } = require('../../shared/utils/password');

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

// Schema for PATCH /shops/employees/:employeeId/location
const transferEmployeeSchema = z.object({
  params: z.object({
    employeeId: z.string().regex(/^\d+$/).transform(Number),
  }),
  body: z.object({
    location_id: z.coerce.number().int().positive(),
  }),
});

// Schema for POST /shops/employees
const createEmployeeSchema = z.object({
  body: z.object({
    user_id: z.string().max(50).optional(),
    username: z.string().min(1).max(100),
    user_number: z.string().regex(/^\d{10}$/, 'Mobile number must be exactly 10 digits'),
    password: strongPassword,
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
        .max(50)
        .transform((s) => s.trim().toUpperCase())
        .optional()
        .nullable(),
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
      warehouse_id: z.coerce.number().int().positive().optional().nullable(),
    })
    .refine(
      (b) =>
        (b.latitude == null && b.longitude == null) ||
        (b.latitude != null && b.longitude != null),
      { message: 'latitude and longitude must both be provided' }
    )
    .refine((b) => b.type !== 'SHOP' || b.warehouse_id != null, {
      message: 'warehouse_id is required for shops',
      path: ['warehouse_id'],
    })
    .refine((b) => b.type !== 'WAREHOUSE' || b.warehouse_id == null, {
      message: 'warehouse cannot have a parent warehouse',
      path: ['warehouse_id'],
    }),
});

// Schema for PATCH /shops/locations/:locationId
const updateLocationSchema = z.object({
  params: z.object({
    locationId: z.string().regex(/^\d+$/).transform(Number),
  }),
  body: z
    .object({
      name: z.string().min(1).max(150).transform((s) => s.trim()).optional(),
      address: z.string().max(2000).optional().nullable(),
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
  transferEmployeeSchema,
  createEmployeeSchema,
  listLocationsSchema,
  createLocationSchema,
  updateLocationSchema,
};
