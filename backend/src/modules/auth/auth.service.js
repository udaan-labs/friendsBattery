const bcrypt = require('bcrypt');
const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const { JWT_SECRET, JWT_EXPIRES_IN } = require('../../config/env');
const authRepository = require('./auth.repository');
const ROLES = require('../../shared/constants/roles');
const { httpError } = require('../../shared/utils/http-error');
const { titleName } = require('../../shared/utils/title-name');
const orgEventsRepository = require('../../shared/org-events.repository');
const otpService = require('../otp/otp.service');

class AuthService {
  /**
   * Super Admin only: create an ADMIN under this SA (shop or warehouse).
   * parent_id = SA; optional SHOP|WAREHOUSE location; active + verified.
   */
  async registerAdmin({ user_id, username, user_number, shop_name, password, location_id, actor }) {
    username = titleName(username);
    if (!actor || actor.role !== ROLES.SUPER_ADMIN) {
      throw httpError(403, 'Only Super Admin can create Admins');
    }

    const existingUserId = await authRepository.findUserByUserId(user_id);
    if (existingUserId) {
      throw httpError(409, 'User ID already exists');
    }

    const existingUsername = await authRepository.findUserByUsername(username);
    if (existingUsername) {
      throw httpError(409, 'Username already exists');
    }

    const existingUserNumber = await authRepository.findUserByNumber(user_number);
    if (existingUserNumber) {
      throw httpError(409, 'Mobile number already exists');
    }

    let locationId = null;
    let resolvedShopName = shop_name;
    if (location_id != null) {
      const location = await authRepository.findActiveLocation(location_id, [
        'SHOP',
        'WAREHOUSE',
      ]);
      if (!location) {
        throw httpError(400, 'Location not found or inactive (must be SHOP or WAREHOUSE)');
      }
      locationId = Number(location.id);
      if (!resolvedShopName || !String(resolvedShopName).trim()) {
        resolvedShopName = location.name;
      }
    }

    const passwordHash = await bcrypt.hash(password, 10);

    const newUser = await authRepository.createUser({
      userId: user_id,
      userName: username,
      userNumber: user_number,
      shopName: resolvedShopName,
      passwordHash,
      role: ROLES.ADMIN,
      locationId: locationId != null ? BigInt(locationId) : null,
      parentId: actor.id != null ? BigInt(actor.id) : null,
      isActive: true,
      isVerified: true,
      loginAttempt: 0,
    });

    await orgEventsRepository.create({
      action: 'ADMIN_CREATED',
      actorId: actor.id,
      entityType: 'user',
      entityId: newUser.id,
      payload: {
        username: newUser.userName,
        shop_name: newUser.shopName,
        location_id: locationId,
      },
    });

    return {
      id: Number(newUser.id),
      user_id: newUser.userId,
      username: newUser.userName,
      user_number: newUser.userNumber,
      shop_name: newUser.shopName,
      location_id: newUser.locationId != null ? Number(newUser.locationId) : null,
      parent_id: newUser.parentId != null ? Number(newUser.parentId) : null,
      role: 'admin',
      is_active: newUser.isActive,
      is_verified: newUser.isVerified,
      created_at: newUser.createdAt,
    };
  }

