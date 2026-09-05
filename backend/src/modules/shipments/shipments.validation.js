const { z } = require('zod');

const createShipmentSchema = z.object({
  body: z.object({
    sellerId: z.coerce.number().int().positive('Seller ID must be a positive integer'),
    serial_numbers: z
      .array(z.string().trim().min(1, 'Serial number cannot be empty').max(100))
      .min(1, 'At least one serial number is required')
      .max(500)
      .refine(
        (serials) => new Set(serials.map((s) => s.toLowerCase())).size === serials.length,
        { message: 'Duplicate serial numbers in the transfer request' }
      ),
  }),
});

const acceptShipmentSchema = z.object({
  params: z.object({
    shipmentId: z.string().regex(/^\d+$/, 'Shipment ID must be numeric').transform(Number)
  })
});

const viewShipmentSchema = z.object({
  params: z.object({
    id: z.string().regex(/^\d+$/, 'Shipment ID must be numeric').transform(Number),
  }),
});

module.exports = {
  createShipmentSchema,
  acceptShipmentSchema,
  viewShipmentSchema,
};
