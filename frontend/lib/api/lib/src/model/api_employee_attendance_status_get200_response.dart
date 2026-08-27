//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/attendance_status_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_employee_attendance_status_get200_response.g.dart';

/// ApiEmployeeAttendanceStatusGet200Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiEmployeeAttendanceStatusGet200Response implements Built<ApiEmployeeAttendanceStatusGet200Response, ApiEmployeeAttendanceStatusGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  AttendanceStatusData? get data;

  ApiEmployeeAttendanceStatusGet200Response._();

  factory ApiEmployeeAttendanceStatusGet200Response([void updates(ApiEmployeeAttendanceStatusGet200ResponseBuilder b)]) = _$ApiEmployeeAttendanceStatusGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiEmployeeAttendanceStatusGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiEmployeeAttendanceStatusGet200Response> get serializer => _$ApiEmployeeAttendanceStatusGet200ResponseSerializer();
}

class _$ApiEmployeeAttendanceStatusGet200ResponseSerializer implements PrimitiveSerializer<ApiEmployeeAttendanceStatusGet200Response> {
  @override
  final Iterable<Type> types = const [ApiEmployeeAttendanceStatusGet200Response, _$ApiEmployeeAttendanceStatusGet200Response];

  @override
  final String wireName = r'ApiEmployeeAttendanceStatusGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiEmployeeAttendanceStatusGet200Response object, {
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
        specifiedType: const FullType(AttendanceStatusData),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiEmployeeAttendanceStatusGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiEmployeeAttendanceStatusGet200ResponseBuilder result,
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
            specifiedType: const FullType(AttendanceStatusData),
          ) as AttendanceStatusData;
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
  ApiEmployeeAttendanceStatusGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiEmployeeAttendanceStatusGet200ResponseBuilder();
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

