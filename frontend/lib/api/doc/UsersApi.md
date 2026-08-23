# friends_battery_api.api.UsersApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiUsersGet**](UsersApi.md#apiusersget) | **GET** /api/users | List admins, sellers, and employees
[**apiUsersIdActivePatch**](UsersApi.md#apiusersidactivepatch) | **PATCH** /api/users/{id}/active | Activate or deactivate an admin, seller, or employee


# **apiUsersGet**
> AccountUsersResponse apiUsersGet(role)

List admins, sellers, and employees

Super Admin only. Filter by ADMIN, SELLER, or EMPLOYEE.

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getUsersApi();
final String role = role_example; // String | 

try {
    final response = api.apiUsersGet(role);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->apiUsersGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **role** | **String**|  | 

### Return type

[**AccountUsersResponse**](AccountUsersResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUsersIdActivePatch**
> SetAccountActiveResponse apiUsersIdActivePatch(id, setAccountActiveRequest)

Activate or deactivate an admin, seller, or employee

Super Admin or Admin. Inactive users cannot log in or use the API. Cannot change self or out-of-scope accounts.

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getUsersApi();
final int id = 56; // int | 
final SetAccountActiveRequest setAccountActiveRequest = ; // SetAccountActiveRequest | 

try {
    final response = api.apiUsersIdActivePatch(id, setAccountActiveRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->apiUsersIdActivePatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **setAccountActiveRequest** | [**SetAccountActiveRequest**](SetAccountActiveRequest.md)|  | 

### Return type

[**SetAccountActiveResponse**](SetAccountActiveResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

