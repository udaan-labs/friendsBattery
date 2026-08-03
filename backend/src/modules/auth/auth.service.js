const bcrypt = require('bcrypt');
const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const { JWT_SECRET, JWT_EXPIRES_IN } = require('../../config/env');
const authRepository = require('./auth.repository');
const ROLES = require('../../shared/constants/roles');

class AuthService {
  async registerUser({ user_id, username, user_number, shop_name, password }) {
    // Check constraints sequentially to return specific error messages
    const existingUserId = await authRepository.findUserByUserId(user_id);
    if (existingUserId) {
      const error = new Error('User ID already exists');
      error.statusCode = 409;
      throw error;
    }

    const existingUsername = await authRepository.findUserByUsername(username);
    if (existingUsername) {
      const error = new Error('Username already exists');
      error.statusCode = 409;
      throw error;
    }

    const existingUserNumber = await authRepository.findUserByNumber(user_number);
    if (existingUserNumber) {
      const error = new Error('Mobile number already exists');
      error.statusCode = 409;
      throw error;
    }

    const saltRounds = 10;
    const passwordHash = await bcrypt.hash(password, saltRounds);

    const userData = {
      userId: user_id,
      userName: username,
      userNumber: user_number,
      shopName: shop_name,
      passwordHash,
      role: 'SELLER',
      // Admin activates via PUT /auth/activate — never auto-login-ready
      isActive: false,
      isVerified: false,
      loginAttempt: 0,
    };

    const newUser = await authRepository.createUser(userData);

    return {
      id: Number(newUser.id),
      user_id: newUser.userId,
      username: newUser.userName,
      user_number: newUser.userNumber,
      shop_name: newUser.shopName,
      role: 'seller',
      is_active: newUser.isActive,
      is_verified: newUser.isVerified,
      created_at: newUser.createdAt,
    };
  }

  /**
   * Login any system role (ADMIN / SELLER / EMPLOYEE).
   * Employees get an employee_sessions row (security) and location / employee_role on user payload.
   */
  async loginUser({ user_id, password, device_id, ip_address, app_version, firebase_token }) {
    const user = await authRepository.findUserByUserId(user_id);
    if (!user) {
      const error = new Error('Invalid User ID');
      error.statusCode = 401;
      throw error;
    }

    // loginAttempt is real lockout (admin clears via activate / successful login reset)
    if (Number(user.loginAttempt) >= 10) {
      const error = new Error('Too many failed logins. Contact admin.');
      error.statusCode = 403;
      throw error;
    }

    const isPasswordValid = await bcrypt.compare(password, user.passwordHash);
    if (!isPasswordValid) {
      await authRepository.updateLoginAttempt(user_id, user.loginAttempt + 1);
      const error = new Error('Invalid Password');
      error.statusCode = 401;
      throw error;
    }

    if (!user.isActive) {
      const error = new Error('cant not login');
      error.statusCode = 403;
      throw error;
    }

    if (!user.isVerified) {
      const error = new Error('login after some time');
      error.statusCode = 403;
      throw error;
    }

    if (user.loginAttempt > 0) {
      await authRepository.updateLoginAttempt(user_id, 0);
    }

    let sessionId = null;
    if (user.role === ROLES.EMPLOYEE) {
      // Single active session: re-login kills old JWTs (middleware checks open session)
      await authRepository.closeAllOpenEmployeeSessions(user.id);
      const session = await authRepository.createEmployeeSession({
        employeeId: user.id,
        deviceId: device_id,
        ipAddress: ip_address,
        appVersion: app_version,
        firebaseToken: firebase_token,
      });
      sessionId = Number(session.id);
    }

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
      const error = new Error('Invalid User ID');
      error.statusCode = 404;
      throw error;
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
