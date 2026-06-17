const jwt = require('jsonwebtoken');
const { JWT_SECRET } = require('../../config/env');
const { errorResponse } = require('../utils/response');
const { isAdmin, isSeller } = require('../utils/role.util');
const { prisma } = require('../../config/db');

const authenticate = async (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return errorResponse(res, 401, 'Unauthorized: No token provided');
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    
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
