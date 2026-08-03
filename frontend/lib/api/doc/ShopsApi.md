# friends_battery_api.api.ShopsApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiShopsEmployeesEmployeeIdGet**](ShopsApi.md#apishopsemployeesemployeeidget) | **GET** /api/shops/employees/{employeeId} | Admin view one employee (profile + check-in/check-out only)
[**apiShopsSellersGet**](ShopsApi.md#apishopssellersget) | **GET** /api/shops/sellers | Return all sellers
[**apiShopsSellersSellerIdGet**](ShopsApi.md#apishopssellersselleridget) | **GET** /api/shops/sellers/{sellerId} | Return one seller
[**apiShopsSellersSellerIdStaffGet**](ShopsApi.md#apishopssellersselleridstaffget) | **GET** /api/shops/sellers/{sellerId}/staff | Sellers and employees at the same shop location as this seller


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

