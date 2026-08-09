const attendanceRepository = require('./attendance.repository');
const { distanceMeters, normalizeGeoBody } = require('../../shared/utils/geo.util');
const { httpError } = require('../../shared/utils/http-error');

function fail(message, statusCode, meta) {
  throw httpError(statusCode, message, meta);
}

function mapLocation(loc) {
  if (!loc) return null;
  return {
    id: Number(loc.id),
    code: loc.code ?? null,
    name: loc.name,
    type: loc.type ?? null,
    latitude: loc.latitude != null ? Number(loc.latitude) : null,
    longitude: loc.longitude != null ? Number(loc.longitude) : null,
    allowed_radius:
      loc.allowedRadius != null ? Number(loc.allowedRadius) : 100,
  };
}

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
    location: mapLocation(row.assignedLocation),
  };
}

function assertWithinAssignedLocation(location, lat, lng) {
  if (lat == null || lng == null || Number.isNaN(lat) || Number.isNaN(lng)) {
    fail('GPS coordinates are required for attendance', 400);
  }

  if (
    location.latitude == null ||
    location.longitude == null ||
    Number.isNaN(Number(location.latitude)) ||
    Number.isNaN(Number(location.longitude))
  ) {
    fail(
      'Assigned location has no GPS coordinates configured. Contact admin.',
      400
    );
  }

  const radius =
    location.allowedRadius != null ? Number(location.allowedRadius) : 100;
  const meters = distanceMeters(
    lat,
    lng,
    Number(location.latitude),
    Number(location.longitude)
  );

  if (meters > radius) {
    fail('You are not at your assigned location.', 403, {
      distance_meters: Math.round(meters),
      allowed_radius: radius,
    });
  }

  return meters;
}

function buildGeoAddress({ address, accuracy, timestamp }) {
  const parts = [];
  if (address) parts.push(address);
  if (accuracy != null && !Number.isNaN(accuracy)) {
    parts.push(`accuracy=${Number(accuracy).toFixed(1)}m`);
  }
  if (timestamp) parts.push(`ts=${timestamp}`);
  return parts.length ? parts.join(' | ') : null;
}

class AttendanceService {
  async getStatus(user) {
    const [open, location] = await Promise.all([
      attendanceRepository.findOpenAttendance(user.id),
      user.locationId != null
        ? attendanceRepository.findLocationById(user.locationId)
        : Promise.resolve(null),
    ]);

    return {
      is_checked_in: !!open,
      attendance: mapAttendance(open),
      location: mapLocation(location),
    };
  }

  async checkIn(user, rawBody = {}) {
    if (user.locationId == null) {
      fail('Employee has no assigned location', 400);
    }

    const location = await attendanceRepository.findLocationById(user.locationId);
    if (!location) fail('Assigned location not found', 400);

    const { lat, lng, accuracy, timestamp, address } = normalizeGeoBody(rawBody);
    assertWithinAssignedLocation(location, lat, lng);

    const open = await attendanceRepository.findOpenAttendance(user.id);
    if (open) fail('Already checked in. Check out first.', 409);

    const geoAddress = buildGeoAddress({ address, accuracy, timestamp });

    let row;
    try {
      row = await attendanceRepository.createCheckIn({
        employeeId: user.id,
        assignedLocationId: user.locationId,
        lat,
        lng,
        address: geoAddress,
      });
    } catch (err) {
      if (err.code === 'P2002') fail('Already checked in. Check out first.', 409);
      throw err;
    }

    try {
      await attendanceRepository.logActivity({
        employeeId: user.id,
        action: 'CHECK_IN',
        referenceId: Number(row.id),
      });
    } catch (_) {
      /* best-effort activity log */
    }

    return mapAttendance(row);
  }

  async checkOut(user, rawBody = {}) {
    const open = await attendanceRepository.findOpenAttendance(user.id);
    if (!open) fail('Not checked in', 400);

    const locationId = user.locationId ?? Number(open.assignedLocationId);
    const location =
      open.assignedLocation ||
      (await attendanceRepository.findLocationById(locationId));

    if (!location) fail('Assigned location not found', 400);

    const { lat, lng, accuracy, timestamp, address } = normalizeGeoBody(rawBody);
    assertWithinAssignedLocation(location, lat, lng);

    const geoAddress = buildGeoAddress({ address, accuracy, timestamp });
    const row = await attendanceRepository.checkOut(open.id, {
      lat,
      lng,
      address: geoAddress,
    });
    if (!row) fail('Not checked in', 400);

    try {
      await attendanceRepository.logActivity({
        employeeId: user.id,
        action: 'CHECK_OUT',
        referenceId: Number(row.id),
      });
    } catch (_) {
      /* best-effort activity log */
    }

    return mapAttendance(row);
  }
}

module.exports = new AttendanceService();
