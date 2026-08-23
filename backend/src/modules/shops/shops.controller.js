const shopsService = require('./shops.service');
const { successResponse } = require('../../shared/utils/response');
const { handleRouteError } = require('../../shared/utils/handle-route-error');

/**
 * Shops Controller
 *
 * Handles incoming shops HTTP requests.
 * Delegates business logic to ShopsService.
 * Does not contain business logic.
 */
class ShopsController {
  /**
   * Get all sellers.
   *
   * Controller responsibility:
   * - Receive HTTP request
   * - Delegate business logic to service
   * - Return standardized response
   */
  async getSellers(req, res) {
    try {
      const sellers = await shopsService.getSellers(req.user);

      return successResponse(res, 200, 'Sellers fetched successfully', sellers);
    } catch (error) {
      return handleRouteError(res, error, 'Get Sellers Error:');
    }
  }

  /**
   * View details of a single seller.
   *
   * Controller responsibility:
   * - Receive HTTP request
   * - Delegate business logic to service
   * - Return standardized response
   */
  async viewSeller(req, res) {
    try {
      const { sellerId } = req.params;
      const { includeOutOfStock } = req.query;

      const seller = await shopsService.viewSeller(
        Number(sellerId),
        includeOutOfStock,
        req.user
      );

      return successResponse(res, 200, 'Seller fetched successfully', seller);
    } catch (error) {
      return handleRouteError(res, error, 'View Seller Error:');
    }
  }

  /**
   * GET /api/shops/sellers/:sellerId/staff
   * Sellers + employees at the same location as this seller.
   */
  async getShopStaff(req, res) {
    try {
      const { sellerId } = req.params;
      const data = await shopsService.getShopStaffBySellerId(Number(sellerId), req.user);
      return successResponse(res, 200, 'Shop staff fetched successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Get Shop Staff Error:');
    }
  }

  /**
   * GET /api/shops/employees/:employeeId
   * Admin: employee profile + check-in / check-out actions only.
   */
  async viewEmployee(req, res) {
    try {
      const { employeeId } = req.params;
      const limit = req.query.limit != null ? Number(req.query.limit) : 50;
      const data = await shopsService.viewEmployee(
        Number(employeeId),
        { limit },
        req.user
      );
      return successResponse(res, 200, 'Employee fetched successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'View Employee Error:');
    }
  }

  /**
   * GET /api/shops/employees/next-user-id
   * Preview next EMP### so the add-employee form can show it.
   */
  async nextEmployeeUserId(req, res) {
    try {
      const user_id = await shopsService.nextEmployeeUserId();
      return successResponse(res, 200, 'Next employee user id', { user_id });
    } catch (error) {
      return handleRouteError(res, error, 'Next Employee User Id Error:');
    }
  }

  /**
   * GET /api/shops/sellers/next-user-id
   * Preview next SEL### so the add-seller form can show it.
   */
  async nextSellerUserId(req, res) {
    try {
      const user_id = await shopsService.nextSellerUserId();
      return successResponse(res, 200, 'Next seller user id', { user_id });
    } catch (error) {
      return handleRouteError(res, error, 'Next Seller User Id Error:');
    }
  }

  /**
   * POST /api/shops/employees
   * Admin or seller creates an EMPLOYEE at a location.
   */
  async createEmployee(req, res) {
    try {
      const data = await shopsService.createEmployee(req.user, req.body);
      return successResponse(res, 201, 'Employee created successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Create Employee Error:');
    }
  }

  /**
   * PATCH /api/shops/employees/:employeeId/location
   * Super Admin or shop Admin: move an admin, seller, or employee.
   */
  async transferEmployee(req, res) {
    try {
      const { employeeId } = req.params;
      const data = await shopsService.transferEmployee(
        req.user,
        Number(employeeId),
        Number(req.body.location_id)
      );
      return successResponse(res, 200, 'Moved successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Transfer Employee Error:');
    }
  }

  /**
   * GET /api/shops/my-staff — seller only, own shop location.
   */
  async getMyStaff(req, res) {
    try {
      const data = await shopsService.getMyStaff(req.user.id);
      return successResponse(res, 200, 'Shop staff fetched successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Get My Staff Error:');
    }
  }

  /**
   * GET /api/shops/locations/:locationId/staff
   * Admin: sellers + employees at this shop/warehouse.
   */
  async getLocationStaff(req, res) {
    try {
      const { locationId } = req.params;
      const data = await shopsService.getStaffByLocationId(Number(locationId), req.user);
      return successResponse(res, 200, 'Shop staff fetched successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Get Location Staff Error:');
    }
  }

  /**
   * GET /api/shops/employee-roles
   */
  async listEmployeeRoles(req, res) {
    try {
      const data = await shopsService.listEmployeeRoles();
      return successResponse(res, 200, 'Employee roles fetched successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'List Employee Roles Error:');
    }
  }

  /**
   * GET /api/shops/locations — admin list (optional ?type=SHOP|WAREHOUSE).
   */
  async listLocations(req, res) {
    try {
      const type = req.query?.type;
      const data = await shopsService.listLocations(type ? { type } : {}, req.user);
      return successResponse(res, 200, 'Locations fetched successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'List Locations Error:');
    }
  }

  /**
   * POST /api/shops/locations — admin create shop or warehouse.
   */
  async createLocation(req, res) {
    try {
      const data = await shopsService.createLocation(req.body, req.user);
      return successResponse(res, 201, 'Location created successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Create Location Error:');
    }
  }

  /**
   * PATCH /api/shops/locations/:locationId — admin update name / map pin.
   */
  async updateLocation(req, res) {
    try {
      const { locationId } = req.params;
      const data = await shopsService.updateLocation(
        Number(locationId),
        req.body,
        req.user
      );
      return successResponse(res, 200, 'Location updated successfully', data);
    } catch (error) {
      return handleRouteError(res, error, 'Update Location Error:');
    }
  }
}

module.exports = new ShopsController();
