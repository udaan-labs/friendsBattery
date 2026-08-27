//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/created_employee_location.dart';
import 'package:friends_battery_api/src/model/login_user_employee_role.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'created_employee.g.dart';

/// CreatedEmployee
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [userName] 
/// * [userNumber] 
/// * [shopName] 
/// * [role] 
/// * [isActive] 
/// * [isVerified] 
/// * [employeeRole] 
/// * [locationId] 
/// * [location] 
/// * [createdAt] 
@BuiltValue()
abstract class CreatedEmployee implements Built<CreatedEmployee, CreatedEmployeeBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'user_id')
  String? get userId;

  @BuiltValueField(wireName: r'user_name')
  String? get userName;

  @BuiltValueField(wireName: r'user_number')
  String? get userNumber;

  @BuiltValueField(wireName: r'shop_name')
  String? get shopName;

  @BuiltValueField(wireName: r'role')
  CreatedEmployeeRoleEnum? get role;
  // enum roleEnum {  EMPLOYEE,  };

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  @BuiltValueField(wireName: r'is_verified')
  bool? get isVerified;

  @BuiltValueField(wireName: r'employee_role')
  LoginUserEmployeeRole? get employeeRole;

  @BuiltValueField(wireName: r'location_id')
  int? get locationId;

  @BuiltValueField(wireName: r'location')
  CreatedEmployeeLocation? get location;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  CreatedEmployee._();

  factory CreatedEmployee([void updates(CreatedEmployeeBuilder b)]) = _$CreatedEmployee;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatedEmployeeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatedEmployee> get serializer => _$CreatedEmployeeSerializer();
}

class _$CreatedEmployeeSerializer implements PrimitiveSerializer<CreatedEmployee> {
  @override
  final Iterable<Type> types = const [CreatedEmployee, _$CreatedEmployee];

  @override
  final String wireName = r'CreatedEmployee';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatedEmployee object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'user_id';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.userName != null) {
      yield r'user_name';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.userNumber != null) {
      yield r'user_number';
      yield serializers.serialize(
        object.userNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.shopName != null) {
      yield r'shop_name';
      yield serializers.serialize(
        object.shopName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(CreatedEmployeeRoleEnum),
      );
    }
    if (object.isActive != null) {
      yield r'is_active';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isVerified != null) {
      yield r'is_verified';
      yield serializers.serialize(
        object.isVerified,
        specifiedType: const FullType(bool),
      );
    }
    if (object.employeeRole != null) {
      yield r'employee_role';
      yield serializers.serialize(
        object.employeeRole,
        specifiedType: const FullType.nullable(LoginUserEmployeeRole),
      );
    }
    if (object.locationId != null) {
      yield r'location_id';
      yield serializers.serialize(
        object.locationId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType.nullable(CreatedEmployeeLocation),
      );
    }
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatedEmployee object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatedEmployeeBuilder result,
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
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'user_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'user_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userNumber = valueDes;
          break;
        case r'shop_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.shopName = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreatedEmployeeRoleEnum),
          ) as CreatedEmployeeRoleEnum;
          result.role = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'is_verified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isVerified = valueDes;
          break;
        case r'employee_role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LoginUserEmployeeRole),
          ) as LoginUserEmployeeRole?;
          if (valueDes == null) continue;
          result.employeeRole.replace(valueDes);
          break;
        case r'location_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.locationId = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CreatedEmployeeLocation),
          ) as CreatedEmployeeLocation?;
          if (valueDes == null) continue;
          result.location.replace(valueDes);
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatedEmployee deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatedEmployeeBuilder();
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

class CreatedEmployeeRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'EMPLOYEE')
  static const CreatedEmployeeRoleEnum EMPLOYEE = _$createdEmployeeRoleEnum_EMPLOYEE;

  static Serializer<CreatedEmployeeRoleEnum> get serializer => _$createdEmployeeRoleEnumSerializer;

  const CreatedEmployeeRoleEnum._(String name): super(name);

  static BuiltSet<CreatedEmployeeRoleEnum> get values => _$createdEmployeeRoleEnumValues;
  static CreatedEmployeeRoleEnum valueOf(String name) => _$createdEmployeeRoleEnumValueOf(name);
}

