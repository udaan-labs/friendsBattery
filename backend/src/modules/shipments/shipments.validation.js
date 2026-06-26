const { z } = require('zod');

const createShipmentSchema = z.object({
  body: z.object({
    sellerId: z.number().int().positive('Seller ID must be a positive integer'),
    items: z
      .array(
        z.object({
          product_id: z.number().int().positive('Product ID must be a positive integer'),
          quantity: z.number().int().positive('Quantity must be a positive integer'),
          price_per_piece: z.number().positive('Price per piece must be a positive number')
        })
      )
      .min(1, 'At least one item is required')
  })
});

const acceptShipmentSchema = z.object({
  params: z.object({
    shipmentId: z.string().regex(/^\d+$/, 'Shipment ID must be numeric').transform(Number)
  })
});

module.exports = {
  createShipmentSchema,
  acceptShipmentSchema
};
