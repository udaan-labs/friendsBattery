const bcrypt = require('bcrypt');
const shopsRepository = require('./shops.repository');
const authRepository = require('../auth/auth.repository');
const ROLES = require('../../shared/constants/roles');
const { httpError } = require('../../shared/utils/http-error');
const orgEventsRepository = require('../../shared/org-events.repository');
const {
  resolveAdminShopScope,
  sellerWhereForShopScope,
  isUserInShopScope,
} = require('../../shared/utils/shop-scope.util');

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
   * Fetch active sellers (SA: all · shop Admin: parent or same location).
   * @param {{ id: number, role: string, locationId?: number|null }} [actor]
   */
  async getSellers(actor) {
    const scope = resolveAdminShopScope(actor || {});
    const sellerWhere = sellerWhereForShopScope(scope);
    const sellers = await shopsRepository.findSellers(
      sellerWhere?.OR ? { OR: sellerWhere.OR } : null
    );
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
   * @param {number} sellerId
   * @param {boolean} includeOutOfStock
   * @param {{ id: number, role: string, locationId?: number|null }} [actor]
   */
  async viewSeller(sellerId, includeOutOfStock = false, actor) {
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
      throw httpError(404, 'Seller not found');
    }

    const scope = resolveAdminShopScope(actor || {});
    if (scope?.kind === 'shop' && !isUserInShopScope(user, scope)) {
      throw httpError(403, 'Forbidden: seller is not under your shop');
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
   * @param {number} sellerId
   * @param {{ id: number, role: string, locationId?: number|null }} [actor]
   */
  async getShopStaffBySellerId(sellerId, actor) {
    const seller = await shopsRepository.findSellerById(sellerId);
    if (!seller) {
      throw httpError(404, 'Seller not found');
    }

    const scope = resolveAdminShopScope(actor || {});
    if (scope?.kind === 'shop' && !isUserInShopScope(seller, scope)) {
      throw httpError(403, 'Forbidden: seller is not under your shop');
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
   * Seller: staff at own shop location, Admin-chain only.
   * Employees/sellers under same parent Admin (or seller if no parent).
   * @param {number} sellerUserId - numeric users.id from JWT/auth
   */
  async getMyStaff(sellerUserId) {
    const seller = await shopsRepository.findUserById(sellerUserId);
    if (!seller || seller.role !== ROLES.SELLER) {
      throw httpError(404, 'Seller not found');
    }
    if (seller.locationId == null) {
      return {
        location: null,
        sellers: [],
        employees: [],
      };
    }

    const locationId = Number(seller.locationId);
    const chainRootId =
      seller.parentId != null ? Number(seller.parentId) : Number(seller.id);

    const [location, users] = await Promise.all([
      shopsRepository.findLocationById(locationId),
      shopsRepository.findUsersByLocationId(locationId),
    ]);

    const inChain = (u) => {
      const parentId = u.parentId != null ? Number(u.parentId) : null;
      if (Number(u.id) === Number(seller.id)) return true;
      if (parentId === chainRootId) return true;
      if (parentId === Number(seller.id)) return true;
      return false;
    };
    const scoped = users.filter(inChain);

    return {
      location: this._mapLocationBrief(location),
      sellers: scoped
        .filter((u) => u.role === 'SELLER')
        .map((u) => this._mapStaffUser(u)),
      employees: scoped
        .filter((u) => u.role === 'EMPLOYEE')
        .map((u) => this._mapStaffUser(u)),
    };
  }

  /**
   * Admin: sellers + employees assigned to a shop/warehouse.
   * Shop Admin: only own shop location.
   * @param {number} locationId
   * @param {{ id: number, role: string, locationId?: number|null }} [actor]
   */
  async getStaffByLocationId(locationId, actor) {
    const scope = resolveAdminShopScope(actor || {});
    if (scope?.kind === 'shop') {
      if (scope.locationId == null || Number(locationId) !== Number(scope.locationId)) {
        throw httpError(403, 'Forbidden: not your shop location');
      }
    }
    const data = await this._staffAtLocation(Number(locationId));
    if (!data.location) {
      throw httpError(404, 'Location not found');
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
   * SA: all active locations. Shop Admin: own SHOP only.
   * @param {{ type?: 'SHOP'|'WAREHOUSE' }} [filter]
   * @param {{ id: number, role: string, locationId?: number|null }} [actor]
   */
  async listLocations(filter = {}, actor) {
    const scope = resolveAdminShopScope(actor || {});
    if (scope?.kind === 'shop') {
      if (filter.type === 'WAREHOUSE') {
        const rows = await shopsRepository.findActiveLocations({ type: 'WAREHOUSE' });
        return rows.map((loc) => this._mapLocationItem(loc));
      }
      if (scope.locationId == null) return [];
      const loc = await shopsRepository.findLocationById(scope.locationId);
      if (!loc || loc.isActive === false) return [];
      if (loc.type !== 'SHOP') return [];
      return [this._mapLocationItem(loc)];
    }
    const rows = await shopsRepository.findActiveLocations(filter);
    return rows.map((loc) => this._mapLocationItem(loc));
  }

  async _nextLocationCode(type) {
    const prefix = type === 'WAREHOUSE' ? 'WH' : 'SHOP';
    const codes = await shopsRepository.findCodesByType(type);
    let max = 0;
    const re = new RegExp(`^${prefix}(\\d+)$`, 'i');
    for (const c of codes) {
      const m = String(c).match(re);
      if (m) max = Math.max(max, parseInt(m[1], 10));
    }
    return `${prefix}${String(max + 1).padStart(3, '0')}`;
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
      warehouse_id: loc.warehouseId != null ? Number(loc.warehouseId) : null,
    };
  }

  /**
   * Create location.
   * SA: SHOP or WAREHOUSE. Shop Admin: SHOP only; one primary shop via location_id.
   * @param {object} body
   * @param {{ id: number, role: string, locationId?: number|null }} [actor]
   */
  async createLocation(body, actor) {
    const scope = resolveAdminShopScope(actor || {});
    let type = body.type;

    if (scope?.kind === 'shop') {
      if (type === 'WAREHOUSE') {
        throw httpError(403, 'Shop Admin can only create shops, not warehouses');
      }
      type = 'SHOP';
      if (scope.locationId != null) {
        throw httpError(
          400,
          'You already have a shop. Super Admin can create additional shops.'
        );
      }
    }

    const code = await this._nextLocationCode(type);

    const lat = body.latitude != null ? Number(body.latitude) : null;
    const lng = body.longitude != null ? Number(body.longitude) : null;
    const hasGeo =
      lat != null && lng != null && !Number.isNaN(lat) && !Number.isNaN(lng);

    let warehouseId = null;
    if (type === 'SHOP') {
      const wh = await shopsRepository.findLocationById(body.warehouse_id);
      if (!wh || wh.isActive === false || wh.type !== 'WAREHOUSE') {
        throw httpError(400, 'warehouse_id must be an active warehouse');
      }
      warehouseId = Number(wh.id);
    }

    const created = await shopsRepository.createLocation({
      code,
      name: body.name,
      type,
      address: body.address ?? null,
      phone: body.phone ?? null,
      latitude: hasGeo ? lat : null,
      longitude: hasGeo ? lng : null,
      allowedRadius:
        body.allowed_radius != null ? Number(body.allowed_radius) : undefined,
      warehouseId,
    });

    // First shop for Admin → bind users.location_id
    if (scope?.kind === 'shop' && scope.locationId == null && actor?.id != null) {
      await shopsRepository.updateUserLocationId(actor.id, created.id);
    }

    await orgEventsRepository.create({
      action: type === 'WAREHOUSE' ? 'WAREHOUSE_CREATED' : 'SHOP_CREATED',
      actorId: actor?.id,
      entityType: 'location',
      entityId: created.id,
      payload: { name: created.name, code: created.code, type, warehouse_id: warehouseId },
    });

    return this._mapLocationItem(created);
  }

  /**
   * Create EMPLOYEE at a location.
   * - SELLER: always own location_id (client location_id ignored); parent → Admin (seller.parentId) or seller
   * - ADMIN / SUPER_ADMIN: location_id required; parent → Admin when actor is ADMIN, else actor
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
    let parentId;

    if (actor.role === ROLES.SELLER) {
      const seller = await shopsRepository.findUserById(actor.id);
      if (!seller || seller.role !== ROLES.SELLER) {
        throw httpError(404, 'Seller not found');
      }
      if (seller.locationId == null) {
        throw httpError(400, 
          'Your account has no shop location. Contact admin before adding employees.'
        );
      }
      locationId = Number(seller.locationId);
      shopName = seller.shopName || null;
      // EMPLOYEE → Admin chain: prefer seller's parent Admin, else seller
      parentId = seller.parentId != null ? Number(seller.parentId) : Number(seller.id);
    } else if (actor.role === ROLES.ADMIN || actor.role === ROLES.SUPER_ADMIN) {
      // Shop Admin: force own shop location (client location_id ignored)
      if (actor.role === ROLES.ADMIN) {
        const admin = await shopsRepository.findUserById(actor.id);
        if (!admin || admin.locationId == null) {
          throw httpError(
            400,
            'Your account has no shop location. Create or assign a shop before adding employees.'
          );
        }
        locationId = Number(admin.locationId);
        const location = await shopsRepository.findLocationById(locationId);
        shopName = location?.name || admin.shopName || null;
        parentId = Number(actor.id);
      } else {
        if (location_id == null) {
          throw httpError(400, 'location_id is required');
        }
        const location = await shopsRepository.findLocationById(location_id);
        if (!location || location.isActive === false) {
          throw httpError(400, 'Location not found or inactive');
        }
        locationId = Number(location.id);
        shopName = location.name;
        // EMPLOYEE → SA (until under a shop Admin)
        parentId = Number(actor.id);
      }
    } else {
      throw httpError(403, 'Forbidden');
    }

    let employeeRoleId = null;
    if (employee_role_id != null) {
      const er = await shopsRepository.findEmployeeRoleById(employee_role_id);
      if (!er) {
        throw httpError(400, 'Invalid employee_role_id');
      }
      employeeRoleId = Number(er.id);
    }

    const employeeTaken = await authRepository.findUserByLocationAndRole(
      locationId,
      ROLES.EMPLOYEE,
    );
    if (employeeTaken) {
      throw httpError(409, 'This location already has an employee');
    }

    if (await authRepository.findUserByUserId(user_id)) {
      throw httpError(409, 'User ID already exists');
    }
    if (await authRepository.findUserByUsername(username)) {
      throw httpError(409, 'Username already exists');
    }
    if (await authRepository.findUserByNumber(user_number)) {
      throw httpError(409, 'Mobile number already exists');
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
      parentId: parentId != null ? BigInt(parentId) : null,
      employeeRoleId: employeeRoleId != null ? BigInt(employeeRoleId) : null,
      // Ready to log in — managed staff, not open self-register
      isActive: true,
      isVerified: true,
      loginAttempt: 0,
    });

    await orgEventsRepository.create({
      action: 'EMPLOYEE_CREATED',
      actorId: actor.id,
      entityType: 'user',
      entityId: created.id,
      payload: {
        username: created.userName,
        location_name: created.location?.name || shopName,
        job_title: created.employeeRole?.name || null,
      },
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
   * @param {number} employeeId
   * @param {{ limit?: number }} [opts]
   * @param {{ id: number, role: string, locationId?: number|null }} [actor]
   */
  async viewEmployee(employeeId, { limit = 50 } = {}, actor) {
    const attendanceRepository = require('../attendance/attendance.repository');
    const user = await shopsRepository.findEmployeeById(employeeId);
    if (!user) {
      throw httpError(404, 'Employee not found');
    }

    const scope = resolveAdminShopScope(actor || {});
    if (scope?.kind === 'shop' && !isUserInShopScope(user, scope)) {
      throw httpError(403, 'Forbidden: employee is not under your shop');
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