  /**
   * Admin (or Super Admin) registers a SELLER.
   * parent_id = shop Admin when actor is ADMIN; when SA creates seller, parent_id = SA.
   * Shop Admin: force seller location_id = admin's shop (client location ignored).
   */
  async registerUser({ user_id, username, user_number, shop_name, password, location_id, actor }) {
    username = titleName(username);
    // Check constraints sequentially to return specific error messages
    const existingUserId = await authRepository.findUserByUserId(user_id);
    if (existingUserId) {
      throw httpError(409, 'User ID already exists');
    }

    const existingUsername = await authRepository.findUserByUsername(username);
    if (existingUsername) {
      throw httpError(409, 'Username already exists');
    }

    const existingUserNumber = await authRepository.findUserByNumber(user_number);
    if (existingUserNumber) {
      throw httpError(409, 'Mobile number already exists');
    }

    let locationId = null;
    let resolvedShopName = shop_name;

    // Shop Admin: always own shop (client location_id ignored; location from auth middleware)
    if (actor?.role === ROLES.ADMIN) {
      if (actor.locationId == null) {
        throw httpError(
          400,
          'Your account has no shop location. Create or assign a shop before adding sellers.'
        );
      }
      const location = await authRepository.findActiveLocation(actor.locationId);
      if (!location) {
        throw httpError(400, 'Shop location not found or inactive (must be type SHOP)');
      }
      locationId = Number(location.id);
      if (!resolvedShopName || !String(resolvedShopName).trim()) {
        resolvedShopName = location.name;
      }
    } else if (location_id != null) {
      const location = await authRepository.findActiveLocation(location_id);
      if (!location) {
        throw httpError(400, 'Shop location not found or inactive (must be type SHOP)');
      }
      locationId = Number(location.id);
      if (!resolvedShopName || !String(resolvedShopName).trim()) {
        resolvedShopName = location.name;
      }
    }

    if (locationId != null) {
      const taken = await authRepository.findUserByLocationAndRole(locationId, ROLES.SELLER);
      if (taken) {
        throw httpError(409, 'This shop already has a seller');
      }
    }

    const saltRounds = 10;
    const passwordHash = await bcrypt.hash(password, saltRounds);

    // SELLER → Admin (or SA if created by SA)
    const parentId =
      actor?.id != null ? BigInt(actor.id) : null;

    const userData = {
      userId: user_id,
      userName: username,
      userNumber: user_number,
      shopName: resolvedShopName,
      passwordHash,
      role: ROLES.SELLER,
      locationId: locationId != null ? BigInt(locationId) : null,
      parentId,
      // Admin activates via PUT /auth/activate — never auto-login-ready
      isActive: false,
      isVerified: false,
      loginAttempt: 0,
    };

    const newUser = await authRepository.createUser(userData);

    await orgEventsRepository.create({
      action: 'SELLER_CREATED',
      actorId: actor?.id,
      entityType: 'user',
      entityId: newUser.id,
      payload: {
        username: newUser.userName,
        shop_name: newUser.shopName,
        location_id: locationId,
      },
    });

    return {
      id: Number(newUser.id),
      user_id: newUser.userId,
      username: newUser.userName,
      user_number: newUser.userNumber,
      shop_name: newUser.shopName,
      location_id: newUser.locationId != null ? Number(newUser.locationId) : null,
      parent_id: newUser.parentId != null ? Number(newUser.parentId) : null,
      role: 'seller',
      is_active: newUser.isActive,
      is_verified: newUser.isVerified,
      created_at: newUser.createdAt,
    };
  }

  /** Password login → JWT. */
  async loginUser({ user_id, password, device_id, ip_address, app_version, firebase_token }) {
    const user = await authRepository.findUserByUserId(user_id);
    if (!user) {
      throw httpError(401, 'Invalid User ID');
    }

    if (Number(user.loginAttempt) >= 10) {
      throw httpError(403, 'Too many failed logins. Contact admin.');
    }

    const isPasswordValid = await bcrypt.compare(password, user.passwordHash);
    if (!isPasswordValid) {
      await authRepository.updateLoginAttempt(user_id, user.loginAttempt + 1);
      throw httpError(401, 'Invalid Password');
    }

    if (!user.isActive) {
      throw httpError(403, 'cant not login');
    }

    if (!user.isVerified) {
      throw httpError(403, 'login after some time');
    }

    // ponytail: password login only — OTP/SMS later
    return this._completeLogin(user, {
      device_id,
      ip_address,
      app_version,
      firebase_token,
    });
  }

