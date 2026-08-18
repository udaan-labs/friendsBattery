const express = require('express');
const router = express.Router();
const shopsController = require('./shops.controller');
const {
  viewSellerSchema,
  shopStaffSchema,
  locationStaffSchema,
  viewEmployeeSchema,
  transferEmployeeSchema,
  createEmployeeSchema,
  listLocationsSchema,
  createLocationSchema,
  updateLocationSchema,
} = require('./shops.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const {
  requireAdmin,
  requireSeller,
  requireAdminOrSeller,
} = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

/**
 * @swagger
 * tags:
 *   name: Shops
 *   description: Shops management
 */

/**
 * @swagger
 * /api/shops/sellers:
 *   get:
 *     summary: Return all sellers
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Sellers fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/SellersListResponse'
 *       401:
 *         description: Unauthorized
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       403:
 *         description: Admin only
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.get(
  '/sellers',
  authenticate,
  requireAdmin,
  shopsController.getSellers
);

/**
 * @swagger
 * /api/shops/sellers/{sellerId}:
 *   get:
 *     summary: Return one seller
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: sellerId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: query
 *         name: includeOutOfStock
 *         schema:
 *           type: boolean
 *     responses:
 *       200:
 *         description: Seller fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/SellerDetailResponse'
 *       404:
 *         description: Seller not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
/**
 * @swagger
 * /api/shops/sellers/{sellerId}/staff:
 *   get:
 *     summary: Sellers and employees at the same shop location as this seller
 *     description: |
 *       Admin only. Uses the seller's users.location_id.
 *       Returns only SELLER and EMPLOYEE users assigned to that location.
 *       Empty lists if seller has no location.
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: sellerId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Shop staff fetched
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ShopStaffResponse'
 *       404:
 *         description: Seller not found
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin only
 */
router.get(
  '/sellers/:sellerId/staff',
  authenticate,
  requireAdmin,
  validateRequest(shopStaffSchema),
  shopsController.getShopStaff
);

/**
 * @swagger
 * /api/shops/my-staff:
 *   get:
 *     summary: Seller — staff at own shop location
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Shop staff fetched
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ShopStaffResponse'
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Seller only
 */
router.get(
  '/my-staff',
  authenticate,
  requireSeller,
  shopsController.getMyStaff
);

/**
 * @swagger
 * /api/shops/employee-roles:
 *   get:
 *     summary: List job titles for employees (Manager, Cashier, …)
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Roles list
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/EmployeeRolesResponse'
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin or Seller only
 */
router.get(
  '/employee-roles',
  authenticate,
  requireAdminOrSeller,
  shopsController.listEmployeeRoles
);

/**
 * @swagger
 * /api/shops/locations:
 *   get:
 *     summary: List active locations (warehouse + shops)
 *     description: Admin only. Optional type filter for shops vs warehouses.
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: type
 *         schema:
 *           type: string
 *           enum: [SHOP, WAREHOUSE]
 *         description: Filter by location type
 *     responses:
 *       200:
 *         description: Locations list
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/LocationsListResponse'
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin only
 *   post:
 *     summary: Create a shop or warehouse location
 *     description: |
 *       Admin only. Creates an active location used for seller assignment,
 *       employees, and inventory placement. Optional latitude/longitude set the
 *       attendance geofence center (both required together); allowed_radius defaults to 100m.
 *       SHOP requires warehouse_id of an active warehouse. WAREHOUSE has no parent.
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateLocationRequest'
 *     responses:
 *       201:
 *         description: Location created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/CreateLocationResponse'
 *       400:
 *         description: Validation error
 *       409:
 *         description: Location code already exists
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin only
 */
router.get(
  '/locations',
  authenticate,
  requireAdmin,
  validateRequest(listLocationsSchema),
  shopsController.listLocations
);

/**
 * @swagger
 * /api/shops/locations/{locationId}/staff:
 *   get:
 *     summary: Admin, sellers and employees assigned to this location
 *     description: |
 *       Admin only. Returns ADMIN, SELLER and EMPLOYEE users with users.location_id
 *       equal to this shop/warehouse.
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: locationId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Shop staff fetched
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ShopStaffResponse'
 *       404:
 *         description: Location not found
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin only
 */
router.get(
  '/locations/:locationId/staff',
  authenticate,
  requireAdmin,
  validateRequest(locationStaffSchema),
  shopsController.getLocationStaff
);

