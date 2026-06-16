const { z } = require('zod');

const createCustomerSchema = z.object({
  body: z.object({
    fullName: z.string().min(1, 'Full name is required'),
    mobile: z.string().min(10, 'Valid mobile number is required'),
    vehicleNumber: z.string().optional().nullable(),
    address: z.string().optional().nullable()
  })
});

const updateCustomerSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid customer ID format')
  }),
  body: z.object({
    fullName: z.string().min(1, 'Full name is required').optional(),
    mobile: z.string().min(10, 'Valid mobile number is required').optional(),
    vehicleNumber: z.string().optional().nullable(),
    address: z.string().optional().nullable()
  })
});

const getCustomersSchema = z.object({
  query: z.object({
    mobile: z.string().optional(),
    vehicleNumber: z.string().optional()
  })
});

const customerIdParamSchema = z.object({
  params: z.object({
    id: z.string().uuid('Invalid customer ID format')
  })
});

module.exports = {
  createCustomerSchema,
  updateCustomerSchema,
  getCustomersSchema,
  customerIdParamSchema
};
