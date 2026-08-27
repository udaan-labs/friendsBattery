const { z } = require('zod');

const MSG =
  'Password must be at least 8 characters, with one uppercase letter and one special character';

const strongPassword = z
  .string()
  .min(8, MSG)
  .max(100)
  .regex(/[A-Z]/, MSG)
  .regex(/[^A-Za-z0-9]/, MSG);

module.exports = { strongPassword };
