const { errorResponse } = require('../utils/response');

/**
 * Generic request validation middleware
 *
 * Validates:
 * - req.body
 * - req.query
 * - req.params
 *
 * using the provided Zod schema.
 */
const validateRequest = (schema) => {
  return (req, res, next) => {
    try {
      // Parse and validate request data
      const parsed = schema.parse({
        body: req.body,
        query: req.query,
        params: req.params,
      });

      // Replace request values with validated/sanitized data
      req.body = parsed.body || req.body;
      req.query = parsed.query || req.query;
      req.params = parsed.params || req.params;

      return next();
    } catch (error) {
      // Handle Zod validation errors
      if (error.name === 'ZodError') {
        // Compatible with both Zod v3 and Zod v4
        const validationErrors = (error.issues || error.errors || []).map(
          (err) => ({
            path: err.path.join('.'),
            message: err.message,
          })
        );

        return errorResponse(
          res,
          400,
          'Validation failed',
          validationErrors
        );
      }

      // Pass unexpected errors to global error handler
      return next(error);
    }
  };
};

module.exports = {
  validateRequest,
};
