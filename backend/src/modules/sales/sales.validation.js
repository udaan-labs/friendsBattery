const { z } = require('zod');

/**
 * Validation schema for creating a sale.
 * Ownership/location enforced in service (actor from JWT, not body).
 */
const createSaleSchema = z.object({
  body: z
    .object({
      product_name_id: z.number().int().positive('Product Name ID must be a valid positive integer'),
      product_model_id: z.number().int().positive('Product Model ID must be a valid positive integer'),
      serial_number: z
        .string()
        .trim()
        .min(1, 'Serial number is required')
        .max(100, 'Serial number is too long'),
      customer_name: z
        .string()
        .trim()
        .min(1, 'Customer name is required')
        .max(100, 'Customer name is too long'),
      customer_number: z
        .string()
        .trim()
        .regex(/^\d{10}$/, 'Customer mobile number must be exactly 10 digits'),
      vehicle_number: z
        .string()
        .trim()
        .max(50, 'Vehicle number is too long')
        .optional()
        .nullable()
        .transform((v) => (v == null || v === '' ? null : v)),
      sell_price: z
        .number()
        .positive('Sell price must be a positive number')
        .max(9_999_999_999.99, 'Sell price is too large'),
      /** NORMAL (default) | SCRAP | MECHANIC */
      sale_type: z.enum(['NORMAL', 'SCRAP', 'MECHANIC']).optional().default('NORMAL'),
      scrap_serial: z
        .string()
        .trim()
        .max(100)
        .optional()
        .nullable()
        .transform((v) => (v == null || v === '' ? null : v)),
    })
    .superRefine((body, ctx) => {
      if (body.sale_type === 'SCRAP' && !body.scrap_serial) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: 'Scrap serial is required for scrap battery sales',
          path: ['scrap_serial'],
        });
      }
    }),
});

/** Rent unit out with deposit. */
const createRentSchema = z.object({
  body: z.object({
    serial_number: z
      .string()
      .trim()
      .min(1, 'Serial number is required')
      .max(100),
    customer_name: z
      .string()
      .trim()
      .min(1, 'Customer name is required')
      .max(100),
    customer_number: z
      .string()
      .trim()
      .regex(/^\d{10}$/, 'Customer mobile number must be exactly 10 digits'),
    deposit: z
      .number()
      .positive('Deposit must be a positive number')
      .max(9_999_999_999.99),
  }),
});

/** Return rented unit: fee from deposit, refund rest. */
const returnRentSchema = z.object({
  body: z.object({
    serial_number: z
      .string()
      .trim()
      .min(1, 'Serial number is required')
      .max(100),
    rent_fee: z
      .number()
      .min(0, 'Rent fee cannot be negative')
      .max(9_999_999_999.99),
  }),
});

/** Service bill — no stock move. Defaults: 2W ₹30 · 4W ₹70 · inverter ₹1000 (UI prefills). */
const createServiceBillSchema = z.object({
  body: z
    .object({
      service_type: z.enum([
        'BATTERY_CHECK_2W',
        'BATTERY_CHECK_4W',
        'BATTERY_CHARGING',
        'JUMPSTART',
        'INVERTER_SERVICE',
      ]),
      amount: z
        .number()
        .positive('Amount must be a positive number')
        .max(9_999_999_999.99, 'Amount is too large'),
      customer_name: z
        .string()
        .trim()
        .min(1, 'Customer name is required')
        .max(100, 'Customer name is too long'),
      customer_number: z
        .string()
        .trim()
        .regex(/^\d{10}$/, 'Customer mobile number must be exactly 10 digits'),
      vehicle_number: z
        .string()
        .trim()
        .max(50)
        .optional()
        .nullable()
        .transform((v) => (v == null || v === '' ? null : v)),
      place: z
        .string()
        .trim()
        .max(200)
        .optional()
        .nullable()
        .transform((v) => (v == null || v === '' ? null : v)),
    })
    .superRefine((body, ctx) => {
      if (body.service_type === 'JUMPSTART' && !body.place) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: 'Place is required for jumpstart',
          path: ['place'],
        });
      }
    }),
});

/**
 * Validation schema for viewing a single sale
 */
const viewSaleSchema = z.object({
  params: z.object({
    transactionId: z.string().regex(/^\d+$/, 'Transaction ID must be numeric').transform(Number)
  })
});

const salesHistorySchema = z.object({
  query: z.object({
    page: z.string().optional().default('1').transform(Number),
    limit: z.string().optional().default('10').transform(Number),
    searchCustomer: z.string().optional(),
    searchSerial: z.string().optional(),
    fromDate: z.string().optional(),
    toDate: z.string().optional(),
    filter: z.enum(['today', 'date', 'all']).optional(),
    date: z.string().optional(),
  }),
});

/**
 * Validation schema for Admin sales history
 * Supports search by customer name, seller name/shop, product name, serial number
 * Filters by sellerId, date range, shipment status
 */
const adminSalesHistorySchema = z.object({
  query: z.object({
    page: z.string().optional().default('1').transform(Number),
    limit: z.string().optional().default('10').transform(Number),
    search: z.string().optional(),
    sellerId: z.string().regex(/^\d+$/, 'Seller ID must be numeric').transform(Number).optional(),
    fromDate: z.string().optional(),
    toDate: z.string().optional(),
    shipmentStatus: z.enum(['PENDING', 'ACCEPTED', 'REJECTED']).optional(),
  }),
});

module.exports = {
  createSaleSchema,
  createServiceBillSchema,
  createRentSchema,
  returnRentSchema,
  viewSaleSchema,
  salesHistorySchema,
  adminSalesHistorySchema,
};
