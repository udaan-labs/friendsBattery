# friends_battery_api.api.AuthApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAuthActivatePut**](AuthApi.md#apiauthactivateput) | **PUT** /api/auth/activate | Activate and verify a user account
[**apiAuthLoginPost**](AuthApi.md#apiauthloginpost) | **POST** /api/auth/login | Authenticate user and return token
[**apiAuthLogoutPost**](AuthApi.md#apiauthlogoutpost) | **POST** /api/auth/logout | End session (closes employee_sessions for EMPLOYEE)
[**apiAuthRegisterPost**](AuthApi.md#apiauthregisterpost) | **POST** /api/auth/register | Register a new user


# **apiAuthActivatePut**
> apiAuthActivatePut(apiAuthActivatePutRequest)

Activate and verify a user account

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getAuthApi();
final ApiAuthActivatePutRequest apiAuthActivatePutRequest = ; // ApiAuthActivatePutRequest | 

try {
    api.apiAuthActivatePut(apiAuthActivatePutRequest);
} on DioException catch (e) {
    print('Exception when calling AuthApi->apiAuthActivatePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiAuthActivatePutRequest** | [**ApiAuthActivatePutRequest**](ApiAuthActivatePutRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAuthLoginPost**
> LoginResponse apiAuthLoginPost(apiAuthLoginPostRequest)

Authenticate user and return token

Works for SUPER_ADMIN, ADMIN, SELLER, and EMPLOYEE. EMPLOYEE login may include location / employee_role on user and session_id (employee_sessions). 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getAuthApi();
final ApiAuthLoginPostRequest apiAuthLoginPostRequest = ; // ApiAuthLoginPostRequest | 

try {
    final response = api.apiAuthLoginPost(apiAuthLoginPostRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->apiAuthLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiAuthLoginPostRequest** | [**ApiAuthLoginPostRequest**](ApiAuthLoginPostRequest.md)|  | 

### Return type

[**LoginResponse**](LoginResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAuthLogoutPost**
> apiAuthLogoutPost()

End session (closes employee_sessions for EMPLOYEE)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getAuthApi();

try {
    api.apiAuthLogoutPost();
} on DioException catch (e) {
    print('Exception when calling AuthApi->apiAuthLogoutPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAuthRegisterPost**
> RegisterResponse apiAuthRegisterPost(apiAuthRegisterPostRequest)

Register a new user

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getAuthApi();
final ApiAuthRegisterPostRequest apiAuthRegisterPostRequest = ; // ApiAuthRegisterPostRequest | 

try {
    final response = api.apiAuthRegisterPost(apiAuthRegisterPostRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->apiAuthRegisterPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiAuthRegisterPostRequest** | [**ApiAuthRegisterPostRequest**](ApiAuthRegisterPostRequest.md)|  | 

### Return type

[**RegisterResponse**](RegisterResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

