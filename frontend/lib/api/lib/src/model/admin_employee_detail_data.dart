//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/shop_staff_member.dart';
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/admin_employee_detail_data_current_attendance.dart';
import 'package:friends_battery_api/src/model/employee_action.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_employee_detail_data.g.dart';

/// AdminEmployeeDetailData
///
/// Properties:
/// * [employee] 
/// * [isCheckedIn] 
/// * [currentAttendance] 
/// * [actions] - Only CHECK_IN and CHECK_OUT events, newest first
@BuiltValue()
abstract class AdminEmployeeDetailData implements Built<AdminEmployeeDetailData, AdminEmployeeDetailDataBuilder> {
  @BuiltValueField(wireName: r'employee')
  ShopStaffMember? get employee;

  @BuiltValueField(wireName: r'is_checked_in')
  bool? get isCheckedIn;

  @BuiltValueField(wireName: r'current_attendance')
  AdminEmployeeDetailDataCurrentAttendance? get currentAttendance;

  /// Only CHECK_IN and CHECK_OUT events, newest first
  @BuiltValueField(wireName: r'actions')
  BuiltList<EmployeeAction>? get actions;

  AdminEmployeeDetailData._();

  factory AdminEmployeeDetailData([void updates(AdminEmployeeDetailDataBuilder b)]) = _$AdminEmployeeDetailData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminEmployeeDetailDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminEmployeeDetailData> get serializer => _$AdminEmployeeDetailDataSerializer();
}

class _$AdminEmployeeDetailDataSerializer implements PrimitiveSerializer<AdminEmployeeDetailData> {
  @override
  final Iterable<Type> types = const [AdminEmployeeDetailData, _$AdminEmployeeDetailData];

  @override
  final String wireName = r'AdminEmployeeDetailData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminEmployeeDetailData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.employee != null) {
      yield r'employee';
      yield serializers.serialize(
        object.employee,
        specifiedType: const FullType(ShopStaffMember),
      );
    }
    if (object.isCheckedIn != null) {
      yield r'is_checked_in';
      yield serializers.serialize(
        object.isCheckedIn,
        specifiedType: const FullType(bool),
      );
    }
    if (object.currentAttendance != null) {
      yield r'current_attendance';
      yield serializers.serialize(
        object.currentAttendance,
        specifiedType: const FullType.nullable(AdminEmployeeDetailDataCurrentAttendance),
      );
    }
    if (object.actions != null) {
      yield r'actions';
      yield serializers.serialize(
        object.actions,
        specifiedType: const FullType(BuiltList, [FullType(EmployeeAction)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminEmployeeDetailData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminEmployeeDetailDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'employee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ShopStaffMember),
          ) as ShopStaffMember;
          result.employee.replace(valueDes);
          break;
        case r'is_checked_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isCheckedIn = valueDes;
          break;
        case r'current_attendance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdminEmployeeDetailDataCurrentAttendance),
          ) as AdminEmployeeDetailDataCurrentAttendance?;
          if (valueDes == null) continue;
          result.currentAttendance.replace(valueDes);
          break;
        case r'actions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EmployeeAction)]),
          ) as BuiltList<EmployeeAction>;
          result.actions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminEmployeeDetailData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminEmployeeDetailDataBuilder();
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

