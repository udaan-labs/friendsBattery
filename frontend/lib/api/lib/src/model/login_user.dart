//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/login_user_location.dart';
import 'package:friends_battery_api/src/model/login_user_employee_role.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_user.g.dart';

/// LoginUser
///
/// Properties:
/// * [id] 
/// * [username] 
/// * [userNumber] 
/// * [shopName] 
/// * [role] 
/// * [locationId] 
/// * [employeeRoleId] 
/// * [location] 
/// * [employeeRole] 
@BuiltValue()
abstract class LoginUser implements Built<LoginUser, LoginUserBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'username')
  String? get username;

  @BuiltValueField(wireName: r'user_number')
  String? get userNumber;

  @BuiltValueField(wireName: r'shop_name')
  String? get shopName;

  @BuiltValueField(wireName: r'role')
  LoginUserRoleEnum? get role;
  // enum roleEnum {  ADMIN,  SELLER,  EMPLOYEE,  };

  @BuiltValueField(wireName: r'location_id')
  int? get locationId;

  @BuiltValueField(wireName: r'employee_role_id')
  int? get employeeRoleId;

  @BuiltValueField(wireName: r'location')
  LoginUserLocation? get location;

  @BuiltValueField(wireName: r'employee_role')
  LoginUserEmployeeRole? get employeeRole;

  LoginUser._();

  factory LoginUser([void updates(LoginUserBuilder b)]) = _$LoginUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginUser> get serializer => _$LoginUserSerializer();
}

class _$LoginUserSerializer implements PrimitiveSerializer<LoginUser> {
  @override
  final Iterable<Type> types = const [LoginUser, _$LoginUser];

  @override
  final String wireName = r'LoginUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.username != null) {
      yield r'username';
      yield serializers.serialize(
        object.username,
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
        specifiedType: const FullType(LoginUserRoleEnum),
      );
    }
    if (object.locationId != null) {
      yield r'location_id';
      yield serializers.serialize(
        object.locationId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.employeeRoleId != null) {
      yield r'employee_role_id';
      yield serializers.serialize(
        object.employeeRoleId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType.nullable(LoginUserLocation),
      );
    }
    if (object.employeeRole != null) {
      yield r'employee_role';
      yield serializers.serialize(
        object.employeeRole,
        specifiedType: const FullType.nullable(LoginUserEmployeeRole),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginUserBuilder result,
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
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
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
            specifiedType: const FullType(LoginUserRoleEnum),
          ) as LoginUserRoleEnum;
          result.role = valueDes;
          break;
        case r'location_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.locationId = valueDes;
          break;
        case r'employee_role_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.employeeRoleId = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LoginUserLocation),
          ) as LoginUserLocation?;
          if (valueDes == null) continue;
          result.location.replace(valueDes);
          break;
        case r'employee_role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LoginUserEmployeeRole),
          ) as LoginUserEmployeeRole?;
          if (valueDes == null) continue;
          result.employeeRole.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginUserBuilder();
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

class LoginUserRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const LoginUserRoleEnum ADMIN = _$loginUserRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'SELLER')
  static const LoginUserRoleEnum SELLER = _$loginUserRoleEnum_SELLER;
  @BuiltValueEnumConst(wireName: r'EMPLOYEE')
  static const LoginUserRoleEnum EMPLOYEE = _$loginUserRoleEnum_EMPLOYEE;

  static Serializer<LoginUserRoleEnum> get serializer => _$loginUserRoleEnumSerializer;

  const LoginUserRoleEnum._(String name): super(name);

  static BuiltSet<LoginUserRoleEnum> get values => _$loginUserRoleEnumValues;
  static LoginUserRoleEnum valueOf(String name) => _$loginUserRoleEnumValueOf(name);
}

