const jwt = require('jsonwebtoken');
const { JWT_SECRET } = require('../../config/env');
const { errorResponse } = require('../utils/response');
const { prisma } = require('../../config/db');
const ROLES = require('../constants/roles');

const authenticate = async (req, res, next) => {
  // Check for custom headers first
  let token = req.headers['auth_key'] || req.headers['auth-key'];

  // Fallback to standard Bearer token if auth-key header isn't used directly
  if (!token && req.headers.authorization && req.headers.authorization.startsWith('Bearer ')) {
    token = req.headers.authorization.split(' ')[1];
  }

  const authId = req.headers['authid'] || req.headers['auth_id'] || req.headers['auth-id'];

  if (!token) {
    return errorResponse(res, 401, 'Unauthorized: Authentication token is required');
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);

    if (authId) {
      const decodedAuthIdStr = Buffer.from(authId, 'base64').toString('ascii');
      const [dbId] = decodedAuthIdStr.split(':');

      if (String(decoded.id) !== String(dbId)) {
        return errorResponse(res, 401, 'Unauthorized: auth-id does not match the auth-key');
      }
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

    // De-verified accounts must not keep working on an old JWT
    if (!userFromDb.isVerified) {
      return errorResponse(res, 403, 'Unauthorized: Account not verified');
    }

    // EMPLOYEE: JWT dies when employee_sessions is closed (logout / revoke)
    if (userFromDb.role === ROLES.EMPLOYEE) {
      if (decoded.sessionId == null) {
        return errorResponse(res, 401, 'Unauthorized: Session required');
      }
      const openSession = await prisma.employeeSession.findFirst({
        where: {
          id: BigInt(decoded.sessionId),
          employeeId: userFromDb.id,
          logoutTime: null,
        },
        select: { id: true },
      });
      if (!openSession) {
        return errorResponse(res, 401, 'Unauthorized: Session expired or logged out');
      }
    }

    // Build req.user from DB (not trusted client/JWT claims alone)
    req.user = {
      id: Number(userFromDb.id),
      userId: userFromDb.userId,
      userName: userFromDb.userName,
      role: userFromDb.role,
      locationId: userFromDb.locationId != null ? Number(userFromDb.locationId) : null,
      parentId: userFromDb.parentId != null ? Number(userFromDb.parentId) : null,
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

    next();
  } catch (err) {
    return errorResponse(res, 401, 'Unauthorized: Invalid token');
  }
};

module.exports = { authenticate };
