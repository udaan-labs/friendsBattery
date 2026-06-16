const { errorResponse } = require('../utils/response');
const { logError } = require('../../config/logger');

const globalErrorHandler = (err, req, res, next) => {
  logError(err.message, err.stack);
  
  const statusCode = err.statusCode || 500;
  const message = err.message || 'Internal Server Error';
  
  return errorResponse(res, statusCode, message);
};

const notFoundHandler = (req, res, next) => {
  return errorResponse(res, 404, `Route ${req.originalUrl} not found`);
};

module.exports = {
  globalErrorHandler,
  notFoundHandler
};
