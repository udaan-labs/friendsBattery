# friends_battery_api.api.HealthApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiHealthGet**](HealthApi.md#apihealthget) | **GET** /api/health | Health check


# **apiHealthGet**
> HealthStatus apiHealthGet()

Health check

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getHealthApi();

try {
    final response = api.apiHealthGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling HealthApi->apiHealthGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**HealthStatus**](HealthStatus.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

