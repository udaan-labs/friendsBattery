const { z } = require('zod');

/** GPS body for check-in / check-out (lat/lng or latitude/longitude). */
const geoBodySchema = z.object({
  body: z
    .object({
      lat: z.coerce.number().min(-90).max(90).optional().nullable(),
      lng: z.coerce.number().min(-180).max(180).optional().nullable(),
      latitude: z.coerce.number().min(-90).max(90).optional().nullable(),
      longitude: z.coerce.number().min(-180).max(180).optional().nullable(),
      accuracy: z.coerce.number().min(0).max(10000).optional().nullable(),
      timestamp: z.union([z.string(), z.coerce.date()]).optional().nullable(),
      address: z.string().max(1000).optional().nullable(),
    })
    .refine(
      (b) =>
        (b.lat != null && b.lng != null) ||
        (b.latitude != null && b.longitude != null),
      { message: 'latitude/longitude (or lat/lng) are required' }
    ),
});

const checkInSchema = geoBodySchema;
const checkOutSchema = geoBodySchema;

module.exports = {
  checkInSchema,
  checkOutSchema,
};
