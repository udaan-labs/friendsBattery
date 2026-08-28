//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_employee_attendance_checked_in_get200_response_data_inner.g.dart';

/// ApiEmployeeAttendanceCheckedInGet200ResponseDataInner
///
/// Properties:
/// * [id] 
/// * [employeeId] 
/// * [checkInTime] 
/// * [checkInLat] 
/// * [checkInLng] 
/// * [lastLat] 
/// * [lastLng] 
/// * [lastSeenAt] 
/// * [status] 
/// * [location] 
/// * [employee] 
@BuiltValue()
abstract class ApiEmployeeAttendanceCheckedInGet200ResponseDataInner implements Built<ApiEmployeeAttendanceCheckedInGet200ResponseDataInner, ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'employee_id')
  int? get employeeId;

  @BuiltValueField(wireName: r'check_in_time')
  DateTime? get checkInTime;

  @BuiltValueField(wireName: r'check_in_lat')
  num? get checkInLat;

  @BuiltValueField(wireName: r'check_in_lng')
  num? get checkInLng;

  @BuiltValueField(wireName: r'last_lat')
  num? get lastLat;

  @BuiltValueField(wireName: r'last_lng')
  num? get lastLng;

  @BuiltValueField(wireName: r'last_seen_at')
  DateTime? get lastSeenAt;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'location')
  JsonObject? get location;

  @BuiltValueField(wireName: r'employee')
  JsonObject? get employee;

  ApiEmployeeAttendanceCheckedInGet200ResponseDataInner._();

  factory ApiEmployeeAttendanceCheckedInGet200ResponseDataInner([void updates(ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder b)]) = _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiEmployeeAttendanceCheckedInGet200ResponseDataInner> get serializer => _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerSerializer();
}

class _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerSerializer implements PrimitiveSerializer<ApiEmployeeAttendanceCheckedInGet200ResponseDataInner> {
  @override
  final Iterable<Type> types = const [ApiEmployeeAttendanceCheckedInGet200ResponseDataInner, _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInner];

  @override
  final String wireName = r'ApiEmployeeAttendanceCheckedInGet200ResponseDataInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiEmployeeAttendanceCheckedInGet200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.employeeId != null) {
      yield r'employee_id';
      yield serializers.serialize(
        object.employeeId,
        specifiedType: const FullType(int),
      );
    }
    if (object.checkInTime != null) {
      yield r'check_in_time';
      yield serializers.serialize(
        object.checkInTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.checkInLat != null) {
      yield r'check_in_lat';
      yield serializers.serialize(
        object.checkInLat,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.checkInLng != null) {
      yield r'check_in_lng';
      yield serializers.serialize(
        object.checkInLng,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.lastLat != null) {
      yield r'last_lat';
      yield serializers.serialize(
        object.lastLat,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.lastLng != null) {
      yield r'last_lng';
      yield serializers.serialize(
        object.lastLng,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.lastSeenAt != null) {
      yield r'last_seen_at';
      yield serializers.serialize(
        object.lastSeenAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType(JsonObject),
      );
    }
    if (object.employee != null) {
      yield r'employee';
      yield serializers.serialize(
        object.employee,
        specifiedType: const FullType(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiEmployeeAttendanceCheckedInGet200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'employee_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.employeeId = valueDes;
          break;
        case r'check_in_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.checkInTime = valueDes;
          break;
        case r'check_in_lat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.checkInLat = valueDes;
          break;
        case r'check_in_lng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.checkInLng = valueDes;
          break;
        case r'last_lat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.lastLat = valueDes;
          break;
        case r'last_lng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.lastLng = valueDes;
          break;
        case r'last_seen_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastSeenAt = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.location = valueDes;
          break;
        case r'employee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.employee = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiEmployeeAttendanceCheckedInGet200ResponseDataInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder();
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

