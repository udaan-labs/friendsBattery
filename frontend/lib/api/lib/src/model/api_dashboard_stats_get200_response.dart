//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/admin_dashboard_stats.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_dashboard_stats_get200_response.g.dart';

/// ApiDashboardStatsGet200Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiDashboardStatsGet200Response implements Built<ApiDashboardStatsGet200Response, ApiDashboardStatsGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  AdminDashboardStats? get data;

  ApiDashboardStatsGet200Response._();

  factory ApiDashboardStatsGet200Response([void updates(ApiDashboardStatsGet200ResponseBuilder b)]) = _$ApiDashboardStatsGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiDashboardStatsGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiDashboardStatsGet200Response> get serializer => _$ApiDashboardStatsGet200ResponseSerializer();
}

class _$ApiDashboardStatsGet200ResponseSerializer implements PrimitiveSerializer<ApiDashboardStatsGet200Response> {
  @override
  final Iterable<Type> types = const [ApiDashboardStatsGet200Response, _$ApiDashboardStatsGet200Response];

  @override
  final String wireName = r'ApiDashboardStatsGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiDashboardStatsGet200Response object, {
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
        specifiedType: const FullType(AdminDashboardStats),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiDashboardStatsGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiDashboardStatsGet200ResponseBuilder result,
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
            specifiedType: const FullType(AdminDashboardStats),
          ) as AdminDashboardStats;
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
  ApiDashboardStatsGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiDashboardStatsGet200ResponseBuilder();
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

