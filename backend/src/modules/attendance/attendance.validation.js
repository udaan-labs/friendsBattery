const { z } = require('zod');

const optionalGeoBody = z.object({
  body: z
    .object({
      lat: z.coerce.number().min(-90).max(90).optional().nullable(),
      lng: z.coerce.number().min(-180).max(180).optional().nullable(),
      address: z.string().max(1000).optional().nullable(),
    })
    .optional()
    .default({}),
});

const checkInSchema = optionalGeoBody;
const checkOutSchema = optionalGeoBody;

module.exports = {
  checkInSchema,
  checkOutSchema,
};
