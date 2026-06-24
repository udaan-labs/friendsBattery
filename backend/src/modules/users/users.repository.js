const { prisma } = require('../../config/db');

class UserRepository {
  /**
   * Find all users optionally filtered by role.
   * @param {string} [role] - Optional role filter ('ADMIN', 'SELLER')
   * @returns {Promise<Array>}
   */
  async findAll(role) {
    const where = {};
    if (role) {
      where.role = role;
    }
    return prisma.user.findMany({
      where,
      orderBy: {
        createdAt: 'desc'
      }
    });
  }
}

module.exports = new UserRepository();
