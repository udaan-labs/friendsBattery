const attendanceService = require('./attendance.service');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

class AttendanceController {
  async getStatus(req, res) {
    try {
      const data = await attendanceService.getStatus({
        id: Number(req.user.id),
        locationId: req.user.locationId ?? null,
        location: req.user.location ?? null,
      });
      return successResponse(res, 200, 'Attendance status retrieved', data);
    } catch (error) {
      return handleRouteError(res, error, 'Attendance status error:');
    }
  }

  async checkIn(req, res) {
    try {
      const data = await attendanceService.checkIn(
        {
          id: Number(req.user.id),
          locationId: req.user.locationId ?? null,
          location: req.user.location ?? null,
        },
        req.body || {}
      );
      return successResponse(res, 201, 'Checked in successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Check-in error:');
    }
  }

  async checkOut(req, res) {
    try {
      const data = await attendanceService.checkOut(
        {
          id: Number(req.user.id),
          locationId: req.user.locationId ?? null,
          location: req.user.location ?? null,
        },
        req.body || {}
      );
      return successResponse(res, 200, 'Checked out successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Check-out error:');
    }
  }

  async listCheckedIn(req, res) {
    try {
      const data = await attendanceService.listCheckedInStaff(req.user);
      return successResponse(res, 200, 'Checked-in staff retrieved', data);
    } catch (error) {
      return handleRouteError(res, error, 'Checked-in staff error:');
    }
  }
}

module.exports = new AttendanceController();