  /**
   * Step 2 — verify login OTP, issue JWT (+ employee session when needed).
   */
  async verifyLoginOtp({ challenge_id, otp }) {
    const verified = otpService.verifyChallenge({
      challengeId: challenge_id,
      code: otp,
      purpose: 'login',
    });

    const meta = verified.meta || {};
    const user = await authRepository.findUserByUserId(meta.user_id);
    if (!user || Number(user.id) !== Number(meta.userDbId)) {
      throw httpError(401, 'OTP session invalid. Login again.');
    }

    if (!user.isActive) {
      throw httpError(403, 'cant not login');
    }
    if (!user.isVerified) {
      throw httpError(403, 'login after some time');
    }

    return this._completeLogin(user, meta);
  }

  async _completeLogin(user, meta = {}) {
    if (user.loginAttempt > 0) {
      await authRepository.updateLoginAttempt(user.userId, 0);
    }

    let sessionId = null;
    if (user.role === ROLES.EMPLOYEE) {
      await authRepository.closeAllOpenEmployeeSessions(user.id);
      const session = await authRepository.createEmployeeSession({
        employeeId: user.id,
        deviceId: meta.device_id,
        ipAddress: meta.ip_address,
        appVersion: meta.app_version,
        firebaseToken: meta.firebase_token,
      });
      sessionId = Number(session.id);
    }

    return this._buildLoginTokenResponse(user, sessionId);
  }

  _buildLoginTokenResponse(user, sessionId) {
    const payload = {
      id: Number(user.id),
      userId: user.userId,
      user_id: user.userId,
      role: user.role,
      jti: crypto.randomUUID(),
      ...(sessionId != null ? { sessionId } : {}),
    };

    const token = jwt.sign(payload, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });
    const randomSalt = crypto.randomBytes(8).toString('hex');
    const dynamicAuthId = Buffer.from(`${user.id}:${randomSalt}`).toString('base64');

    return {
      auth_id: dynamicAuthId,
      auth_key: token,
      ...(sessionId != null ? { session_id: sessionId } : {}),
      user: {
        id: Number(user.id),
        username: user.userName,
        user_number: user.userNumber,
        shop_name: user.shopName,
        role: user.role,
        location_id: user.locationId != null ? Number(user.locationId) : null,
        employee_role_id: user.employeeRoleId != null ? Number(user.employeeRoleId) : null,
        location: user.location
          ? {
              id: Number(user.location.id),
              code: user.location.code,
              name: user.location.name,
              type: user.location.type,
            }
          : null,
        employee_role: user.employeeRole
          ? {
              id: Number(user.employeeRole.id),
              name: user.employeeRole.name,
              description: user.employeeRole.description,
            }
          : null,
      },
    };
  }

  async logoutUser({ userId, role, sessionId }) {
    if (role !== ROLES.EMPLOYEE) {
      return { logged_out: true, session: null };
    }

    const closed = await authRepository.closeEmployeeSession({
      sessionId: sessionId || null,
      employeeId: userId,
    });

    return {
      logged_out: true,
      session: closed
        ? {
            id: Number(closed.id),
            login_time: closed.loginTime,
            logout_time: closed.logoutTime,
          }
        : null,
    };
  }

  async activateUser({ user_id, is_active, is_verified }) {
    const user = await authRepository.findUserByUserId(user_id);
    if (!user) {
      throw httpError(404, 'Invalid User ID');
    }

    const updatedUser = await authRepository.updateUserStatus(user_id, is_active, is_verified);

    // Activating also clears lockout counter (admin unlock path)
    if (is_active === true || is_verified === true) {
      await authRepository.updateLoginAttempt(user_id, 0);
    }

    // Deactivate / de-verify employee → kill open sessions immediately
    if (
      user.role === ROLES.EMPLOYEE &&
      (is_active === false || is_verified === false)
    ) {
      await authRepository.closeAllOpenEmployeeSessions(user.id);
    }

    return {
      user_id: updatedUser.userId,
      is_active: updatedUser.isActive,
      is_verified: updatedUser.isVerified,
    };
  }
}

module.exports = new AuthService();
