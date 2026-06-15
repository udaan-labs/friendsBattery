const jwt = require('jsonwebtoken');
const { JWT_SECRET } = require('../../config/env');
const { errorResponse } = require('../utils/response');

const authenticate = (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return errorResponse(res, 401, 'Unauthorized: No token provided');
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded; // { userId, role, shopId, iat, exp }
    next();
  } catch (err) {
    return errorResponse(res, 401, 'Unauthorized: Invalid token');
  }
};

module.exports = { authenticate };
