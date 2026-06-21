# friends_battery_api.api.ShopsApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**shopsGet**](ShopsApi.md#shopsget) | **GET** /shops | Retrieve a list of shops


# **shopsGet**
> BuiltList<ShopsGet200ResponseInner> shopsGet()

Retrieve a list of shops

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShopsApi();

try {
    final response = api.shopsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShopsApi->shopsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ShopsGet200ResponseInner&gt;**](ShopsGet200ResponseInner.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

