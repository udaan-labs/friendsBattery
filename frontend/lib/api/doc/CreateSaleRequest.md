# friends_battery_api.model.CreateSaleRequest

## Load the model package
```dart
import 'package:friends_battery_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**productNameId** | **int** |  | 
**productModelId** | **int** |  | 
**serialNumber** | **String** |  | 
**customerName** | **String** |  | 
**customerNumber** | **String** |  | 
**vehicleNumber** | **String** |  | [optional] 
**sellPrice** | **num** |  | 
**saleType** | **String** | SCRAP/MECHANIC waive product min price; SCRAP requires scrap_serial | [optional] [default to 'NORMAL']
**scrapSerial** | **String** | Old battery serial when sale_type=SCRAP | [optional] 
**paymentMode** | **String** | CREDIT = unpaid or partial | [optional] [default to 'CASH']
**amountPaid** | **num** | Paid now when payment_mode is CREDIT (0..sell_price). Ignored for CASH/ONLINE. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


