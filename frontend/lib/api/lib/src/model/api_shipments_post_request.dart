//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/api_shipments_post_request_items_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_shipments_post_request.g.dart';

/// ApiShipmentsPostRequest
///
/// Properties:
/// * [sellerId] 
/// * [items] 
@BuiltValue()
abstract class ApiShipmentsPostRequest implements Built<ApiShipmentsPostRequest, ApiShipmentsPostRequestBuilder> {
  @BuiltValueField(wireName: r'sellerId')
  int get sellerId;

  @BuiltValueField(wireName: r'items')
  BuiltList<ApiShipmentsPostRequestItemsInner> get items;

  ApiShipmentsPostRequest._();

  factory ApiShipmentsPostRequest([void updates(ApiShipmentsPostRequestBuilder b)]) = _$ApiShipmentsPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiShipmentsPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiShipmentsPostRequest> get serializer => _$ApiShipmentsPostRequestSerializer();
}

class _$ApiShipmentsPostRequestSerializer implements PrimitiveSerializer<ApiShipmentsPostRequest> {
  @override
  final Iterable<Type> types = const [ApiShipmentsPostRequest, _$ApiShipmentsPostRequest];

  @override
  final String wireName = r'ApiShipmentsPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiShipmentsPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'sellerId';
    yield serializers.serialize(
      object.sellerId,
      specifiedType: const FullType(int),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(ApiShipmentsPostRequestItemsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiShipmentsPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiShipmentsPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sellerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sellerId = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ApiShipmentsPostRequestItemsInner)]),
          ) as BuiltList<ApiShipmentsPostRequestItemsInner>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiShipmentsPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiShipmentsPostRequestBuilder();
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

