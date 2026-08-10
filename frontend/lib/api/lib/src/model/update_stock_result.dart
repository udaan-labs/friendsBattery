//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_stock_result.g.dart';

/// UpdateStockResult
///
/// Properties:
/// * [productNameId] 
/// * [productModelId] 
/// * [quantity] 
/// * [minSellPrice] 
/// * [minUnitCountAdmin] 
/// * [minUnitCountSeller] 
/// * [onSale] 
/// * [locationId] 
@BuiltValue()
abstract class UpdateStockResult implements Built<UpdateStockResult, UpdateStockResultBuilder> {
  @BuiltValueField(wireName: r'productNameId')
  int? get productNameId;

  @BuiltValueField(wireName: r'productModelId')
  int? get productModelId;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  @BuiltValueField(wireName: r'minSellPrice')
  num? get minSellPrice;

  @BuiltValueField(wireName: r'minUnitCountAdmin')
  int? get minUnitCountAdmin;

  @BuiltValueField(wireName: r'minUnitCountSeller')
  int? get minUnitCountSeller;

  @BuiltValueField(wireName: r'onSale')
  bool? get onSale;

  @BuiltValueField(wireName: r'location_id')
  int? get locationId;

  UpdateStockResult._();

  factory UpdateStockResult([void updates(UpdateStockResultBuilder b)]) = _$UpdateStockResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateStockResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateStockResult> get serializer => _$UpdateStockResultSerializer();
}

class _$UpdateStockResultSerializer implements PrimitiveSerializer<UpdateStockResult> {
  @override
  final Iterable<Type> types = const [UpdateStockResult, _$UpdateStockResult];

  @override
  final String wireName = r'UpdateStockResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateStockResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productNameId != null) {
      yield r'productNameId';
      yield serializers.serialize(
        object.productNameId,
        specifiedType: const FullType(int),
      );
    }
    if (object.productModelId != null) {
      yield r'productModelId';
      yield serializers.serialize(
        object.productModelId,
        specifiedType: const FullType(int),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(int),
      );
    }
    if (object.minSellPrice != null) {
      yield r'minSellPrice';
      yield serializers.serialize(
        object.minSellPrice,
        specifiedType: const FullType(num),
      );
    }
    if (object.minUnitCountAdmin != null) {
      yield r'minUnitCountAdmin';
      yield serializers.serialize(
        object.minUnitCountAdmin,
        specifiedType: const FullType(int),
      );
    }
    if (object.minUnitCountSeller != null) {
      yield r'minUnitCountSeller';
      yield serializers.serialize(
        object.minUnitCountSeller,
        specifiedType: const FullType(int),
      );
    }
    if (object.onSale != null) {
      yield r'onSale';
      yield serializers.serialize(
        object.onSale,
        specifiedType: const FullType(bool),
      );
    }
    if (object.locationId != null) {
      yield r'location_id';
      yield serializers.serialize(
        object.locationId,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateStockResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateStockResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'productNameId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productNameId = valueDes;
          break;
        case r'productModelId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productModelId = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.quantity = valueDes;
          break;
        case r'minSellPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minSellPrice = valueDes;
          break;
        case r'minUnitCountAdmin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.minUnitCountAdmin = valueDes;
          break;
        case r'minUnitCountSeller':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.minUnitCountSeller = valueDes;
          break;
        case r'onSale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.onSale = valueDes;
          break;
        case r'location_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.locationId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateStockResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateStockResultBuilder();
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

