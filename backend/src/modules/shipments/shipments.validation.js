const { z } = require('zod');

const createShipmentSchema = z.object({
  body: z.object({
    sellerId: z.coerce.number().int().positive('Seller ID must be a positive integer'),
    items: z
      .array(
        z.object({
          product_name_id: z.coerce.number().int().positive('Product Name ID must be a positive integer'),
          product_model_id: z.coerce.number().int().positive('Product Model ID must be a positive integer'),
          serial_numbers: z
            .array(z.string().trim().min(1, 'Serial number cannot be empty'))
            .min(1, 'At least one serial number is required'),
          price_per_piece: z.coerce.number().nonnegative('Price per piece must be non-negative').optional(),
        })
      )
      .min(1, 'At least one item is required'),
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
