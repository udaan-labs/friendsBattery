//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/api_shipments_id_get200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_shipments_id_get200_response.g.dart';

/// ApiShipmentsIdGet200Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiShipmentsIdGet200Response implements Built<ApiShipmentsIdGet200Response, ApiShipmentsIdGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  ApiShipmentsIdGet200ResponseData? get data;

  ApiShipmentsIdGet200Response._();

  factory ApiShipmentsIdGet200Response([void updates(ApiShipmentsIdGet200ResponseBuilder b)]) = _$ApiShipmentsIdGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiShipmentsIdGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiShipmentsIdGet200Response> get serializer => _$ApiShipmentsIdGet200ResponseSerializer();
}

class _$ApiShipmentsIdGet200ResponseSerializer implements PrimitiveSerializer<ApiShipmentsIdGet200Response> {
  @override
  final Iterable<Type> types = const [ApiShipmentsIdGet200Response, _$ApiShipmentsIdGet200Response];

  @override
  final String wireName = r'ApiShipmentsIdGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiShipmentsIdGet200Response object, {
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
        specifiedType: const FullType(ApiShipmentsIdGet200ResponseData),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiShipmentsIdGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiShipmentsIdGet200ResponseBuilder result,
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
            specifiedType: const FullType(ApiShipmentsIdGet200ResponseData),
          ) as ApiShipmentsIdGet200ResponseData;
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
  ApiShipmentsIdGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiShipmentsIdGet200ResponseBuilder();
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

