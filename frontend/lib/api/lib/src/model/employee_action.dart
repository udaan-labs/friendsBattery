//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/employee_action_location.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'employee_action.g.dart';

/// Employee-only action (CHECK_IN or CHECK_OUT)
///
/// Properties:
/// * [action] 
/// * [attendanceId] 
/// * [at] 
/// * [lat] 
/// * [lng] 
/// * [address] 
/// * [location] 
@BuiltValue()
abstract class EmployeeAction implements Built<EmployeeAction, EmployeeActionBuilder> {
  @BuiltValueField(wireName: r'action')
  EmployeeActionActionEnum? get action;
  // enum actionEnum {  CHECK_IN,  CHECK_OUT,  };

  @BuiltValueField(wireName: r'attendance_id')
  int? get attendanceId;

  @BuiltValueField(wireName: r'at')
  DateTime? get at;

  @BuiltValueField(wireName: r'lat')
  num? get lat;

  @BuiltValueField(wireName: r'lng')
  num? get lng;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'location')
  EmployeeActionLocation? get location;

  EmployeeAction._();

  factory EmployeeAction([void updates(EmployeeActionBuilder b)]) = _$EmployeeAction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EmployeeActionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EmployeeAction> get serializer => _$EmployeeActionSerializer();
}

class _$EmployeeActionSerializer implements PrimitiveSerializer<EmployeeAction> {
  @override
  final Iterable<Type> types = const [EmployeeAction, _$EmployeeAction];

  @override
  final String wireName = r'EmployeeAction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EmployeeAction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.action != null) {
      yield r'action';
      yield serializers.serialize(
        object.action,
        specifiedType: const FullType(EmployeeActionActionEnum),
      );
    }
    if (object.attendanceId != null) {
      yield r'attendance_id';
      yield serializers.serialize(
        object.attendanceId,
        specifiedType: const FullType(int),
      );
    }
    if (object.at != null) {
      yield r'at';
      yield serializers.serialize(
        object.at,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.lat != null) {
      yield r'lat';
      yield serializers.serialize(
        object.lat,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.lng != null) {
      yield r'lng';
      yield serializers.serialize(
        object.lng,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType.nullable(String),
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
    EmployeeAction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EmployeeActionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EmployeeActionActionEnum),
          ) as EmployeeActionActionEnum;
          result.action = valueDes;
          break;
        case r'attendance_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.attendanceId = valueDes;
          break;
        case r'at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.at = valueDes;
          break;
        case r'lat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.lat = valueDes;
          break;
        case r'lng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.lng = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
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
  EmployeeAction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EmployeeActionBuilder();
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

class EmployeeActionActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CHECK_IN')
  static const EmployeeActionActionEnum CHECK_IN = _$employeeActionActionEnum_CHECK_IN;
  @BuiltValueEnumConst(wireName: r'CHECK_OUT')
  static const EmployeeActionActionEnum CHECK_OUT = _$employeeActionActionEnum_CHECK_OUT;

  static Serializer<EmployeeActionActionEnum> get serializer => _$employeeActionActionEnumSerializer;

  const EmployeeActionActionEnum._(String name): super(name);

  static BuiltSet<EmployeeActionActionEnum> get values => _$employeeActionActionEnumValues;
  static EmployeeActionActionEnum valueOf(String name) => _$employeeActionActionEnumValueOf(name);
}

