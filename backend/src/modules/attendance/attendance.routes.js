const express = require('express');
const router = express.Router();
const attendanceController = require('./attendance.controller');
const { checkInSchema, checkOutSchema } = require('./attendance.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireEmployee } = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

/**
 * @swagger
 * tags:
 *   name: Attendance
 *   description: Employee physical check-in / check-out (employee_attendance)
 */

/**
 * @swagger
 * /api/employee/attendance/status:
 *   get:
 *     summary: Current check-in status for employee
 *     tags: [Attendance]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Status retrieved
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 data:
 *                   $ref: '#/components/schemas/AttendanceStatusData'
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Employee only
 */
router.get(
  '/status',
  authenticate,
  requireEmployee,
  attendanceController.getStatus.bind(attendanceController)
);

/**
 * @swagger
 * /api/employee/attendance/check-in:
 *   post:
 *     summary: Check in at assigned shop location
 *     tags: [Attendance]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: false
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/AttendanceGeoBody'
 *     responses:
 *       201:
 *         description: Checked in
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 data:
 *                   $ref: '#/components/schemas/AttendanceRecord'
 *       400:
 *         description: No location assigned
 *       409:
 *         description: Already checked in
 *       403:
 *         description: Employee only
 */
router.post(
  '/check-in',
  authenticate,
  requireEmployee,
  validateRequest(checkInSchema),
  attendanceController.checkIn.bind(attendanceController)
);

/**
 * @swagger
 * /api/employee/attendance/check-out:
 *   post:
 *     summary: Check out (close open attendance)
 *     tags: [Attendance]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: false
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/AttendanceGeoBody'
 *     responses:
 *       200:
 *         description: Checked out
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 data:
 *                   $ref: '#/components/schemas/AttendanceRecord'
 *       400:
 *         description: Not checked in
 *       403:
 *         description: Employee only
 */
router.post(
  '/check-out',
  authenticate,
  requireEmployee,
  validateRequest(checkOutSchema),
  attendanceController.checkOut.bind(attendanceController)
);

module.exports = router;
