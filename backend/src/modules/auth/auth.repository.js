const { prisma } = require('../../config/db');

class AuthRepository {
  async findUserByUserId(userId) {
    return await prisma.user.findFirst({
      where: { userId: userId }
    });
  }

  async findUserByUsername(username) {
    return await prisma.user.findFirst({
      where: { userName: username }
    });
  }

  async findUserByNumber(userNumber) {
    return await prisma.user.findFirst({
      where: { userNumber: userNumber }
    });
  }

  async createUser(userData) {
    return await prisma.user.create({
      data: userData
    });
  }

  async updateLoginAttempt(userId, attempts) {
    return await prisma.user.update({
      where: { userId: userId },
      data: { loginAttempt: attempts }
    });
  }

  async updateUserStatus(userId, isActive, isVerified) {
    return await prisma.user.update({
      where: { userId: userId },
      data: { 
        isActive: isActive,
        isVerified: isVerified
      }
    });
  }
}

module.exports = new AuthRepository();
