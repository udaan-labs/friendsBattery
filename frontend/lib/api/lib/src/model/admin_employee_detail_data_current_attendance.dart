//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/employee_action_location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_employee_detail_data_current_attendance.g.dart';

/// AdminEmployeeDetailDataCurrentAttendance
///
/// Properties:
/// * [id] 
/// * [checkInTime] 
/// * [status] 
/// * [location] 
@BuiltValue()
abstract class AdminEmployeeDetailDataCurrentAttendance implements Built<AdminEmployeeDetailDataCurrentAttendance, AdminEmployeeDetailDataCurrentAttendanceBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'check_in_time')
  DateTime? get checkInTime;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'location')
  EmployeeActionLocation? get location;

  AdminEmployeeDetailDataCurrentAttendance._();

  factory AdminEmployeeDetailDataCurrentAttendance([void updates(AdminEmployeeDetailDataCurrentAttendanceBuilder b)]) = _$AdminEmployeeDetailDataCurrentAttendance;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminEmployeeDetailDataCurrentAttendanceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminEmployeeDetailDataCurrentAttendance> get serializer => _$AdminEmployeeDetailDataCurrentAttendanceSerializer();
}

class _$AdminEmployeeDetailDataCurrentAttendanceSerializer implements PrimitiveSerializer<AdminEmployeeDetailDataCurrentAttendance> {
  @override
  final Iterable<Type> types = const [AdminEmployeeDetailDataCurrentAttendance, _$AdminEmployeeDetailDataCurrentAttendance];

  @override
  final String wireName = r'AdminEmployeeDetailDataCurrentAttendance';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminEmployeeDetailDataCurrentAttendance object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
        specifiedType: const FullType.nullable(EmployeeActionLocation),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminEmployeeDetailDataCurrentAttendance object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminEmployeeDetailDataCurrentAttendanceBuilder result,
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
        case r'check_in_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.checkInTime = valueDes;
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
            specifiedType: const FullType.nullable(EmployeeActionLocation),
          ) as EmployeeActionLocation?;
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
  AdminEmployeeDetailDataCurrentAttendance deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminEmployeeDetailDataCurrentAttendanceBuilder();
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

