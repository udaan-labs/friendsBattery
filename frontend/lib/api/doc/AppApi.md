# friends_battery_api.api.AppApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAppStatusGet**](AppApi.md#apiappstatusget) | **GET** /api/app/status | App version + maintenance gate status


# **apiAppStatusGet**
> AppStatusResponse apiAppStatusGet()

App version + maintenance gate status

Public endpoint for Flutter splash / app gate. Clients compare local version to `latest_version` and block on `maintenance`. 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getAppApi();

try {
    final response = api.apiAppStatusGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AppApi->apiAppStatusGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AppStatusResponse**](AppStatusResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

