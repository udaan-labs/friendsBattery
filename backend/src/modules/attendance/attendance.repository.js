const { prisma } = require('../../config/db');

class AttendanceRepository {
  async findOpenAttendance(employeeId) {
    return prisma.employeeAttendance.findFirst({
      where: {
        employeeId: BigInt(employeeId),
        status: 'CHECKED_IN',
        checkOutTime: null,
      },
      include: {
        assignedLocation: {
          select: { id: true, code: true, name: true, type: true },
        },
      },
      orderBy: { checkInTime: 'desc' },
    });
  }

  async createCheckIn({ employeeId, assignedLocationId, lat, lng, address }) {
    return prisma.employeeAttendance.create({
      data: {
        employeeId: BigInt(employeeId),
        assignedLocationId: BigInt(assignedLocationId),
        checkInTime: new Date(),
        checkInLat: lat != null ? lat : null,
        checkInLng: lng != null ? lng : null,
        checkInAddress: address || null,
        status: 'CHECKED_IN',
      },
      include: {
        assignedLocation: {
          select: { id: true, code: true, name: true, type: true },
        },
      },
    });
  }

  async checkOut(attendanceId, { lat, lng, address }) {
    return prisma.employeeAttendance.update({
      where: { id: BigInt(attendanceId) },
      data: {
        checkOutTime: new Date(),
        checkOutLat: lat != null ? lat : null,
        checkOutLng: lng != null ? lng : null,
        checkOutAddress: address || null,
        status: 'CHECKED_OUT',
      },
      include: {
        assignedLocation: {
          select: { id: true, code: true, name: true, type: true },
        },
      },
    });
  }

  async logActivity({ employeeId, action, referenceId }) {
    return prisma.employeeActivityLog.create({
      data: {
        employeeId: BigInt(employeeId),
        action,
        referenceId: referenceId != null ? BigInt(referenceId) : null,
      },
    });
  }

  /**
   * Attendance rows for admin history (check-in / check-out only source).
   * @param {number|string|bigint} employeeId
   * @param {{ take?: number }} [opts]
   */
  async findAttendanceHistory(employeeId, { take = 50 } = {}) {
    return prisma.employeeAttendance.findMany({
      where: { employeeId: BigInt(employeeId) },
      include: {
        assignedLocation: {
          select: { id: true, code: true, name: true, type: true },
        },
      },
      orderBy: { checkInTime: 'desc' },
      take: Math.min(Math.max(Number(take) || 50, 1), 100),
    });
  }
}

module.exports = new AttendanceRepository();
