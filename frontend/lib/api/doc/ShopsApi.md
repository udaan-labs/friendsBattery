# friends_battery_api.api.ShopsApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiShopsEmployeeRolesGet**](ShopsApi.md#apishopsemployeerolesget) | **GET** /api/shops/employee-roles | List job titles for employees (Manager, Cashier, …)
[**apiShopsEmployeesEmployeeIdGet**](ShopsApi.md#apishopsemployeesemployeeidget) | **GET** /api/shops/employees/{employeeId} | Admin view one employee (profile + check-in/check-out only)
[**apiShopsEmployeesPost**](ShopsApi.md#apishopsemployeespost) | **POST** /api/shops/employees | Create an employee at a shop or warehouse
[**apiShopsLocationsGet**](ShopsApi.md#apishopslocationsget) | **GET** /api/shops/locations | List active locations (warehouse + shops)
[**apiShopsLocationsLocationIdStaffGet**](ShopsApi.md#apishopslocationslocationidstaffget) | **GET** /api/shops/locations/{locationId}/staff | Admin, sellers and employees assigned to this location
[**apiShopsLocationsPost**](ShopsApi.md#apishopslocationspost) | **POST** /api/shops/locations | Create a shop or warehouse location
[**apiShopsMyStaffGet**](ShopsApi.md#apishopsmystaffget) | **GET** /api/shops/my-staff | Seller — staff at own shop location
[**apiShopsSellersGet**](ShopsApi.md#apishopssellersget) | **GET** /api/shops/sellers | Return all sellers
[**apiShopsSellersSellerIdGet**](ShopsApi.md#apishopssellersselleridget) | **GET** /api/shops/sellers/{sellerId} | Return one seller
[**apiShopsSellersSellerIdStaffGet**](ShopsApi.md#apishopssellersselleridstaffget) | **GET** /api/shops/sellers/{sellerId}/staff | Sellers and employees at the same shop location as this seller


# **apiShopsEmployeeRolesGet**
> EmployeeRolesResponse apiShopsEmployeeRolesGet()

List job titles for employees (Manager, Cashier, …)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();

try {
    final response = api.apiShopsEmployeeRolesGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->apiShopsEmployeeRolesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**EmployeeRolesResponse**](EmployeeRolesResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShopsEmployeesEmployeeIdGet**
> AdminEmployeeDetailResponse apiShopsEmployeesEmployeeIdGet(employeeId, limit)

Admin view one employee (profile + check-in/check-out only)

Admin only. Returns EMPLOYEE user profile and an `actions` timeline limited to CHECK_IN and CHECK_OUT (from employee_attendance). Does not include sales, inventory, or seller data. 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();
final int employeeId = 56; // int | 
final int limit = 56; // int | Max attendance rows to expand into actions

try {
    final response = api.apiShopsEmployeesEmployeeIdGet(employeeId, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->apiShopsEmployeesEmployeeIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **employeeId** | **int**|  | 
 **limit** | **int**| Max attendance rows to expand into actions | [optional] [default to 50]

### Return type

[**AdminEmployeeDetailResponse**](AdminEmployeeDetailResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShopsEmployeesPost**
> CreateEmployeeResponse apiShopsEmployeesPost(createEmployeeRequest)

Create an employee at a shop or warehouse

**Seller:** employee is always assigned to the seller's `location_id` (body `location_id` is ignored). Seller must have a location. **Admin:** body `location_id` is required (WAREHOUSE or SHOP). New employees are active and verified (can log in immediately). 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();
final CreateEmployeeRequest createEmployeeRequest = ; // CreateEmployeeRequest | 

try {
    final response = api.apiShopsEmployeesPost(createEmployeeRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->apiShopsEmployeesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createEmployeeRequest** | [**CreateEmployeeRequest**](CreateEmployeeRequest.md)|  | 

### Return type

[**CreateEmployeeResponse**](CreateEmployeeResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShopsLocationsGet**
> LocationsListResponse apiShopsLocationsGet(type)

List active locations (warehouse + shops)

Admin only. Optional type filter for shops vs warehouses.

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();
final String type = type_example; // String | Filter by location type

try {
    final response = api.apiShopsLocationsGet(type);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->apiShopsLocationsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type** | **String**| Filter by location type | [optional] 

### Return type

[**LocationsListResponse**](LocationsListResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShopsLocationsLocationIdStaffGet**
> ShopStaffResponse apiShopsLocationsLocationIdStaffGet(locationId)

Admin, sellers and employees assigned to this location

Admin only. Returns ADMIN, SELLER and EMPLOYEE users with users.location_id equal to this shop/warehouse. 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();
final int locationId = 56; // int | 

try {
    final response = api.apiShopsLocationsLocationIdStaffGet(locationId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->apiShopsLocationsLocationIdStaffGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **locationId** | **int**|  | 

### Return type

[**ShopStaffResponse**](ShopStaffResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShopsLocationsPost**
> CreateLocationResponse apiShopsLocationsPost(createLocationRequest)

Create a shop or warehouse location

Admin only. Creates an active location used for seller assignment, employees, and inventory placement. Optional latitude/longitude set the attendance geofence center (both required together); allowed_radius defaults to 100m. SHOP requires warehouse_id of an active warehouse. WAREHOUSE has no parent. 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();
final CreateLocationRequest createLocationRequest = ; // CreateLocationRequest | 

try {
    final response = api.apiShopsLocationsPost(createLocationRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->apiShopsLocationsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createLocationRequest** | [**CreateLocationRequest**](CreateLocationRequest.md)|  | 

### Return type

[**CreateLocationResponse**](CreateLocationResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShopsMyStaffGet**
> ShopStaffResponse apiShopsMyStaffGet()

Seller — staff at own shop location

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();

try {
    final response = api.apiShopsMyStaffGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->apiShopsMyStaffGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ShopStaffResponse**](ShopStaffResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShopsSellersGet**
> SellersListResponse apiShopsSellersGet()

Return all sellers

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();

try {
    final response = api.apiShopsSellersGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->apiShopsSellersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SellersListResponse**](SellersListResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShopsSellersSellerIdGet**
> SellerDetailResponse apiShopsSellersSellerIdGet(sellerId, includeOutOfStock)

Return one seller

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();
final int sellerId = 56; // int | 
final bool includeOutOfStock = true; // bool | 

try {
    final response = api.apiShopsSellersSellerIdGet(sellerId, includeOutOfStock);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->apiShopsSellersSellerIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sellerId** | **int**|  | 
 **includeOutOfStock** | **bool**|  | [optional] 

### Return type

[**SellerDetailResponse**](SellerDetailResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShopsSellersSellerIdStaffGet**
> ShopStaffResponse apiShopsSellersSellerIdStaffGet(sellerId)

Sellers and employees at the same shop location as this seller

Admin only. Uses the seller's users.location_id. Returns only SELLER and EMPLOYEE users assigned to that location. Empty lists if seller has no location. 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();
final int sellerId = 56; // int | 

try {
    final response = api.apiShopsSellersSellerIdStaffGet(sellerId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->apiShopsSellersSellerIdStaffGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sellerId** | **int**|  | 

### Return type

[**ShopStaffResponse**](ShopStaffResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

