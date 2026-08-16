const { z } = require('zod');

const listAccountsSchema = z.object({
  query: z.object({
    role: z.enum(['ADMIN', 'SELLER', 'EMPLOYEE']),
  }),
});

const setActiveSchema = z.object({
  params: z.object({
    id: z.string().regex(/^\d+$/).transform(Number),
  }),
  body: z.object({
    is_active: z.boolean(),
  }),
});

module.exports = { listAccountsSchema, setActiveSchema };
