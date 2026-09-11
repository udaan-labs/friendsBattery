const { prisma } = require('../../config/db');
const ROLES = require('../../shared/constants/roles');

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

  /**
   * Open check-ins (SA: all · shop Admin: employee ids · seller: locationId).
   * @param {{ employeeIds?: bigint[], locationId?: number }|null} [scopeFilter]
   */
  async findAllOpenAttendances(scopeFilter = null) {
    const where = {
      status: 'CHECKED_IN',
      checkOutTime: null,
    };
    if (scopeFilter?.locationId != null) {
      where.employee = {
        locationId: BigInt(scopeFilter.locationId),
        role: ROLES.EMPLOYEE,
      };
    } else if (scopeFilter?.employeeIds) {
      if (scopeFilter.employeeIds.length === 0) {
        return [];
      }
      where.employeeId = { in: scopeFilter.employeeIds };
    }
    return prisma.employeeAttendance.findMany({
      where,
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
            parentId: true,
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
        lastLat: lat != null ? lat : null,
        lastLng: lng != null ? lng : null,
        lastSeenAt: new Date(),
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

  async updateLastLocation(attendanceId, { lat, lng }) {
    const result = await prisma.employeeAttendance.updateMany({
      where: {
        id: BigInt(attendanceId),
        status: 'CHECKED_IN',
        checkOutTime: null,
      },
      data: {
        lastLat: lat,
        lastLng: lng,
        lastSeenAt: new Date(),
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
