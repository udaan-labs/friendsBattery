const { prisma } = require('../../config/db');

class AuthRepository {
  async findUserByUserId(userId) {
    return await prisma.user.findFirst({
      where: { userId: userId },
      include: {
        location: {
          select: { id: true, code: true, name: true, type: true },
        },
        employeeRole: {
          select: { id: true, name: true, description: true },
        },
      },
    });
  }

  async findUserByUsername(username) {
    return await prisma.user.findFirst({
      where: { userName: username },
    });
  }

  async findUserByNumber(userNumber) {
    return await prisma.user.findFirst({
      where: { userNumber: userNumber },
    });
  }

  /** One SELLER / EMPLOYEE per location. */
  async findUserByLocationAndRole(locationId, role) {
    return prisma.user.findFirst({
      where: {
        locationId: BigInt(locationId),
        role,
      },
      select: { id: true, userId: true, role: true },
    });
  }

  async createUser(userData) {
    return await prisma.user.create({
      data: userData,
    });
  }

  /** Active location. Default SHOP (sellers). Pass types for SA admin assign. */
  async findActiveLocation(locationId, types = ['SHOP']) {
    return prisma.location.findFirst({
      where: {
        id: BigInt(locationId),
        type: { in: types },
        isActive: true,
      },
      select: { id: true, code: true, name: true, type: true, isActive: true },
    });
  }

  async updateLoginAttempt(userId, attempts) {
    return await prisma.user.update({
      where: { userId: userId },
      data: { loginAttempt: attempts },
    });
  }

  async updateUserStatus(userId, isActive, isVerified) {
    return await prisma.user.update({
      where: { userId: userId },
      data: {
        isActive: isActive,
        isVerified: isVerified,
      },
    });
  }

  /** Create app login session (employee_sessions) — not attendance. */
  async createEmployeeSession({ employeeId, deviceId, ipAddress, appVersion, firebaseToken }) {
    return prisma.employeeSession.create({
      data: {
        employeeId: BigInt(employeeId),
        deviceId: deviceId || null,
        ipAddress: ipAddress || null,
        appVersion: appVersion || null,
        firebaseToken: firebaseToken || null,
      },
    });
  }

  /** Revoke every open employee session (single-device login). */
  async closeAllOpenEmployeeSessions(employeeId) {
    return prisma.employeeSession.updateMany({
      where: {
        employeeId: BigInt(employeeId),
        logoutTime: null,
      },
      data: { logoutTime: new Date() },
    });
  }

  /** Close open session by id, or latest open session for employee. */
  async closeEmployeeSession({ sessionId, employeeId }) {
    if (sessionId) {
      const session = await prisma.employeeSession.findFirst({
        where: {
          id: BigInt(sessionId),
          employeeId: BigInt(employeeId),
          logoutTime: null,
        },
      });
      if (!session) return null;
      return prisma.employeeSession.update({
        where: { id: session.id },
        data: { logoutTime: new Date() },
      });
    }

    const open = await prisma.employeeSession.findFirst({
      where: {
        employeeId: BigInt(employeeId),
        logoutTime: null,
      },
      orderBy: { loginTime: 'desc' },
    });
    if (!open) return null;
    return prisma.employeeSession.update({
      where: { id: open.id },
      data: { logoutTime: new Date() },
    });
  }
}

module.exports = new AuthRepository();
