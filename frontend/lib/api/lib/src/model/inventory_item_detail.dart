//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'inventory_item_detail.g.dart';

/// InventoryItemDetail
///
/// Properties:
/// * [productId] 
/// * [productNameId] 
/// * [productModelId] 
/// * [brand] 
/// * [model] 
/// * [quantity] 
/// * [minPrice] 
/// * [offerPrice] 
/// * [minUnitCountSeller] 
/// * [minUnitCountAdmin] 
/// * [onSale] 
/// * [isLowStock] 
/// * [serialNumbers] 
@BuiltValue()
abstract class InventoryItemDetail implements Built<InventoryItemDetail, InventoryItemDetailBuilder> {
  @BuiltValueField(wireName: r'product_id')
  int? get productId;

  @BuiltValueField(wireName: r'product_name_id')
  int? get productNameId;

  @BuiltValueField(wireName: r'product_model_id')
  int? get productModelId;

  @BuiltValueField(wireName: r'brand')
  String? get brand;

  @BuiltValueField(wireName: r'model')
  String? get model;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  @BuiltValueField(wireName: r'min_price')
  num? get minPrice;

  @BuiltValueField(wireName: r'offer_price')
  num? get offerPrice;

  @BuiltValueField(wireName: r'min_unit_count_seller')
  int? get minUnitCountSeller;

  @BuiltValueField(wireName: r'min_unit_count_admin')
  int? get minUnitCountAdmin;

  @BuiltValueField(wireName: r'on_sale')
  bool? get onSale;

  @BuiltValueField(wireName: r'is_low_stock')
  bool? get isLowStock;

  @BuiltValueField(wireName: r'serial_numbers')
  BuiltList<String>? get serialNumbers;

  InventoryItemDetail._();

  factory InventoryItemDetail([void updates(InventoryItemDetailBuilder b)]) = _$InventoryItemDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InventoryItemDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InventoryItemDetail> get serializer => _$InventoryItemDetailSerializer();
}

class _$InventoryItemDetailSerializer implements PrimitiveSerializer<InventoryItemDetail> {
  @override
  final Iterable<Type> types = const [InventoryItemDetail, _$InventoryItemDetail];

  @override
  final String wireName = r'InventoryItemDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InventoryItemDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productId != null) {
      yield r'product_id';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(int),
      );
    }
    if (object.productNameId != null) {
      yield r'product_name_id';
      yield serializers.serialize(
        object.productNameId,
        specifiedType: const FullType(int),
      );
    }
    if (object.productModelId != null) {
      yield r'product_model_id';
      yield serializers.serialize(
        object.productModelId,
        specifiedType: const FullType(int),
      );
    }
    if (object.brand != null) {
      yield r'brand';
      yield serializers.serialize(
        object.brand,
        specifiedType: const FullType(String),
      );
    }
    if (object.model != null) {
      yield r'model';
      yield serializers.serialize(
        object.model,
        specifiedType: const FullType(String),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(int),
      );
    }
    if (object.minPrice != null) {
      yield r'min_price';
      yield serializers.serialize(
        object.minPrice,
        specifiedType: const FullType(num),
      );
    }
    if (object.offerPrice != null) {
      yield r'offer_price';
      yield serializers.serialize(
        object.offerPrice,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.minUnitCountSeller != null) {
      yield r'min_unit_count_seller';
      yield serializers.serialize(
        object.minUnitCountSeller,
        specifiedType: const FullType(int),
      );
    }
    if (object.minUnitCountAdmin != null) {
      yield r'min_unit_count_admin';
      yield serializers.serialize(
        object.minUnitCountAdmin,
        specifiedType: const FullType(int),
      );
    }
    if (object.onSale != null) {
      yield r'on_sale';
      yield serializers.serialize(
        object.onSale,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isLowStock != null) {
      yield r'is_low_stock';
      yield serializers.serialize(
        object.isLowStock,
        specifiedType: const FullType(bool),
      );
    }
    if (object.serialNumbers != null) {
      yield r'serial_numbers';
      yield serializers.serialize(
        object.serialNumbers,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InventoryItemDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InventoryItemDetailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productId = valueDes;
          break;
        case r'product_name_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productNameId = valueDes;
          break;
        case r'product_model_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productModelId = valueDes;
          break;
        case r'brand':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.brand = valueDes;
          break;
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.model = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.quantity = valueDes;
          break;
        case r'min_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minPrice = valueDes;
          break;
        case r'offer_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.offerPrice = valueDes;
          break;
        case r'min_unit_count_seller':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.minUnitCountSeller = valueDes;
          break;
        case r'min_unit_count_admin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.minUnitCountAdmin = valueDes;
          break;
        case r'on_sale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.onSale = valueDes;
          break;
        case r'is_low_stock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isLowStock = valueDes;
          break;
        case r'serial_numbers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.serialNumbers.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InventoryItemDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InventoryItemDetailBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

