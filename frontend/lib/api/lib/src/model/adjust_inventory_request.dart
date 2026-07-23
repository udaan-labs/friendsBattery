//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'adjust_inventory_request.g.dart';

/// AdjustInventoryRequest
///
/// Properties:
/// * [productId] 
/// * [userId] 
/// * [adjustmentQuantity] - Positive to add, negative to remove
@BuiltValue()
abstract class AdjustInventoryRequest implements Built<AdjustInventoryRequest, AdjustInventoryRequestBuilder> {
  @BuiltValueField(wireName: r'product_id')
  int get productId;

  @BuiltValueField(wireName: r'user_id')
  int get userId;

  /// Positive to add, negative to remove
  @BuiltValueField(wireName: r'adjustment_quantity')
  int get adjustmentQuantity;

  AdjustInventoryRequest._();

  factory AdjustInventoryRequest([void updates(AdjustInventoryRequestBuilder b)]) = _$AdjustInventoryRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdjustInventoryRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdjustInventoryRequest> get serializer => _$AdjustInventoryRequestSerializer();
}

class _$AdjustInventoryRequestSerializer implements PrimitiveSerializer<AdjustInventoryRequest> {
  @override
  final Iterable<Type> types = const [AdjustInventoryRequest, _$AdjustInventoryRequest];

  @override
  final String wireName = r'AdjustInventoryRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdjustInventoryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(int),
    );
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'adjustment_quantity';
    yield serializers.serialize(
      object.adjustmentQuantity,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdjustInventoryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdjustInventoryRequestBuilder result,
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
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'adjustment_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.adjustmentQuantity = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdjustInventoryRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdjustInventoryRequestBuilder();
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

