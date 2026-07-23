# friends_battery_api.api.ProductUnitsApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiProductUnitsVerifyPost**](ProductUnitsApi.md#apiproductunitsverifypost) | **POST** /api/product-units/verify | Verify a product unit by serial or QR


# **apiProductUnitsVerifyPost**
> VerifyProductResponse apiProductUnitsVerifyPost(verifyProductRequest)

Verify a product unit by serial or QR

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductUnitsApi();
final VerifyProductRequest verifyProductRequest = ; // VerifyProductRequest | 

try {
    final response = api.apiProductUnitsVerifyPost(verifyProductRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductUnitsApi->apiProductUnitsVerifyPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **verifyProductRequest** | [**VerifyProductRequest**](VerifyProductRequest.md)|  | 

### Return type

[**VerifyProductResponse**](VerifyProductResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

