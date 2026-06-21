//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:friends_battery_api/src/date_serializer.dart';
import 'package:friends_battery_api/src/model/date.dart';

import 'package:friends_battery_api/src/model/api_auth_activate_put_request.dart';
import 'package:friends_battery_api/src/model/api_auth_login_post_request.dart';
import 'package:friends_battery_api/src/model/api_auth_register_post_request.dart';
import 'package:friends_battery_api/src/model/category.dart';
import 'package:friends_battery_api/src/model/customer.dart';
import 'package:friends_battery_api/src/model/error.dart';
import 'package:friends_battery_api/src/model/inventory_transaction.dart';
import 'package:friends_battery_api/src/model/product.dart';
import 'package:friends_battery_api/src/model/product_model.dart';
import 'package:friends_battery_api/src/model/product_name.dart';
import 'package:friends_battery_api/src/model/product_unit.dart';
import 'package:friends_battery_api/src/model/return_product.dart';
import 'package:friends_battery_api/src/model/sales_transaction.dart';
import 'package:friends_battery_api/src/model/shipment.dart';
import 'package:friends_battery_api/src/model/shipment_item.dart';
import 'package:friends_battery_api/src/model/shops_get200_response_inner.dart';
import 'package:friends_battery_api/src/model/stock_request.dart';
import 'package:friends_battery_api/src/model/stock_request_item.dart';
import 'package:friends_battery_api/src/model/user.dart';

part 'serializers.g.dart';

@SerializersFor([
  ApiAuthActivatePutRequest,
  ApiAuthLoginPostRequest,
  ApiAuthRegisterPostRequest,
  Category,
  Customer,
  Error,
  InventoryTransaction,
  Product,
  ProductModel,
  ProductName,
  ProductUnit,
  ReturnProduct,
  SalesTransaction,
  Shipment,
  ShipmentItem,
  ShopsGet200ResponseInner,
  StockRequest,
  StockRequestItem,
  User,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(InventoryTransaction)]),
        () => ListBuilder<InventoryTransaction>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ShopsGet200ResponseInner)]),
        () => ListBuilder<ShopsGet200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Customer)]),
        () => ListBuilder<Customer>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
