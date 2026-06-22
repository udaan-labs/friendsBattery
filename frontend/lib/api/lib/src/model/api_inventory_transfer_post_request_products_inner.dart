//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_transfer_post_request_products_inner.g.dart';

/// ApiInventoryTransferPostRequestProductsInner
///
/// Properties:
/// * [productId] 
/// * [quantity] 
@BuiltValue()
abstract class ApiInventoryTransferPostRequestProductsInner implements Built<ApiInventoryTransferPostRequestProductsInner, ApiInventoryTransferPostRequestProductsInnerBuilder> {
  @BuiltValueField(wireName: r'product_id')
  int? get productId;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  ApiInventoryTransferPostRequestProductsInner._();

  factory ApiInventoryTransferPostRequestProductsInner([void updates(ApiInventoryTransferPostRequestProductsInnerBuilder b)]) = _$ApiInventoryTransferPostRequestProductsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryTransferPostRequestProductsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryTransferPostRequestProductsInner> get serializer => _$ApiInventoryTransferPostRequestProductsInnerSerializer();
}

class _$ApiInventoryTransferPostRequestProductsInnerSerializer implements PrimitiveSerializer<ApiInventoryTransferPostRequestProductsInner> {
  @override
  final Iterable<Type> types = const [ApiInventoryTransferPostRequestProductsInner, _$ApiInventoryTransferPostRequestProductsInner];

  @override
  final String wireName = r'ApiInventoryTransferPostRequestProductsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryTransferPostRequestProductsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productId != null) {
      yield r'product_id';
      yield serializers.serialize(
        object.productId,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryTransferPostRequestProductsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryTransferPostRequestProductsInnerBuilder result,
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
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.quantity = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiInventoryTransferPostRequestProductsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryTransferPostRequestProductsInnerBuilder();
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

