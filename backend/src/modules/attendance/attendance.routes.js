const express = require('express');
const router = express.Router();
const attendanceController = require('./attendance.controller');
const { checkInSchema, checkOutSchema } = require('./attendance.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const {
  requireEmployee,
  requireAdminOrSeller,
} = require('../../shared/middleware/role.middleware');
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

/**
 * @swagger
 * /api/employee/attendance/checked-in:
 *   get:
 *     summary: List currently checked-in employees (Admin / Super Admin / Seller)
 *     description: |
 *       Returns open attendance rows with check-in GPS and employee profile.
 *       Super Admin: all. Shop Admin: own shop staff. Seller: employees at own location.
 *     tags: [Attendance]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Checked-in staff list
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
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: integer
 *                       employee_id:
 *                         type: integer
 *                       check_in_time:
 *                         type: string
 *                         format: date-time
 *                       check_in_lat:
 *                         type: number
 *                         nullable: true
 *                       check_in_lng:
 *                         type: number
 *                         nullable: true
 *                       status:
 *                         type: string
 *                       location:
 *                         type: object
 *                       employee:
 *                         type: object
 *       403:
 *         description: Admin or Seller only
 */
router.get(
  '/checked-in',
  authenticate,
  requireAdminOrSeller,
  attendanceController.listCheckedIn.bind(attendanceController)
);

module.exports = router;
