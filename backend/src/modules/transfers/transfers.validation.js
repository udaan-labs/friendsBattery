const { z } = require('zod');

/**
 * Validation schema for creating a new shipment (transfer)
 * Ensures seller_id is valid and items array contains valid product entries
 */
const createTransferSchema = z.object({
  body: z.object({
    seller_id: z.number().int().positive('Seller ID must be a positive integer'),
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

/**
 * Validation schema for viewing a single shipment
 */
const viewTransferSchema = z.object({
  params: z.object({
    shipmentId: z.string().regex(/^\d+$/, 'Shipment ID must be numeric').transform(Number)
  })
});

/**
 * Validation schema for receiving a shipment
 */
const receiveTransferSchema = z.object({
  params: z.object({
    shipmentId: z.string().regex(/^\d+$/, 'Shipment ID must be numeric').transform(Number)
  })
});

/**
 * Validation schema for cancelling a shipment
 */
const cancelTransferSchema = z.object({
  params: z.object({
    shipmentId: z.string().regex(/^\d+$/, 'Shipment ID must be numeric').transform(Number)
  })
});

module.exports = {
  createTransferSchema,
  viewTransferSchema,
  receiveTransferSchema,
  cancelTransferSchema
};
