const shopsService = require('./shops.service');
const { successResponse, errorResponse } = require('../../shared/utils/response');

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
      // Call business layer
      const sellers = await shopsService.getSellers();

      // Return standardized success response
      return successResponse(res, 200, 'Sellers fetched successfully', sellers);
    } catch (error) {
      // Handle unexpected errors
      console.error('Get Sellers Error:', error);
      return errorResponse(res, 500, 'Internal server error');
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

      // Call business layer
      const seller = await shopsService.viewSeller(Number(sellerId), includeOutOfStock);

      // Return standardized success response
      return successResponse(res, 200, 'Seller fetched successfully', seller);
    } catch (error) {
      // Handle unexpected errors
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('View Seller Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * GET /api/shops/sellers/:sellerId/staff
   * Sellers + employees at the same location as this seller.
   */
  async getShopStaff(req, res) {
    try {
      const { sellerId } = req.params;
      const data = await shopsService.getShopStaffBySellerId(Number(sellerId));
      return successResponse(res, 200, 'Shop staff fetched successfully', data);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Get Shop Staff Error:', error);
      return errorResponse(res, 500, 'Internal server error');
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
      const data = await shopsService.viewEmployee(Number(employeeId), { limit });
      return successResponse(res, 200, 'Employee fetched successfully', data);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('View Employee Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * POST /api/shops/employees
   * Admin or seller creates an EMPLOYEE at a location.
   */
  async createEmployee(req, res) {
    try {
      const data = await shopsService.createEmployee(
        { id: req.user.id, role: req.user.role },
        req.body
      );
      return successResponse(res, 201, 'Employee created successfully', data);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Create Employee Error:', error);
      return errorResponse(res, 500, 'Internal server error');
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
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Get My Staff Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * GET /api/shops/locations/:locationId/staff
   * Admin: sellers + employees at this shop/warehouse.
   */
  async getLocationStaff(req, res) {
    try {
      const { locationId } = req.params;
      const data = await shopsService.getStaffByLocationId(Number(locationId));
      return successResponse(res, 200, 'Shop staff fetched successfully', data);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Get Location Staff Error:', error);
      return errorResponse(res, 500, 'Internal server error');
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
      console.error('List Employee Roles Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * GET /api/shops/locations — admin list (optional ?type=SHOP|WAREHOUSE).
   */
  async listLocations(req, res) {
    try {
      const type = req.query?.type;
      const data = await shopsService.listLocations(type ? { type } : {});
      return successResponse(res, 200, 'Locations fetched successfully', data);
    } catch (error) {
      console.error('List Locations Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }

  /**
   * POST /api/shops/locations — admin create shop or warehouse.
   */
  async createLocation(req, res) {
    try {
      const data = await shopsService.createLocation(req.body);
      return successResponse(res, 201, 'Location created successfully', data);
    } catch (error) {
      if (error.statusCode) {
        return errorResponse(res, error.statusCode, error.message);
      }
      console.error('Create Location Error:', error);
      return errorResponse(res, 500, 'Internal server error');
    }
  }
}

module.exports = new ShopsController();
