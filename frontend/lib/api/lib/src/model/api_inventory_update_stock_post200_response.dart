//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/api_inventory_update_stock_post200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_update_stock_post200_response.g.dart';

/// ApiInventoryUpdateStockPost200Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiInventoryUpdateStockPost200Response implements Built<ApiInventoryUpdateStockPost200Response, ApiInventoryUpdateStockPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  ApiInventoryUpdateStockPost200ResponseData? get data;

  ApiInventoryUpdateStockPost200Response._();

  factory ApiInventoryUpdateStockPost200Response([void updates(ApiInventoryUpdateStockPost200ResponseBuilder b)]) = _$ApiInventoryUpdateStockPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryUpdateStockPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryUpdateStockPost200Response> get serializer => _$ApiInventoryUpdateStockPost200ResponseSerializer();
}

class _$ApiInventoryUpdateStockPost200ResponseSerializer implements PrimitiveSerializer<ApiInventoryUpdateStockPost200Response> {
  @override
  final Iterable<Type> types = const [ApiInventoryUpdateStockPost200Response, _$ApiInventoryUpdateStockPost200Response];

  @override
  final String wireName = r'ApiInventoryUpdateStockPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryUpdateStockPost200Response object, {
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
        specifiedType: const FullType(ApiInventoryUpdateStockPost200ResponseData),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryUpdateStockPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryUpdateStockPost200ResponseBuilder result,
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
            specifiedType: const FullType(ApiInventoryUpdateStockPost200ResponseData),
          ) as ApiInventoryUpdateStockPost200ResponseData;
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
  ApiInventoryUpdateStockPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryUpdateStockPost200ResponseBuilder();
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

