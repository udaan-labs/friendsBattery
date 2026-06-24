const userRepository = require('./users.repository');

class UserService {
  /**
   * Fetch all users.
   * @param {string} [role] - Optional role filter
   * @returns {Promise<Array>}
   */
  async getAllUsers(role) {
    const users = await userRepository.findAll(role);
    return users.map(user => ({
      id: Number(user.id),
      userId: user.userId,
      userName: user.userName,
      role: user.role,
      userNumber: user.userNumber,
      shopName: user.shopName,
      isActive: user.isActive,
      isVerified: user.isVerified,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt
    }));
  }
}

module.exports = new UserService();
