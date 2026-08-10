const { prisma } = require('../../config/db');

const LOCATION_SELECT = {
  id: true,
  code: true,
  name: true,
  type: true,
  latitude: true,
  longitude: true,
  allowedRadius: true,
};

class AttendanceRepository {
  async findLocationById(locationId) {
    if (locationId == null) return null;
    return prisma.location.findUnique({
      where: { id: BigInt(locationId) },
      select: LOCATION_SELECT,
    });
  }

  async findOpenAttendance(employeeId) {
    return prisma.employeeAttendance.findFirst({
      where: {
        employeeId: BigInt(employeeId),
        status: 'CHECKED_IN',
        checkOutTime: null,
      },
      include: {
        assignedLocation: { select: LOCATION_SELECT },
      },
      orderBy: { checkInTime: 'desc' },
    });
  }

  /** All open check-ins (SA / Admin live staff view). */
  async findAllOpenAttendances() {
    return prisma.employeeAttendance.findMany({
      where: {
        status: 'CHECKED_IN',
        checkOutTime: null,
      },
      include: {
        assignedLocation: { select: LOCATION_SELECT },
        employee: {
          select: {
            id: true,
            userName: true,
            userNumber: true,
            shopName: true,
            role: true,
            locationId: true,
          },
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
        assignedLocation: { select: LOCATION_SELECT },
      },
    });
  }

  async checkOut(attendanceId, { lat, lng, address }) {
    const result = await prisma.employeeAttendance.updateMany({
      where: {
        id: BigInt(attendanceId),
        status: 'CHECKED_IN',
        checkOutTime: null,
      },
      data: {
        checkOutTime: new Date(),
        checkOutLat: lat != null ? lat : null,
        checkOutLng: lng != null ? lng : null,
        checkOutAddress: address || null,
        status: 'CHECKED_OUT',
      },
    });
    if (result.count === 0) return null;
    return prisma.employeeAttendance.findUnique({
      where: { id: BigInt(attendanceId) },
      include: {
        assignedLocation: { select: LOCATION_SELECT },
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

  async findAttendanceHistory(employeeId, { take = 50 } = {}) {
    return prisma.employeeAttendance.findMany({
      where: { employeeId: BigInt(employeeId) },
      include: {
        assignedLocation: { select: LOCATION_SELECT },
      },
      orderBy: { checkInTime: 'desc' },
      take: Math.min(Math.max(Number(take) || 50, 1), 100),
    });
  }
}

module.exports = new AttendanceRepository();
