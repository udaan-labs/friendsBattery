import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for ShopsApi
void main() {
  final instance = FriendsBatteryApi().getShopsApi();

  group(ShopsApi, () {
    // List job titles for employees (Manager, Cashier, …)
    //
    //Future<EmployeeRolesResponse> apiShopsEmployeeRolesGet() async
    test('test apiShopsEmployeeRolesGet', () async {
      // TODO
    });

    // Admin view one employee (profile + check-in/check-out only)
    //
    // Admin only. Returns EMPLOYEE user profile and an `actions` timeline limited to CHECK_IN and CHECK_OUT (from employee_attendance). Does not include sales, inventory, or seller data. 
    //
    //Future<AdminEmployeeDetailResponse> apiShopsEmployeesEmployeeIdGet(int employeeId, { int limit }) async
    test('test apiShopsEmployeesEmployeeIdGet', () async {
      // TODO
    });

    // Create an employee at a shop or warehouse
    //
    // **Seller:** employee is always assigned to the seller's `location_id` (body `location_id` is ignored). Seller must have a location. **Admin:** body `location_id` is required (WAREHOUSE or SHOP). New employees are active and verified (can log in immediately). 
    //
    //Future<CreateEmployeeResponse> apiShopsEmployeesPost(CreateEmployeeRequest createEmployeeRequest) async
    test('test apiShopsEmployeesPost', () async {
      // TODO
    });

    // List active locations (warehouse + shops)
    //
    // Admin only. Optional type filter for shops vs warehouses.
    //
    //Future<LocationsListResponse> apiShopsLocationsGet({ String type }) async
    test('test apiShopsLocationsGet', () async {
      // TODO
    });

    // Sellers and employees assigned to this location
    //
    // Admin only. Returns SELLER and EMPLOYEE users with users.location_id equal to this shop/warehouse. 
    //
    //Future<ShopStaffResponse> apiShopsLocationsLocationIdStaffGet(int locationId) async
    test('test apiShopsLocationsLocationIdStaffGet', () async {
      // TODO
    });

    // Create a shop or warehouse location
    //
    // Admin only. Creates an active location used for seller assignment, employees, and inventory placement. Optional latitude/longitude set the attendance geofence center (both required together); allowed_radius defaults to 100m. 
    //
    //Future<CreateLocationResponse> apiShopsLocationsPost(CreateLocationRequest createLocationRequest) async
    test('test apiShopsLocationsPost', () async {
      // TODO
    });

    // Seller — staff at own shop location
    //
    //Future<ShopStaffResponse> apiShopsMyStaffGet() async
    test('test apiShopsMyStaffGet', () async {
      // TODO
    });

    // Return all sellers
    //
    //Future<SellersListResponse> apiShopsSellersGet() async
    test('test apiShopsSellersGet', () async {
      // TODO
    });

    // Return one seller
    //
    //Future<SellerDetailResponse> apiShopsSellersSellerIdGet(int sellerId, { bool includeOutOfStock }) async
    test('test apiShopsSellersSellerIdGet', () async {
      // TODO
    });

    // Sellers and employees at the same shop location as this seller
    //
    // Admin only. Uses the seller's users.location_id. Returns only SELLER and EMPLOYEE users assigned to that location. Empty lists if seller has no location. 
    //
    //Future<ShopStaffResponse> apiShopsSellersSellerIdStaffGet(int sellerId) async
    test('test apiShopsSellersSellerIdStaffGet', () async {
      // TODO
    });

  });
}
