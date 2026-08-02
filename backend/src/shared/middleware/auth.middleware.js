const jwt = require('jsonwebtoken');
const { JWT_SECRET } = require('../../config/env');
const { errorResponse } = require('../utils/response');
const { isAdmin, isSeller, isEmployee } = require('../utils/role.util');
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

    // Load user + location + employee role from DB (source of truth)
    let userFromDb = await prisma.user.findFirst({
      where: { userId: String(decoded.userId) },
      include: {
        location: {
          select: { id: true, code: true, name: true, type: true, isActive: true },
        },
        employeeRole: {
          select: { id: true, name: true, description: true },
        },
      },
    });

    // In case the JWT used the numeric id instead of the string userId
    if (!userFromDb && decoded.userId != null && !isNaN(decoded.userId)) {
      userFromDb = await prisma.user.findFirst({
        where: { id: BigInt(decoded.userId) },
        include: {
          location: {
            select: { id: true, code: true, name: true, type: true, isActive: true },
          },
          employeeRole: {
            select: { id: true, name: true, description: true },
          },
        },
      });
    }

    if (!userFromDb) {
      return errorResponse(res, 401, 'Unauthorized: User does not exist');
    }

    if (!userFromDb.isActive) {
      return errorResponse(res, 403, 'Unauthorized: Account inactive');
    }

    // Build req.user from DB (not trusted client/JWT claims alone)
    req.user = {
      id: Number(userFromDb.id),
      userId: userFromDb.userId,
      userName: userFromDb.userName,
      role: userFromDb.role,
      locationId: userFromDb.locationId != null ? Number(userFromDb.locationId) : null,
      employeeRoleId: userFromDb.employeeRoleId != null ? Number(userFromDb.employeeRoleId) : null,
      location: userFromDb.location
        ? {
            id: Number(userFromDb.location.id),
            code: userFromDb.location.code,
            name: userFromDb.location.name,
            type: userFromDb.location.type,
            is_active: userFromDb.location.isActive,
          }
        : null,
      employeeRole: userFromDb.employeeRole
        ? {
            id: Number(userFromDb.employeeRole.id),
            name: userFromDb.employeeRole.name,
            description: userFromDb.employeeRole.description,
          }
        : null,
      jti: decoded.jti,
      sessionId: decoded.sessionId != null ? Number(decoded.sessionId) : null,
    };

    req.user.isAdmin = () => isAdmin(req.user);
    req.user.isSeller = () => isSeller(req.user);
    req.user.isEmployee = () => isEmployee(req.user);

    next();
  } catch (err) {
    return errorResponse(res, 401, 'Unauthorized: Invalid token');
  }
};

module.exports = { authenticate };
