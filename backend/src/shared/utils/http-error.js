/**
 * App error with HTTP status for controllers / global handler.
 * @param {number} statusCode
 * @param {string} message
 * @param {object} [meta] optional payload (e.g. geofence details)
 */
function httpError(statusCode, message, meta) {
  const err = new Error(message);
  err.statusCode = statusCode;
  if (meta != null) err.meta = meta;
  return err;
}

module.exports = { httpError };
