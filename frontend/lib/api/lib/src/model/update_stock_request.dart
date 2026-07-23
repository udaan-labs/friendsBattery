//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_stock_request.g.dart';

/// UpdateStockRequest
///
/// Properties:
/// * [productNameId] 
/// * [productModelId] 
/// * [quantity] - Units to add; optional when only updating price/flags
/// * [minSellPrice] 
/// * [minUnitCountAdmin] 
/// * [minUnitCountSeller] 
/// * [onSale] 
@BuiltValue()
abstract class UpdateStockRequest implements Built<UpdateStockRequest, UpdateStockRequestBuilder> {
  @BuiltValueField(wireName: r'productNameId')
  int get productNameId;

  @BuiltValueField(wireName: r'productModelId')
  int get productModelId;

  /// Units to add; optional when only updating price/flags
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

  UpdateStockRequest._();

  factory UpdateStockRequest([void updates(UpdateStockRequestBuilder b)]) = _$UpdateStockRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateStockRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateStockRequest> get serializer => _$UpdateStockRequestSerializer();
}

class _$UpdateStockRequestSerializer implements PrimitiveSerializer<UpdateStockRequest> {
  @override
  final Iterable<Type> types = const [UpdateStockRequest, _$UpdateStockRequest];

  @override
  final String wireName = r'UpdateStockRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateStockRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'productNameId';
    yield serializers.serialize(
      object.productNameId,
      specifiedType: const FullType(int),
    );
    yield r'productModelId';
    yield serializers.serialize(
      object.productModelId,
      specifiedType: const FullType(int),
    );
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
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateStockRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateStockRequestBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateStockRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateStockRequestBuilder();
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

