//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/api_transfers_post_request_items_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_transfers_post_request.g.dart';

/// ApiTransfersPostRequest
///
/// Properties:
/// * [sellerId] 
/// * [items] 
@BuiltValue()
abstract class ApiTransfersPostRequest implements Built<ApiTransfersPostRequest, ApiTransfersPostRequestBuilder> {
  @BuiltValueField(wireName: r'seller_id')
  int? get sellerId;

  @BuiltValueField(wireName: r'items')
  BuiltList<ApiTransfersPostRequestItemsInner>? get items;

  ApiTransfersPostRequest._();

  factory ApiTransfersPostRequest([void updates(ApiTransfersPostRequestBuilder b)]) = _$ApiTransfersPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiTransfersPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiTransfersPostRequest> get serializer => _$ApiTransfersPostRequestSerializer();
}

class _$ApiTransfersPostRequestSerializer implements PrimitiveSerializer<ApiTransfersPostRequest> {
  @override
  final Iterable<Type> types = const [ApiTransfersPostRequest, _$ApiTransfersPostRequest];

  @override
  final String wireName = r'ApiTransfersPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiTransfersPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.sellerId != null) {
      yield r'seller_id';
      yield serializers.serialize(
        object.sellerId,
        specifiedType: const FullType(int),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(ApiTransfersPostRequestItemsInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiTransfersPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiTransfersPostRequestBuilder result,
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
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ApiTransfersPostRequestItemsInner)]),
          ) as BuiltList<ApiTransfersPostRequestItemsInner>;
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
  ApiTransfersPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiTransfersPostRequestBuilder();
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

