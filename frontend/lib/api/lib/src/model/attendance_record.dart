//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/assigned_location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'attendance_record.g.dart';

/// AttendanceRecord
///
/// Properties:
/// * [id] 
/// * [employeeId] 
/// * [assignedLocationId] 
/// * [checkInTime] 
/// * [checkOutTime] 
/// * [checkInLat] 
/// * [checkInLng] 
/// * [lastLat] 
/// * [lastLng] 
/// * [lastSeenAt] 
/// * [status] 
/// * [location] 
@BuiltValue()
abstract class AttendanceRecord implements Built<AttendanceRecord, AttendanceRecordBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'employee_id')
  int? get employeeId;

  @BuiltValueField(wireName: r'assigned_location_id')
  int? get assignedLocationId;

  @BuiltValueField(wireName: r'check_in_time')
  DateTime? get checkInTime;

  @BuiltValueField(wireName: r'check_out_time')
  DateTime? get checkOutTime;

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
  AttendanceRecordStatusEnum? get status;
  // enum statusEnum {  CHECKED_IN,  CHECKED_OUT,  };

  @BuiltValueField(wireName: r'location')
  AssignedLocation? get location;

  AttendanceRecord._();

  factory AttendanceRecord([void updates(AttendanceRecordBuilder b)]) = _$AttendanceRecord;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AttendanceRecordBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AttendanceRecord> get serializer => _$AttendanceRecordSerializer();
}

class _$AttendanceRecordSerializer implements PrimitiveSerializer<AttendanceRecord> {
  @override
  final Iterable<Type> types = const [AttendanceRecord, _$AttendanceRecord];

  @override
  final String wireName = r'AttendanceRecord';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AttendanceRecord object, {
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
    if (object.assignedLocationId != null) {
      yield r'assigned_location_id';
      yield serializers.serialize(
        object.assignedLocationId,
        specifiedType: const FullType(int),
      );
    }
    if (object.checkInTime != null) {
      yield r'check_in_time';
      yield serializers.serialize(
        object.checkInTime,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.checkOutTime != null) {
      yield r'check_out_time';
      yield serializers.serialize(
        object.checkOutTime,
        specifiedType: const FullType.nullable(DateTime),
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
        specifiedType: const FullType(AttendanceRecordStatusEnum),
      );
    }
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType.nullable(AssignedLocation),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AttendanceRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AttendanceRecordBuilder result,
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
        case r'assigned_location_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.assignedLocationId = valueDes;
          break;
        case r'check_in_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.checkInTime = valueDes;
          break;
        case r'check_out_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.checkOutTime = valueDes;
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
            specifiedType: const FullType(AttendanceRecordStatusEnum),
          ) as AttendanceRecordStatusEnum;
          result.status = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AssignedLocation),
          ) as AssignedLocation?;
          if (valueDes == null) continue;
          result.location.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AttendanceRecord deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AttendanceRecordBuilder();
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

class AttendanceRecordStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CHECKED_IN')
  static const AttendanceRecordStatusEnum CHECKED_IN = _$attendanceRecordStatusEnum_CHECKED_IN;
  @BuiltValueEnumConst(wireName: r'CHECKED_OUT')
  static const AttendanceRecordStatusEnum CHECKED_OUT = _$attendanceRecordStatusEnum_CHECKED_OUT;

  static Serializer<AttendanceRecordStatusEnum> get serializer => _$attendanceRecordStatusEnumSerializer;

  const AttendanceRecordStatusEnum._(String name): super(name);

  static BuiltSet<AttendanceRecordStatusEnum> get values => _$attendanceRecordStatusEnumValues;
  static AttendanceRecordStatusEnum valueOf(String name) => _$attendanceRecordStatusEnumValueOf(name);
}