router.post(
  '/locations',
  authenticate,
  requireAdmin,
  validateRequest(createLocationSchema),
  shopsController.createLocation
);

/**
 * @swagger
 * /api/shops/locations/{locationId}:
 *   patch:
 *     summary: Update a shop or warehouse name and map location
 *     description: |
 *       Admin only. Updates name, address, and/or attendance geofence
 *       (latitude, longitude, allowed_radius). Does not change type, code,
 *       or warehouse_id. Super Admin: any location. Shop Admin: own shop only.
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: locationId
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UpdateLocationRequest'
 *     responses:
 *       200:
 *         description: Location updated
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/UpdateLocationResponse'
 *       400:
 *         description: Validation error
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Forbidden (not your shop)
 *       404:
 *         description: Location not found
 */
router.patch(
  '/locations/:locationId',
  authenticate,
  requireAdmin,
  validateRequest(updateLocationSchema),
  shopsController.updateLocation
);

/**
 * @swagger
 * /api/shops/employees:
 *   post:
 *     summary: Create an employee at a shop or warehouse
 *     description: |
 *       **Seller:** employee is always assigned to the seller's `location_id`
 *       (body `location_id` is ignored). Seller must have a location.
 *       **Admin:** body `location_id` is required (WAREHOUSE or SHOP).
 *       New employees are active and verified (can log in immediately).
 *       `user_id` is optional — omit to auto-generate EMP001, EMP002, …
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateEmployeeRequest'
 *     responses:
 *       201:
 *         description: Employee created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/CreateEmployeeResponse'
 *       400:
 *         description: Validation / missing location / invalid role
 *       409:
 *         description: user_id, username, or mobile already exists
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin or Seller only
 */
router.post(
  '/employees',
  authenticate,
  requireAdminOrSeller,
  validateRequest(createEmployeeSchema),
  shopsController.createEmployee
);

/**
 * @swagger
 * /api/shops/employees/next-user-id:
 *   get:
 *     summary: Preview next auto-generated employee user_id (EMP001, EMP002, …)
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Next unused EMP### login id
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/NextEmployeeUserIdResponse'
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin or Seller only
 */
router.get(
  '/employees/next-user-id',
  authenticate,
  requireAdminOrSeller,
  shopsController.nextEmployeeUserId
);

/**
 * @swagger
 * /api/shops/employees/{employeeId}:
 *   get:
 *     summary: Admin view one employee (profile + check-in/check-out only)
 *     description: |
 *       Admin only. Returns EMPLOYEE user profile and an `actions` timeline
 *       limited to CHECK_IN and CHECK_OUT (from employee_attendance).
 *       Does not include sales, inventory, or seller data.
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: employeeId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 50
 *           maximum: 100
 *         description: Max attendance rows to expand into actions
 *     responses:
 *       200:
 *         description: Employee profile + attendance actions
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AdminEmployeeDetailResponse'
 *       404:
 *         description: Employee not found (or user is not EMPLOYEE)
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Admin only
 */
router.get(
  '/employees/:employeeId',
  authenticate,
  requireAdmin,
  validateRequest(viewEmployeeSchema),
  shopsController.viewEmployee
);

/**
 * @swagger
 * /api/shops/employees/{employeeId}/location:
 *   patch:
 *     summary: Move an admin or employee to another shop or warehouse
 *     description: |
 *       Super Admin or shop Admin. ADMIN or EMPLOYEE only. Updates `users.location_id`
 *       (and parent/shop name). Shop Admin: person must be in their shop. Dest must be
 *       active. Employee dest must not already have an employee; employee must be
 *       checked out first. Inventory stays at the old location.
 *     tags: [Shops]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: employeeId
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/TransferEmployeeRequest'
 *     responses:
 *       200:
 *         description: Employee moved
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/TransferEmployeeResponse'
 *       400:
 *         description: Same location, inactive dest, or employee is checked in
 *       401:
 *         description: Unauthorized
 *       403:
 *         description: Super Admin or shop Admin; employee out of shop Admin scope
 *       404:
 *         description: Admin or employee not found
 *       409:
 *         description: Destination already has an employee
 */
router.patch(
  '/employees/:employeeId/location',
  authenticate,
  requireAdmin,
  validateRequest(transferEmployeeSchema),
  shopsController.transferEmployee
);

router.get(
  '/sellers/:sellerId',
  authenticate,
  requireAdmin,
  validateRequest(viewSellerSchema),
  shopsController.viewSeller
);

module.exports = router;
