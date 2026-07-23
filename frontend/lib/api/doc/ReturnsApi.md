# friends_battery_api.api.ReturnsApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiReturnsPost**](ReturnsApi.md#apireturnspost) | **POST** /api/returns | Process a product return (seller)


# **apiReturnsPost**
> CreateReturnResponse apiReturnsPost(createReturnRequest)

Process a product return (seller)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getReturnsApi();
final CreateReturnRequest createReturnRequest = ; // CreateReturnRequest | 

try {
    final response = api.apiReturnsPost(createReturnRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReturnsApi->apiReturnsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createReturnRequest** | [**CreateReturnRequest**](CreateReturnRequest.md)|  | 

### Return type

[**CreateReturnResponse**](CreateReturnResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

