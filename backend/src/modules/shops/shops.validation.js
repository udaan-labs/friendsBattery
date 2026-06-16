const { z } = require('zod');

const createShopSchema = z.object({
  body: z.object({
    shopName: z.string().min(1, 'Shop name is required'),
    ownerName: z.string().min(1, 'Owner name is required'),
    mobile: z.string().min(10, 'Valid mobile number is required'),
    address: z.string().min(1, 'Address is required')
  })
});

const updateShopSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid shop ID format')
  }),
  body: z.object({
    shopName: z.string().min(1, 'Shop name is required').optional(),
    ownerName: z.string().min(1, 'Owner name is required').optional(),
    mobile: z.string().min(10, 'Valid mobile number is required').optional(),
    address: z.string().min(1, 'Address is required').optional()
  })
});

const shopIdParamSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid shop ID format')
  })
});

module.exports = {
  createShopSchema,
  updateShopSchema,
  shopIdParamSchema
};
