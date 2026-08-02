const shopsRepository = require('./shops.repository');

/**
 * Shops Service
 *
 * Contains all business logic for the shops module.
 * Orchestrates transactions and interacts with the repository layer.
 * Does not access Express req/res directly.
 */
class ShopsService {
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

    const locationId = Number(seller.locationId);
    const [location, users] = await Promise.all([
      shopsRepository.findLocationById(locationId),
      shopsRepository.findUsersByLocationId(locationId),
    ]);

    const mapUser = (u) => ({
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
    });

    return {
      location: location
        ? {
            id: Number(location.id),
            code: location.code,
            name: location.name,
            type: location.type,
            is_active: location.isActive,
          }
        : null,
      sellers: users.filter((u) => u.role === 'SELLER').map(mapUser),
      employees: users.filter((u) => u.role === 'EMPLOYEE').map(mapUser),
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
