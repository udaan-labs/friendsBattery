// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (Serializers().toBuilder()
      ..add(ApiAuthActivatePutRequest.serializer)
      ..add(ApiAuthLoginPostRequest.serializer)
      ..add(ApiAuthRegisterPostRequest.serializer)
      ..add(Category.serializer)
      ..add(Customer.serializer)
      ..add(Error.serializer)
      ..add(InventoryTransaction.serializer)
      ..add(InventoryTransactionActionEnum.serializer)
      ..add(Product.serializer)
      ..add(ProductModel.serializer)
      ..add(ProductName.serializer)
      ..add(ProductUnit.serializer)
      ..add(ProductUnitStatusEnum.serializer)
      ..add(ReturnProduct.serializer)
      ..add(SalesTransaction.serializer)
      ..add(Shipment.serializer)
      ..add(ShipmentItem.serializer)
      ..add(ShipmentStatusEnum.serializer)
      ..add(ShopsGet200ResponseInner.serializer)
      ..add(StockRequest.serializer)
      ..add(StockRequestItem.serializer)
      ..add(StockRequestStatusEnum.serializer)
      ..add(User.serializer)
      ..add(UserRoleEnum.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(JsonObject)]),
          () => ListBuilder<JsonObject>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ShipmentItem)]),
          () => ListBuilder<ShipmentItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(StockRequestItem)]),
          () => ListBuilder<StockRequestItem>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
