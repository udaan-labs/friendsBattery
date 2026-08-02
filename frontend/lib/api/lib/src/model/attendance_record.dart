//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/attendance_record_location.dart';
import 'package:built_collection/built_collection.dart';
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

  @BuiltValueField(wireName: r'status')
  AttendanceRecordStatusEnum? get status;
  // enum statusEnum {  CHECKED_IN,  CHECKED_OUT,  };

  @BuiltValueField(wireName: r'location')
  AttendanceRecordLocation? get location;

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
        specifiedType: const FullType.nullable(AttendanceRecordLocation),
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
            specifiedType: const FullType.nullable(AttendanceRecordLocation),
          ) as AttendanceRecordLocation?;
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

