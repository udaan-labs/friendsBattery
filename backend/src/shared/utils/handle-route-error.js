const { errorResponse } = require('./response');

/**
 * Shared controller catch: forward service httpError status, else generic 500.
 * Matches previous controller behavior (never leak unexpected err.message as 500 body).
 */
function handleRouteError(res, error, logLabel = 'Error:') {
  if (error && error.statusCode) {
    return errorResponse(res, error.statusCode, error.message);
  }
  console.error(logLabel, error);
  return errorResponse(res, 500, 'Internal server error');
}

module.exports = { handleRouteError };
