# friends_battery_api.model.UpdateStockRequest

## Load the model package
```dart
import 'package:friends_battery_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**productNameId** | **int** |  | 
**productModelId** | **int** |  | 
**quantity** | **int** | Units to add as STK- placeholders; optional when only updating price/flags. Do not send with serial_numbers. | [optional] 
**serialNumbers** | **BuiltList&lt;String&gt;** | Scanned serials to add as units. Quantity = length. Do not send with quantity. | [optional] 
**minSellPrice** | **num** |  | [optional] 
**minUnitCountAdmin** | **int** |  | [optional] 
**minUnitCountSeller** | **int** |  | [optional] 
**onSale** | **bool** |  | [optional] 
**locationId** | **int** | Target warehouse/location for new units. Omit for actor location or default WH. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


