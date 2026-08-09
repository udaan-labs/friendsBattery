const bcrypt = require('bcrypt');
const shopsRepository = require('./shops.repository');
const authRepository = require('../auth/auth.repository');
const ROLES = require('../../shared/constants/roles');

/**
 * Shops Service
 *
 * Contains all business logic for the shops module.
 * Orchestrates transactions and interacts with the repository layer.
 * Does not access Express req/res directly.
 */
class ShopsService {
  _mapStaffUser(u) {
    return {
      id: Number(u.id),
      user_id: u.userId,
      user_name: u.userName,
      user_number: u.userNumber,
      shop_name: u.shopName,
      role: u.role,
      is_active: u.isActive,
      is_verified: u.isVerified,
      employee_role: u.employeeRole
        ? {
            id: Number(u.employeeRole.id),
            name: u.employeeRole.name,
            description: u.employeeRole.description,
          }
        : null,
    };
  }

  _mapLocationBrief(location) {
    if (!location) return null;
    return {
      id: Number(location.id),
      code: location.code,
      name: location.name,
      type: location.type,
      is_active: location.isActive != null ? location.isActive : true,
    };
  }

  async _staffAtLocation(locationId) {
    const [location, users] = await Promise.all([
      shopsRepository.findLocationById(locationId),
      shopsRepository.findUsersByLocationId(locationId),
    ]);

    return {
      location: this._mapLocationBrief(location),
      sellers: users.filter((u) => u.role === 'SELLER').map((u) => this._mapStaffUser(u)),
      employees: users.filter((u) => u.role === 'EMPLOYEE').map((u) => this._mapStaffUser(u)),
    };
  }
  /**
   * Fetch all active sellers.
   * Output: Array of sellers mapped to response format
   */
  async getSellers() {
    const sellers = await shopsRepository.findSellers();
    const dashboardRepository = require('../dashboard/dashboard.repository');

    // Fetch low stock sellers efficiently
    const lowStockSellerIds = await shopsRepository.getLowStockSellers();
    const lowStockSellerIdSet = new Set(lowStockSellerIds);

    // Enrich each seller with live stats in parallel
    const enriched = await Promise.all(
      sellers.map(async (user) => {
        const [totalStock, todaySales, pendingShipments] = await Promise.all([
          dashboardRepository.getSellerTotalStock(user.id),
          dashboardRepository.getSellerTodaySales(user.id),
          dashboardRepository.getSellerPendingShipmentsCount(user.id)
        ]);
        return {
          id: Number(user.id),
          user_name: user.userName,
          shop_name: user.shopName,
          user_number: user.userNumber,
          is_verified: user.isVerified,
          is_active: user.isActive,
          created_at: user.createdAt,
          totalStock,
          todaySales: todaySales.count,
          todaySalesAmount: todaySales.amount,
          pendingShipments,
          hasLowStock: lowStockSellerIdSet.has(Number(user.id))
        };
      })
    );

    return enriched;
  }

  /**
   * Fetch details of a single seller.
   * Input: sellerId
   * Output: Seller details mapped to response format
   */
  async viewSeller(sellerId, includeOutOfStock = false) {
    const inventoryService = require('../inventory/inventory.service');
    // We use Promise.all() to execute independent database queries in parallel.
    // This reduces the total response time instead of waiting for each query sequentially.
    const [
      user,
      stockCount,
      productsCount,
      salesCount,
      returnsCount,
      inventoryData
    ] = await Promise.all([
      shopsRepository.findSellerById(sellerId),
      shopsRepository.getSellerStock(sellerId),
      shopsRepository.getSellerProductsCount(sellerId),
      shopsRepository.getSellerSalesCount(sellerId),
      shopsRepository.getSellerReturnsCount(sellerId),
      inventoryService.getInventory(sellerId, 'SELLER', { page: 1, limit: 1000000, includeOutOfStock })
    ]);

    if (!user) {
      const error = new Error('Seller not found');
      error.statusCode = 404;
      throw error;
    }

    return {
      id: Number(user.id),
      user_name: user.userName,
      shop_name: user.shopName,
      user_number: user.userNumber,
      is_active: user.isActive,
      is_verified: user.isVerified,
      location_id: user.locationId != null ? Number(user.locationId) : null,
      location: user.location
        ? {
            id: Number(user.location.id),
            code: user.location.code,
            name: user.location.name,
            type: user.location.type,
            is_active: user.location.isActive,
          }
        : null,
      statistics: {
        stock: stockCount,
        products: productsCount,
        sales: salesCount,
        returns: returnsCount
      },
      inventory: inventoryData.data,
      created_at: user.createdAt
    };
  }

