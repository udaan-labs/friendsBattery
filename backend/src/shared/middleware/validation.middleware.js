const { errorResponse } = require('../utils/response');

const validateRequest = (schema) => {
  return (req, res, next) => {
    try {
      const parsed = schema.parse({
        body: req.body,
        query: req.query,
        params: req.params,
      });
      // Optionally attach parsed data back to req
      req.body = parsed.body || req.body;
      req.query = parsed.query || req.query;
      req.params = parsed.params || req.params;
      
      next();
    } catch (error) {
      if (error.name === 'ZodError') {
        const errors = error.errors.map(err => ({
          path: err.path.join('.'),
          message: err.message
        }));
        return errorResponse(res, 400, 'Validation failed', errors);
      }
      next(error);
    }
  };
};

module.exports = { validateRequest };
