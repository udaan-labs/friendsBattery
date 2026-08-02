const attendanceRepository = require('./attendance.repository');

function mapAttendance(row) {
  if (!row) return null;
  return {
    id: Number(row.id),
    employee_id: Number(row.employeeId),
    assigned_location_id: Number(row.assignedLocationId),
    check_in_time: row.checkInTime?.toISOString() ?? null,
    check_out_time: row.checkOutTime?.toISOString() ?? null,
    check_in_lat: row.checkInLat != null ? Number(row.checkInLat) : null,
    check_in_lng: row.checkInLng != null ? Number(row.checkInLng) : null,
    check_out_lat: row.checkOutLat != null ? Number(row.checkOutLat) : null,
    check_out_lng: row.checkOutLng != null ? Number(row.checkOutLng) : null,
    check_in_address: row.checkInAddress ?? null,
    check_out_address: row.checkOutAddress ?? null,
    status: row.status,
    location: row.assignedLocation
      ? {
          id: Number(row.assignedLocation.id),
          code: row.assignedLocation.code,
          name: row.assignedLocation.name,
          type: row.assignedLocation.type,
        }
      : null,
  };
}

class AttendanceService {
  /**
   * @param {{ id: number, locationId: number|null, location?: object }} user
   */
  async getStatus(user) {
    const open = await attendanceRepository.findOpenAttendance(user.id);
    return {
      is_checked_in: !!open,
      attendance: mapAttendance(open),
      location: user.location || null,
    };
  }

  async checkIn(user, { lat, lng, address } = {}) {
    if (user.locationId == null) {
      const error = new Error('Employee has no assigned location');
      error.statusCode = 400;
      throw error;
    }

    const open = await attendanceRepository.findOpenAttendance(user.id);
    if (open) {
      const error = new Error('Already checked in. Check out first.');
      error.statusCode = 409;
      throw error;
    }

    let row;
    try {
      row = await attendanceRepository.createCheckIn({
        employeeId: user.id,
        assignedLocationId: user.locationId,
        lat,
        lng,
        address,
      });
    } catch (err) {
      // Unique open-check-in index (race between two parallel check-ins)
      if (err.code === 'P2002') {
        const error = new Error('Already checked in. Check out first.');
        error.statusCode = 409;
        throw error;
      }
      throw err;
    }

    // Secondary log — never roll back a successful check-in
    try {
      await attendanceRepository.logActivity({
        employeeId: user.id,
        action: 'CHECK_IN',
        referenceId: Number(row.id),
      });
    } catch (_) {
      /* ponytail: activity log best-effort */
    }

    return mapAttendance(row);
  }

  async checkOut(user, { lat, lng, address } = {}) {
    const open = await attendanceRepository.findOpenAttendance(user.id);
    if (!open) {
      const error = new Error('Not checked in');
      error.statusCode = 400;
      throw error;
    }

    const row = await attendanceRepository.checkOut(open.id, { lat, lng, address });

    try {
      await attendanceRepository.logActivity({
        employeeId: user.id,
        action: 'CHECK_OUT',
        referenceId: Number(row.id),
      });
    } catch (_) {
      /* ponytail: activity log best-effort */
    }

    return mapAttendance(row);
  }
}

module.exports = new AttendanceService();
