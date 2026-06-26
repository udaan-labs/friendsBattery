//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/api_shipments_get200_response_data_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_shipments_get200_response.g.dart';

/// ApiShipmentsGet200Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiShipmentsGet200Response implements Built<ApiShipmentsGet200Response, ApiShipmentsGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<ApiShipmentsGet200ResponseDataInner>? get data;

  ApiShipmentsGet200Response._();

  factory ApiShipmentsGet200Response([void updates(ApiShipmentsGet200ResponseBuilder b)]) = _$ApiShipmentsGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiShipmentsGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiShipmentsGet200Response> get serializer => _$ApiShipmentsGet200ResponseSerializer();
}

class _$ApiShipmentsGet200ResponseSerializer implements PrimitiveSerializer<ApiShipmentsGet200Response> {
  @override
  final Iterable<Type> types = const [ApiShipmentsGet200Response, _$ApiShipmentsGet200Response];

  @override
  final String wireName = r'ApiShipmentsGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiShipmentsGet200Response object, {
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
        specifiedType: const FullType(BuiltList, [FullType(ApiShipmentsGet200ResponseDataInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiShipmentsGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiShipmentsGet200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(ApiShipmentsGet200ResponseDataInner)]),
          ) as BuiltList<ApiShipmentsGet200ResponseDataInner>;
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
  ApiShipmentsGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiShipmentsGet200ResponseBuilder();
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

