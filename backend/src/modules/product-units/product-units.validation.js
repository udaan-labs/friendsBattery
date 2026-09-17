const { z } = require('zod');

const verifyProductSchema = z.object({
  body: z.object({
    identifier: z.string().trim().min(1, 'Identifier is required'),
  }),
});

module.exports = { verifyProductSchema };
