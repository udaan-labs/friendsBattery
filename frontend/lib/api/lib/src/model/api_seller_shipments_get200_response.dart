//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/api_seller_shipments_get200_response_data_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_seller_shipments_get200_response.g.dart';

/// ApiSellerShipmentsGet200Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiSellerShipmentsGet200Response implements Built<ApiSellerShipmentsGet200Response, ApiSellerShipmentsGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<ApiSellerShipmentsGet200ResponseDataInner>? get data;

  ApiSellerShipmentsGet200Response._();

  factory ApiSellerShipmentsGet200Response([void updates(ApiSellerShipmentsGet200ResponseBuilder b)]) = _$ApiSellerShipmentsGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiSellerShipmentsGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiSellerShipmentsGet200Response> get serializer => _$ApiSellerShipmentsGet200ResponseSerializer();
}

class _$ApiSellerShipmentsGet200ResponseSerializer implements PrimitiveSerializer<ApiSellerShipmentsGet200Response> {
  @override
  final Iterable<Type> types = const [ApiSellerShipmentsGet200Response, _$ApiSellerShipmentsGet200Response];

  @override
  final String wireName = r'ApiSellerShipmentsGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiSellerShipmentsGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(BuiltList, [FullType(ApiSellerShipmentsGet200ResponseDataInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiSellerShipmentsGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiSellerShipmentsGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ApiSellerShipmentsGet200ResponseDataInner)]),
          ) as BuiltList<ApiSellerShipmentsGet200ResponseDataInner>;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiSellerShipmentsGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiSellerShipmentsGet200ResponseBuilder();
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

