//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/account_user_location.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_user.g.dart';

/// AccountUser
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [userName] 
/// * [role] 
/// * [isActive] 
/// * [location] 
@BuiltValue()
abstract class AccountUser implements Built<AccountUser, AccountUserBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'user_id')
  String? get userId;

  @BuiltValueField(wireName: r'user_name')
  String? get userName;

  @BuiltValueField(wireName: r'role')
  AccountUserRoleEnum? get role;
  // enum roleEnum {  ADMIN,  SELLER,  EMPLOYEE,  };

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  @BuiltValueField(wireName: r'location')
  AccountUserLocation? get location;

  AccountUser._();

  factory AccountUser([void updates(AccountUserBuilder b)]) = _$AccountUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountUser> get serializer => _$AccountUserSerializer();
}

class _$AccountUserSerializer implements PrimitiveSerializer<AccountUser> {
  @override
  final Iterable<Type> types = const [AccountUser, _$AccountUser];

  @override
  final String wireName = r'AccountUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountUser object, {
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
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(AccountUserRoleEnum),
      );
    }
    if (object.isActive != null) {
      yield r'is_active';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType(AccountUserLocation),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountUserBuilder result,
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
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountUserRoleEnum),
          ) as AccountUserRoleEnum;
          result.role = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountUserLocation),
          ) as AccountUserLocation;
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
  AccountUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountUserBuilder();
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

class AccountUserRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const AccountUserRoleEnum ADMIN = _$accountUserRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'SELLER')
  static const AccountUserRoleEnum SELLER = _$accountUserRoleEnum_SELLER;
  @BuiltValueEnumConst(wireName: r'EMPLOYEE')
  static const AccountUserRoleEnum EMPLOYEE = _$accountUserRoleEnum_EMPLOYEE;

  static Serializer<AccountUserRoleEnum> get serializer => _$accountUserRoleEnumSerializer;

  const AccountUserRoleEnum._(String name): super(name);

  static BuiltSet<AccountUserRoleEnum> get values => _$accountUserRoleEnumValues;
  static AccountUserRoleEnum valueOf(String name) => _$accountUserRoleEnumValueOf(name);
}

