# friends_battery_api.api.SalesApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSalesAdminHistoryGet**](SalesApi.md#apisalesadminhistoryget) | **GET** /api/sales/admin/history | Return all sales across all sellers with pagination, search, filters, and shipment tracing (Admin only)
[**apiSalesGet**](SalesApi.md#apisalesget) | **GET** /api/sales | Return all sales based on role (Admin sees all, Seller sees own)
[**apiSalesHistoryGet**](SalesApi.md#apisaleshistoryget) | **GET** /api/sales/history | Return seller&#39;s own sales history with pagination, search, and date filtering
[**apiSalesPost**](SalesApi.md#apisalespost) | **POST** /api/sales | Create a sale (SA/Admin/Seller own units; EMPLOYEE location stock)
[**apiSalesRentPost**](SalesApi.md#apisalesrentpost) | **POST** /api/sales/rent | Rent battery out with deposit (unit → RENTED)
[**apiSalesRentReturnPost**](SalesApi.md#apisalesrentreturnpost) | **POST** /api/sales/rent/return | Return rented battery — fee from deposit, refund rest
[**apiSalesServicePost**](SalesApi.md#apisalesservicepost) | **POST** /api/sales/service | Create a service bill (no stock move)
[**apiSalesTransactionIdGet**](SalesApi.md#apisalestransactionidget) | **GET** /api/sales/{transactionId} | Return a single sale&#39;s details by ID


# **apiSalesAdminHistoryGet**
> AdminSaleHistoryResponse apiSalesAdminHistoryGet(page, limit, search, sellerId, fromDate, toDate, shipmentStatus)

Return all sales across all sellers with pagination, search, filters, and shipment tracing (Admin only)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String search = search_example; // String | Search by customer name, seller name, shop name, product name, or serial number
final int sellerId = 56; // int | Filter by specific seller ID
final DateTime fromDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime toDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final String shipmentStatus = shipmentStatus_example; // String | 

try {
    final response = api.apiSalesAdminHistoryGet(page, limit, search, sellerId, fromDate, toDate, shipmentStatus);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesAdminHistoryGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **limit** | **int**|  | [optional] [default to 10]
 **search** | **String**| Search by customer name, seller name, shop name, product name, or serial number | [optional] 
 **sellerId** | **int**| Filter by specific seller ID | [optional] 
 **fromDate** | **DateTime**|  | [optional] 
 **toDate** | **DateTime**|  | [optional] 
 **shipmentStatus** | **String**|  | [optional] 

### Return type

[**AdminSaleHistoryResponse**](AdminSaleHistoryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSalesGet**
> apiSalesGet()

Return all sales based on role (Admin sees all, Seller sees own)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();

try {
    api.apiSalesGet();
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesGet: $e\n');
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

# **apiSalesHistoryGet**
> SaleHistoryResponse apiSalesHistoryGet(page, limit, searchCustomer, searchSerial, fromDate, toDate, filter, date)

Return seller's own sales history with pagination, search, and date filtering

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String searchCustomer = searchCustomer_example; // String | 
final String searchSerial = searchSerial_example; // String | 
final DateTime fromDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime toDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final String filter = filter_example; // String | 
final String date = date_example; // String | 

try {
    final response = api.apiSalesHistoryGet(page, limit, searchCustomer, searchSerial, fromDate, toDate, filter, date);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesHistoryGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **limit** | **int**|  | [optional] [default to 10]
 **searchCustomer** | **String**|  | [optional] 
 **searchSerial** | **String**|  | [optional] 
 **fromDate** | **DateTime**|  | [optional] 
 **toDate** | **DateTime**|  | [optional] 
 **filter** | **String**|  | [optional] 
 **date** | **String**|  | [optional] 

### Return type

[**SaleHistoryResponse**](SaleHistoryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSalesPost**
> CreateSaleResponse apiSalesPost(createSaleRequest)

Create a sale (SA/Admin/Seller own units; EMPLOYEE location stock)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final CreateSaleRequest createSaleRequest = ; // CreateSaleRequest | 

try {
    final response = api.apiSalesPost(createSaleRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createSaleRequest** | [**CreateSaleRequest**](CreateSaleRequest.md)|  | 

### Return type

[**CreateSaleResponse**](CreateSaleResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSalesRentPost**
> CreateRentResponse apiSalesRentPost(createRentRequest)

Rent battery out with deposit (unit → RENTED)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final CreateRentRequest createRentRequest = ; // CreateRentRequest | 

try {
    final response = api.apiSalesRentPost(createRentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesRentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createRentRequest** | [**CreateRentRequest**](CreateRentRequest.md)|  | 

### Return type

[**CreateRentResponse**](CreateRentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSalesRentReturnPost**
> ReturnRentResponse apiSalesRentReturnPost(returnRentRequest)

Return rented battery — fee from deposit, refund rest

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final ReturnRentRequest returnRentRequest = ; // ReturnRentRequest | 

try {
    final response = api.apiSalesRentReturnPost(returnRentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesRentReturnPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **returnRentRequest** | [**ReturnRentRequest**](ReturnRentRequest.md)|  | 

### Return type

[**ReturnRentResponse**](ReturnRentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSalesServicePost**
> CreateServiceBillResponse apiSalesServicePost(createServiceBillRequest)

Create a service bill (no stock move)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final CreateServiceBillRequest createServiceBillRequest = ; // CreateServiceBillRequest | 

try {
    final response = api.apiSalesServicePost(createServiceBillRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesServicePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createServiceBillRequest** | [**CreateServiceBillRequest**](CreateServiceBillRequest.md)|  | 

### Return type

[**CreateServiceBillResponse**](CreateServiceBillResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSalesTransactionIdGet**
> SaleDetailResponse apiSalesTransactionIdGet(transactionId)

Return a single sale's details by ID

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final int transactionId = 56; // int | 

try {
    final response = api.apiSalesTransactionIdGet(transactionId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesTransactionIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **transactionId** | **int**|  | 

### Return type

[**SaleDetailResponse**](SaleDetailResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

