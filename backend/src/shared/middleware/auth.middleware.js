const jwt = require('jsonwebtoken');
const { JWT_SECRET } = require('../../config/env');
const { errorResponse } = require('../utils/response');
const { isAdmin, isSeller } = require('../utils/role.util');
const { prisma } = require('../../config/db');

const authenticate = async (req, res, next) => {
  // Check for custom headers first
  let token = req.headers['auth_key'] || req.headers['auth-key'];
  
  // Fallback to standard Bearer token if auth-key header isn't used directly
  if (!token && req.headers.authorization && req.headers.authorization.startsWith('Bearer ')) {
    token = req.headers.authorization.split(' ')[1];
  }

  const authId = req.headers['authid'] || req.headers['auth_id'] || req.headers['auth-id'];

  if (!token || !authId) {
    return errorResponse(res, 401, 'Unauthorized: Both auth-id and auth-key headers are required');
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);

    // Decode auth-id (Base64) to verify it belongs to the user
    const decodedAuthIdStr = Buffer.from(authId, 'base64').toString('ascii');
    const [dbId] = decodedAuthIdStr.split(':');

    if (String(decoded.id) !== String(dbId)) {
      return errorResponse(res, 401, 'Unauthorized: auth-id does not match the auth-key');
    }
    
    // Validate user in the database
    let userFromDb = await prisma.user.findUnique({
      where: { userId: String(decoded.userId) }
    });

    // In case the JWT used the numeric id instead of the string userId
    if (!userFromDb && !isNaN(decoded.userId)) {
      userFromDb = await prisma.user.findUnique({
        where: { id: BigInt(decoded.userId) }
      });
    }

    if (!userFromDb) {
      return errorResponse(res, 401, 'Unauthorized: User does not exist');
    }

    req.user = decoded; // { userId, role, shopId, iat, exp }
    
    // Overwrite the role with the database role to be secure
    req.user.role = userFromDb.role; 
    
    // Attach role checking methods directly to the user object for convenience
    req.user.isAdmin = () => isAdmin(req.user);
    req.user.isSeller = () => isSeller(req.user);

    next();
  } catch (err) {
    return errorResponse(res, 401, 'Unauthorized: Invalid token');
  }
};

module.exports = { authenticate };
