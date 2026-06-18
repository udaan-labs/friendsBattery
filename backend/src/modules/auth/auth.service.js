const bcrypt = require('bcrypt');
const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const { JWT_SECRET, JWT_EXPIRES_IN } = require('../../config/env');
const authRepository = require('./auth.repository');

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
      isActive: true,
      isVerified: true,
      loginAttempt: 0
    };

    const newUser = await authRepository.createUser(userData);
    
    return {
      id: Number(newUser.id),
      user_id: newUser.userId,
      username: newUser.userName,
      user_number: newUser.userNumber,
      shop_name: newUser.shopName,
      role: 'seller', // Response expects lowercase 'seller' per the requested response format
      is_active: newUser.isActive,
      is_verified: newUser.isVerified,
      created_at: newUser.createdAt
    };
  }

  async loginUser({ user_id, password }) {
    const user = await authRepository.findUserByUserId(user_id);
    if (!user) {
      const error = new Error('Invalid User ID');
      error.statusCode = 401;
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

    const payload = {
      id: Number(user.id),
      userId: user.userId, // required by auth.middleware.js
      user_id: user.userId,
      role: user.role, // Use actual role from DB (e.g. ADMIN or SELLER) instead of hardcoding 'seller'
      jti: crypto.randomUUID()
    };

    const token = jwt.sign(payload, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });

    // Create a dynamic auth_id that changes every time
    const randomSalt = crypto.randomBytes(8).toString('hex');
    const dynamicAuthId = Buffer.from(`${user.id}:${randomSalt}`).toString('base64');

    return {
      auth_id: dynamicAuthId,
      auth_key: token,
      user: {
        username: user.userName,
        user_number: user.userNumber,
        shop_name: user.shopName,
        role: user.role
      }
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
    
    return {
      user_id: updatedUser.userId,
      is_active: updatedUser.isActive,
      is_verified: updatedUser.isVerified
    };
  }
}

module.exports = new AuthService();
