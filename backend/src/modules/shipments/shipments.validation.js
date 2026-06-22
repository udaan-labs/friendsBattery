const { z } = require('zod');

const createShipmentSchema = z.object({
  body: z.object({
    sellerId: z.number().int().positive('Seller ID must be a positive integer'),
    items: z
      .array(
        z.object({
          productCategoryId: z.number().int().positive('Category ID must be a positive integer'),
          productNameId: z.number().int().positive('Product Name ID must be a positive integer'),
          productModelId: z.number().int().positive('Product Model ID must be a positive integer'),
          quantity: z.number().int().positive('Quantity must be a positive integer')
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
