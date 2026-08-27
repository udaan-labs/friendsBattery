//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/login_user_employee_role.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'shop_staff_member.g.dart';

/// ShopStaffMember
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
@BuiltValue()
abstract class ShopStaffMember implements Built<ShopStaffMember, ShopStaffMemberBuilder> {
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
  ShopStaffMemberRoleEnum? get role;
  // enum roleEnum {  ADMIN,  SELLER,  EMPLOYEE,  };

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  @BuiltValueField(wireName: r'is_verified')
  bool? get isVerified;

  @BuiltValueField(wireName: r'employee_role')
  LoginUserEmployeeRole? get employeeRole;

  ShopStaffMember._();

  factory ShopStaffMember([void updates(ShopStaffMemberBuilder b)]) = _$ShopStaffMember;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ShopStaffMemberBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ShopStaffMember> get serializer => _$ShopStaffMemberSerializer();
}

class _$ShopStaffMemberSerializer implements PrimitiveSerializer<ShopStaffMember> {
  @override
  final Iterable<Type> types = const [ShopStaffMember, _$ShopStaffMember];

  @override
  final String wireName = r'ShopStaffMember';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ShopStaffMember object, {
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
        specifiedType: const FullType(ShopStaffMemberRoleEnum),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ShopStaffMember object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ShopStaffMemberBuilder result,
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
            specifiedType: const FullType(ShopStaffMemberRoleEnum),
          ) as ShopStaffMemberRoleEnum;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ShopStaffMember deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ShopStaffMemberBuilder();
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

class ShopStaffMemberRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const ShopStaffMemberRoleEnum ADMIN = _$shopStaffMemberRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'SELLER')
  static const ShopStaffMemberRoleEnum SELLER = _$shopStaffMemberRoleEnum_SELLER;
  @BuiltValueEnumConst(wireName: r'EMPLOYEE')
  static const ShopStaffMemberRoleEnum EMPLOYEE = _$shopStaffMemberRoleEnum_EMPLOYEE;

  static Serializer<ShopStaffMemberRoleEnum> get serializer => _$shopStaffMemberRoleEnumSerializer;

  const ShopStaffMemberRoleEnum._(String name): super(name);

  static BuiltSet<ShopStaffMemberRoleEnum> get values => _$shopStaffMemberRoleEnumValues;
  static ShopStaffMemberRoleEnum valueOf(String name) => _$shopStaffMemberRoleEnumValueOf(name);
}

