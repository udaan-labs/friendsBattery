//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_details_get200_response.g.dart';

/// ApiInventoryDetailsGet200Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiInventoryDetailsGet200Response implements Built<ApiInventoryDetailsGet200Response, ApiInventoryDetailsGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  ApiInventoryDetailsGet200ResponseData? get data;

  ApiInventoryDetailsGet200Response._();

  factory ApiInventoryDetailsGet200Response([void updates(ApiInventoryDetailsGet200ResponseBuilder b)]) = _$ApiInventoryDetailsGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryDetailsGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryDetailsGet200Response> get serializer => _$ApiInventoryDetailsGet200ResponseSerializer();
}

class _$ApiInventoryDetailsGet200ResponseSerializer implements PrimitiveSerializer<ApiInventoryDetailsGet200Response> {
  @override
  final Iterable<Type> types = const [ApiInventoryDetailsGet200Response, _$ApiInventoryDetailsGet200Response];

  @override
  final String wireName = r'ApiInventoryDetailsGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryDetailsGet200Response object, {
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
        specifiedType: const FullType(ApiInventoryDetailsGet200ResponseData),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryDetailsGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryDetailsGet200ResponseBuilder result,
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
            specifiedType: const FullType(ApiInventoryDetailsGet200ResponseData),
          ) as ApiInventoryDetailsGet200ResponseData;
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
  ApiInventoryDetailsGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryDetailsGet200ResponseBuilder();
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

