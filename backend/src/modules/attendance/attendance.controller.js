const attendanceService = require('./attendance.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

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
      console.error('Attendance status error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  async checkIn(req, res) {
    try {
      const { lat, lng, address } = req.body || {};
      const data = await attendanceService.checkIn(
        {
          id: Number(req.user.id),
          locationId: req.user.locationId ?? null,
          location: req.user.location ?? null,
        },
        { lat, lng, address }
      );
      return successResponse(res, 201, 'Checked in successfully', data);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Check-in error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  async checkOut(req, res) {
    try {
      const { lat, lng, address } = req.body || {};
      const data = await attendanceService.checkOut(
        {
          id: Number(req.user.id),
          locationId: req.user.locationId ?? null,
          location: req.user.location ?? null,
        },
        { lat, lng, address }
      );
      return successResponse(res, 200, 'Checked out successfully', data);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Check-out error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }
}

module.exports = new AttendanceController();
