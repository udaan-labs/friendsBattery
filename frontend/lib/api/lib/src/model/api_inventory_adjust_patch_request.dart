//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_adjust_patch_request.g.dart';

/// ApiInventoryAdjustPatchRequest
///
/// Properties:
/// * [productId] 
/// * [userId] 
/// * [adjustmentQuantity] 
@BuiltValue()
abstract class ApiInventoryAdjustPatchRequest implements Built<ApiInventoryAdjustPatchRequest, ApiInventoryAdjustPatchRequestBuilder> {
  @BuiltValueField(wireName: r'product_id')
  int get productId;

  @BuiltValueField(wireName: r'user_id')
  int get userId;

  @BuiltValueField(wireName: r'adjustment_quantity')
  int get adjustmentQuantity;

  ApiInventoryAdjustPatchRequest._();

  factory ApiInventoryAdjustPatchRequest([void updates(ApiInventoryAdjustPatchRequestBuilder b)]) = _$ApiInventoryAdjustPatchRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryAdjustPatchRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryAdjustPatchRequest> get serializer => _$ApiInventoryAdjustPatchRequestSerializer();
}

class _$ApiInventoryAdjustPatchRequestSerializer implements PrimitiveSerializer<ApiInventoryAdjustPatchRequest> {
  @override
  final Iterable<Type> types = const [ApiInventoryAdjustPatchRequest, _$ApiInventoryAdjustPatchRequest];

  @override
  final String wireName = r'ApiInventoryAdjustPatchRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryAdjustPatchRequest object, {
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
    ApiInventoryAdjustPatchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryAdjustPatchRequestBuilder result,
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
  ApiInventoryAdjustPatchRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryAdjustPatchRequestBuilder();
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

