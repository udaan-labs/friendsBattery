//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/attendance_record.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_employee_attendance_check_in_post201_response.g.dart';

/// ApiEmployeeAttendanceCheckInPost201Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiEmployeeAttendanceCheckInPost201Response implements Built<ApiEmployeeAttendanceCheckInPost201Response, ApiEmployeeAttendanceCheckInPost201ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  AttendanceRecord? get data;

  ApiEmployeeAttendanceCheckInPost201Response._();

  factory ApiEmployeeAttendanceCheckInPost201Response([void updates(ApiEmployeeAttendanceCheckInPost201ResponseBuilder b)]) = _$ApiEmployeeAttendanceCheckInPost201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiEmployeeAttendanceCheckInPost201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiEmployeeAttendanceCheckInPost201Response> get serializer => _$ApiEmployeeAttendanceCheckInPost201ResponseSerializer();
}

class _$ApiEmployeeAttendanceCheckInPost201ResponseSerializer implements PrimitiveSerializer<ApiEmployeeAttendanceCheckInPost201Response> {
  @override
  final Iterable<Type> types = const [ApiEmployeeAttendanceCheckInPost201Response, _$ApiEmployeeAttendanceCheckInPost201Response];

  @override
  final String wireName = r'ApiEmployeeAttendanceCheckInPost201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiEmployeeAttendanceCheckInPost201Response object, {
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
        specifiedType: const FullType(AttendanceRecord),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiEmployeeAttendanceCheckInPost201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiEmployeeAttendanceCheckInPost201ResponseBuilder result,
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
            specifiedType: const FullType(AttendanceRecord),
          ) as AttendanceRecord;
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
  ApiEmployeeAttendanceCheckInPost201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiEmployeeAttendanceCheckInPost201ResponseBuilder();
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

