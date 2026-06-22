//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/api_inventory_transfer_post_request_products_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_transfer_post_request.g.dart';

/// ApiInventoryTransferPostRequest
///
/// Properties:
/// * [sellerId] 
/// * [products] 
@BuiltValue()
abstract class ApiInventoryTransferPostRequest implements Built<ApiInventoryTransferPostRequest, ApiInventoryTransferPostRequestBuilder> {
  @BuiltValueField(wireName: r'seller_id')
  int get sellerId;

  @BuiltValueField(wireName: r'products')
  BuiltList<ApiInventoryTransferPostRequestProductsInner> get products;

  ApiInventoryTransferPostRequest._();

  factory ApiInventoryTransferPostRequest([void updates(ApiInventoryTransferPostRequestBuilder b)]) = _$ApiInventoryTransferPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryTransferPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryTransferPostRequest> get serializer => _$ApiInventoryTransferPostRequestSerializer();
}

class _$ApiInventoryTransferPostRequestSerializer implements PrimitiveSerializer<ApiInventoryTransferPostRequest> {
  @override
  final Iterable<Type> types = const [ApiInventoryTransferPostRequest, _$ApiInventoryTransferPostRequest];

  @override
  final String wireName = r'ApiInventoryTransferPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryTransferPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'seller_id';
    yield serializers.serialize(
      object.sellerId,
      specifiedType: const FullType(int),
    );
    yield r'products';
    yield serializers.serialize(
      object.products,
      specifiedType: const FullType(BuiltList, [FullType(ApiInventoryTransferPostRequestProductsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryTransferPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryTransferPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'seller_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sellerId = valueDes;
          break;
        case r'products':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ApiInventoryTransferPostRequestProductsInner)]),
          ) as BuiltList<ApiInventoryTransferPostRequestProductsInner>;
          result.products.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiInventoryTransferPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryTransferPostRequestBuilder();
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