  /**
   * Sellers + employees at the same shop location as this seller.
   * Admin: see who works at this shop.
   */
  async getShopStaffBySellerId(sellerId) {
    const seller = await shopsRepository.findSellerById(sellerId);
    if (!seller) {
      const error = new Error('Seller not found');
      error.statusCode = 404;
      throw error;
    }

    if (seller.locationId == null) {
      return {
        location: null,
        sellers: [],
        employees: [],
      };
    }

    return this._staffAtLocation(Number(seller.locationId));
  }

  /**
   * Seller: staff at own assigned shop location.
   * @param {number} sellerUserId - numeric users.id from JWT/auth
   */
  async getMyStaff(sellerUserId) {
    const seller = await shopsRepository.findUserById(sellerUserId);
    if (!seller || seller.role !== ROLES.SELLER) {
      const error = new Error('Seller not found');
      error.statusCode = 404;
      throw error;
    }
    if (seller.locationId == null) {
      return {
        location: null,
        sellers: [],
        employees: [],
      };
    }
    return this._staffAtLocation(Number(seller.locationId));
  }

  /** Admin: sellers + employees assigned to a shop/warehouse. */
  async getStaffByLocationId(locationId) {
    const data = await this._staffAtLocation(Number(locationId));
    if (!data.location) {
      const error = new Error('Location not found');
      error.statusCode = 404;
      throw error;
    }
    return data;
  }

  async listEmployeeRoles() {
    const roles = await shopsRepository.findAllEmployeeRoles();
    return roles.map((r) => ({
      id: Number(r.id),
      name: r.name,
      description: r.description,
    }));
  }

  /**
   * @param {{ type?: 'SHOP'|'WAREHOUSE' }} [filter]
   */
  async listLocations(filter = {}) {
    const rows = await shopsRepository.findActiveLocations(filter);
    return rows.map((loc) => this._mapLocationItem(loc));
  }

  _mapLocationItem(loc) {
    return {
      id: Number(loc.id),
      code: loc.code,
      name: loc.name,
      type: loc.type,
      is_active: loc.isActive,
      address: loc.address ?? null,
      phone: loc.phone ?? null,
      latitude: loc.latitude != null ? Number(loc.latitude) : null,
      longitude: loc.longitude != null ? Number(loc.longitude) : null,
      allowed_radius:
        loc.allowedRadius != null ? Number(loc.allowedRadius) : 100,
    };
  }

  /** Admin create SHOP/WAREHOUSE. Optional lat/lng = attendance geofence. */
  async createLocation(body) {
    const code = body.code;
    const existing = await shopsRepository.findLocationByCode(code);
    if (existing) {
      const error = new Error(`Location code already exists: ${code}`);
      error.statusCode = 409;
      throw error;
    }

    const lat = body.latitude != null ? Number(body.latitude) : null;
    const lng = body.longitude != null ? Number(body.longitude) : null;
    const hasGeo =
      lat != null && lng != null && !Number.isNaN(lat) && !Number.isNaN(lng);

    const created = await shopsRepository.createLocation({
      code,
      name: body.name,
      type: body.type,
      address: body.address ?? null,
      phone: body.phone ?? null,
      latitude: hasGeo ? lat : null,
      longitude: hasGeo ? lng : null,
      allowedRadius:
        body.allowed_radius != null ? Number(body.allowed_radius) : undefined,
    });

    return this._mapLocationItem(created);
  }

