//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/api_employee_attendance_checked_in_get200_response_data_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_employee_attendance_checked_in_get200_response.g.dart';

/// ApiEmployeeAttendanceCheckedInGet200Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiEmployeeAttendanceCheckedInGet200Response implements Built<ApiEmployeeAttendanceCheckedInGet200Response, ApiEmployeeAttendanceCheckedInGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<ApiEmployeeAttendanceCheckedInGet200ResponseDataInner>? get data;

  ApiEmployeeAttendanceCheckedInGet200Response._();

  factory ApiEmployeeAttendanceCheckedInGet200Response([void updates(ApiEmployeeAttendanceCheckedInGet200ResponseBuilder b)]) = _$ApiEmployeeAttendanceCheckedInGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiEmployeeAttendanceCheckedInGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiEmployeeAttendanceCheckedInGet200Response> get serializer => _$ApiEmployeeAttendanceCheckedInGet200ResponseSerializer();
}

class _$ApiEmployeeAttendanceCheckedInGet200ResponseSerializer implements PrimitiveSerializer<ApiEmployeeAttendanceCheckedInGet200Response> {
  @override
  final Iterable<Type> types = const [ApiEmployeeAttendanceCheckedInGet200Response, _$ApiEmployeeAttendanceCheckedInGet200Response];

  @override
  final String wireName = r'ApiEmployeeAttendanceCheckedInGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiEmployeeAttendanceCheckedInGet200Response object, {
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
        specifiedType: const FullType(BuiltList, [FullType(ApiEmployeeAttendanceCheckedInGet200ResponseDataInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiEmployeeAttendanceCheckedInGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiEmployeeAttendanceCheckedInGet200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(ApiEmployeeAttendanceCheckedInGet200ResponseDataInner)]),
          ) as BuiltList<ApiEmployeeAttendanceCheckedInGet200ResponseDataInner>;
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
  ApiEmployeeAttendanceCheckedInGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiEmployeeAttendanceCheckedInGet200ResponseBuilder();
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

