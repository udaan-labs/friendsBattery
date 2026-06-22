//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/api_seller_dashboard_stats_get200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_seller_dashboard_stats_get200_response.g.dart';

/// ApiSellerDashboardStatsGet200Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiSellerDashboardStatsGet200Response implements Built<ApiSellerDashboardStatsGet200Response, ApiSellerDashboardStatsGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  ApiSellerDashboardStatsGet200ResponseData? get data;

  ApiSellerDashboardStatsGet200Response._();

  factory ApiSellerDashboardStatsGet200Response([void updates(ApiSellerDashboardStatsGet200ResponseBuilder b)]) = _$ApiSellerDashboardStatsGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiSellerDashboardStatsGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiSellerDashboardStatsGet200Response> get serializer => _$ApiSellerDashboardStatsGet200ResponseSerializer();
}

class _$ApiSellerDashboardStatsGet200ResponseSerializer implements PrimitiveSerializer<ApiSellerDashboardStatsGet200Response> {
  @override
  final Iterable<Type> types = const [ApiSellerDashboardStatsGet200Response, _$ApiSellerDashboardStatsGet200Response];

  @override
  final String wireName = r'ApiSellerDashboardStatsGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiSellerDashboardStatsGet200Response object, {
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
        specifiedType: const FullType(ApiSellerDashboardStatsGet200ResponseData),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiSellerDashboardStatsGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiSellerDashboardStatsGet200ResponseBuilder result,
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
            specifiedType: const FullType(ApiSellerDashboardStatsGet200ResponseData),
          ) as ApiSellerDashboardStatsGet200ResponseData;
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
  ApiSellerDashboardStatsGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiSellerDashboardStatsGet200ResponseBuilder();
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