  /**
   * Create EMPLOYEE at a location.
   * - SELLER: always own location_id (client location_id ignored)
   * - ADMIN: location_id required (warehouse or any shop)
   *
   * @param {{ id: number, role: string }} actor - from req.user
   * @param {object} body - validated create body
   */
  async createEmployee(actor, body) {
    const {
      user_id,
      username,
      user_number,
      password,
      employee_role_id,
      location_id,
    } = body;

    let locationId;
    let shopName;

    if (actor.role === ROLES.SELLER) {
      const seller = await shopsRepository.findUserById(actor.id);
      if (!seller || seller.role !== ROLES.SELLER) {
        const error = new Error('Seller not found');
        error.statusCode = 404;
        throw error;
      }
      if (seller.locationId == null) {
        const error = new Error(
          'Your account has no shop location. Contact admin before adding employees.'
        );
        error.statusCode = 400;
        throw error;
      }
      locationId = Number(seller.locationId);
      shopName = seller.shopName || null;
    } else if (actor.role === ROLES.ADMIN) {
      if (location_id == null) {
        const error = new Error('location_id is required');
        error.statusCode = 400;
        throw error;
      }
      const location = await shopsRepository.findLocationById(location_id);
      if (!location || location.isActive === false) {
        const error = new Error('Location not found or inactive');
        error.statusCode = 400;
        throw error;
      }
      locationId = Number(location.id);
      shopName = location.name;
    } else {
      const error = new Error('Forbidden');
      error.statusCode = 403;
      throw error;
    }

    let employeeRoleId = null;
    if (employee_role_id != null) {
      const er = await shopsRepository.findEmployeeRoleById(employee_role_id);
      if (!er) {
        const error = new Error('Invalid employee_role_id');
        error.statusCode = 400;
        throw error;
      }
      employeeRoleId = Number(er.id);
    }

    if (await authRepository.findUserByUserId(user_id)) {
      const error = new Error('User ID already exists');
      error.statusCode = 409;
      throw error;
    }
    if (await authRepository.findUserByUsername(username)) {
      const error = new Error('Username already exists');
      error.statusCode = 409;
      throw error;
    }
    if (await authRepository.findUserByNumber(user_number)) {
      const error = new Error('Mobile number already exists');
      error.statusCode = 409;
      throw error;
    }

    const passwordHash = await bcrypt.hash(password, 10);
    const created = await shopsRepository.createEmployeeUser({
      userId: user_id,
      userName: username,
      userNumber: user_number,
      shopName,
      passwordHash,
      role: ROLES.EMPLOYEE,
      locationId: BigInt(locationId),
      employeeRoleId: employeeRoleId != null ? BigInt(employeeRoleId) : null,
      // Ready to log in — managed staff, not open self-register
      isActive: true,
      isVerified: true,
      loginAttempt: 0,
    });

    return {
      ...this._mapStaffUser(created),
      location_id: created.locationId != null ? Number(created.locationId) : null,
      location: this._mapLocationBrief(created.location),
      created_at: created.createdAt,
    };
  }

  /**
   * Admin: view one employee + only employee actions (check-in / check-out).
   * No sales, shipments, inventory, seller stats.
   */
  async viewEmployee(employeeId, { limit = 50 } = {}) {
    const attendanceRepository = require('../attendance/attendance.repository');
    const user = await shopsRepository.findEmployeeById(employeeId);
    if (!user) {
      const error = new Error('Employee not found');
      error.statusCode = 404;
      throw error;
    }

    const [open, history] = await Promise.all([
      attendanceRepository.findOpenAttendance(user.id),
      attendanceRepository.findAttendanceHistory(user.id, { take: limit }),
    ]);

    const mapLoc = (loc) =>
      loc
        ? {
            id: Number(loc.id),
            code: loc.code,
            name: loc.name,
            type: loc.type,
            is_active: loc.isActive != null ? loc.isActive : true,
          }
        : null;

    /** Only CHECK_IN / CHECK_OUT — nothing else. */
    const actions = [];
    for (const row of history) {
      const loc = mapLoc(row.assignedLocation);
      actions.push({
        action: 'CHECK_IN',
        attendance_id: Number(row.id),
        at: row.checkInTime?.toISOString() ?? null,
        lat: row.checkInLat != null ? Number(row.checkInLat) : null,
        lng: row.checkInLng != null ? Number(row.checkInLng) : null,
        address: row.checkInAddress ?? null,
        location: loc,
      });
      if (row.checkOutTime) {
        actions.push({
          action: 'CHECK_OUT',
          attendance_id: Number(row.id),
          at: row.checkOutTime.toISOString(),
          lat: row.checkOutLat != null ? Number(row.checkOutLat) : null,
          lng: row.checkOutLng != null ? Number(row.checkOutLng) : null,
          address: row.checkOutAddress ?? null,
          location: loc,
        });
      }
    }
    actions.sort((a, b) => {
      const ta = a.at ? Date.parse(a.at) : 0;
      const tb = b.at ? Date.parse(b.at) : 0;
      return tb - ta;
    });

    return {
      employee: {
        id: Number(user.id),
        user_id: user.userId,
        user_name: user.userName,
        user_number: user.userNumber,
        shop_name: user.shopName,
        role: 'EMPLOYEE',
        is_active: user.isActive,
        is_verified: user.isVerified,
        location_id: user.locationId != null ? Number(user.locationId) : null,
        location: mapLoc(user.location),
        employee_role: user.employeeRole
          ? {
              id: Number(user.employeeRole.id),
              name: user.employeeRole.name,
              description: user.employeeRole.description,
            }
          : null,
        created_at: user.createdAt,
      },
      is_checked_in: !!open,
      current_attendance: open
        ? {
            id: Number(open.id),
            check_in_time: open.checkInTime?.toISOString() ?? null,
            status: open.status,
            location: mapLoc(open.assignedLocation),
          }
        : null,
      /** Employee-only timeline: CHECK_IN / CHECK_OUT */
      actions,
    };
  }
}

module.exports = new ShopsService();
