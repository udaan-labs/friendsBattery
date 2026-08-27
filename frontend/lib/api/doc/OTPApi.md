# friends_battery_api.api.OTPApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiOtpSendPost**](OTPApi.md#apiotpsendpost) | **POST** /api/otp/send | Send OTP for current user (reusable purposes)
[**apiOtpVerifyPost**](OTPApi.md#apiotpverifypost) | **POST** /api/otp/verify | Verify OTP for current user


# **apiOtpSendPost**
> OtpSendResponse apiOtpSendPost(apiOtpSendPostRequest)

Send OTP for current user (reusable purposes)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getOTPApi();
final ApiOtpSendPostRequest apiOtpSendPostRequest = ; // ApiOtpSendPostRequest | 

try {
    final response = api.apiOtpSendPost(apiOtpSendPostRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OTPApi->apiOtpSendPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiOtpSendPostRequest** | [**ApiOtpSendPostRequest**](ApiOtpSendPostRequest.md)|  | 

### Return type

[**OtpSendResponse**](OtpSendResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiOtpVerifyPost**
> OtpVerifyResponse apiOtpVerifyPost(apiOtpVerifyPostRequest)

Verify OTP for current user

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getOTPApi();
final ApiOtpVerifyPostRequest apiOtpVerifyPostRequest = ; // ApiOtpVerifyPostRequest | 

try {
    final response = api.apiOtpVerifyPost(apiOtpVerifyPostRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OTPApi->apiOtpVerifyPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiOtpVerifyPostRequest** | [**ApiOtpVerifyPostRequest**](ApiOtpVerifyPostRequest.md)|  | 

### Return type

[**OtpVerifyResponse**](OtpVerifyResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

