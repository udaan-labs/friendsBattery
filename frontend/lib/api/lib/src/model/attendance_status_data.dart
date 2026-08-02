//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/attendance_record_location.dart';
import 'package:friends_battery_api/src/model/attendance_record.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'attendance_status_data.g.dart';

/// AttendanceStatusData
///
/// Properties:
/// * [isCheckedIn] 
/// * [attendance] 
/// * [location] 
@BuiltValue()
abstract class AttendanceStatusData implements Built<AttendanceStatusData, AttendanceStatusDataBuilder> {
  @BuiltValueField(wireName: r'is_checked_in')
  bool? get isCheckedIn;

  @BuiltValueField(wireName: r'attendance')
  AttendanceRecord? get attendance;

  @BuiltValueField(wireName: r'location')
  AttendanceRecordLocation? get location;

  AttendanceStatusData._();

  factory AttendanceStatusData([void updates(AttendanceStatusDataBuilder b)]) = _$AttendanceStatusData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AttendanceStatusDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AttendanceStatusData> get serializer => _$AttendanceStatusDataSerializer();
}

class _$AttendanceStatusDataSerializer implements PrimitiveSerializer<AttendanceStatusData> {
  @override
  final Iterable<Type> types = const [AttendanceStatusData, _$AttendanceStatusData];

  @override
  final String wireName = r'AttendanceStatusData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AttendanceStatusData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.isCheckedIn != null) {
      yield r'is_checked_in';
      yield serializers.serialize(
        object.isCheckedIn,
        specifiedType: const FullType(bool),
      );
    }
    if (object.attendance != null) {
      yield r'attendance';
      yield serializers.serialize(
        object.attendance,
        specifiedType: const FullType.nullable(AttendanceRecord),
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
    AttendanceStatusData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AttendanceStatusDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'is_checked_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isCheckedIn = valueDes;
          break;
        case r'attendance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AttendanceRecord),
          ) as AttendanceRecord?;
          if (valueDes == null) continue;
          result.attendance.replace(valueDes);
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
  AttendanceStatusData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AttendanceStatusDataBuilder();
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

