// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserRoleEnum _$userRoleEnum_ADMIN = const UserRoleEnum._('ADMIN');
const UserRoleEnum _$userRoleEnum_SELLER = const UserRoleEnum._('SELLER');

UserRoleEnum _$userRoleEnumValueOf(String name) {
  switch (name) {
    case 'ADMIN':
      return _$userRoleEnum_ADMIN;
    case 'SELLER':
      return _$userRoleEnum_SELLER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserRoleEnum> _$userRoleEnumValues = BuiltSet<UserRoleEnum>(
  const <UserRoleEnum>[_$userRoleEnum_ADMIN, _$userRoleEnum_SELLER],
);

Serializer<UserRoleEnum> _$userRoleEnumSerializer = _$UserRoleEnumSerializer();

class _$UserRoleEnumSerializer implements PrimitiveSerializer<UserRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ADMIN': 'ADMIN',
    'SELLER': 'SELLER',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ADMIN': 'ADMIN',
    'SELLER': 'SELLER',
  };

  @override
  final Iterable<Type> types = const <Type>[UserRoleEnum];
  @override
  final String wireName = 'UserRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    UserRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UserRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UserRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$User extends User {
  @override
  final String? id;
  @override
  final String? userId;
  @override
  final String? userName;
  @override
  final UserRoleEnum? role;
  @override
  final String? userNumber;
  @override
  final String? shopName;
  @override
  final bool? isActive;
  @override
  final bool? isVerified;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (UserBuilder()..update(updates))._build();

  _$User._({
    this.id,
    this.userId,
    this.userName,
    this.role,
    this.userNumber,
    this.shopName,
    this.isActive,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        userId == other.userId &&
        userName == other.userName &&
        role == other.role &&
        userNumber == other.userNumber &&
        shopName == other.shopName &&
        isActive == other.isActive &&
        isVerified == other.isVerified &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, userNumber.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, isVerified.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'User')
          ..add('id', id)
          ..add('userId', userId)
          ..add('userName', userName)
          ..add('role', role)
          ..add('userNumber', userNumber)
          ..add('shopName', shopName)
          ..add('isActive', isActive)
          ..add('isVerified', isVerified)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  UserRoleEnum? _role;
  UserRoleEnum? get role => _$this._role;
  set role(UserRoleEnum? role) => _$this._role = role;

  String? _userNumber;
  String? get userNumber => _$this._userNumber;
  set userNumber(String? userNumber) => _$this._userNumber = userNumber;

  String? _shopName;
  String? get shopName => _$this._shopName;
  set shopName(String? shopName) => _$this._shopName = shopName;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  bool? _isVerified;
  bool? get isVerified => _$this._isVerified;
  set isVerified(bool? isVerified) => _$this._isVerified = isVerified;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  UserBuilder() {
    User._defaults(this);
  }

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _userName = $v.userName;
      _role = $v.role;
      _userNumber = $v.userNumber;
      _shopName = $v.shopName;
      _isActive = $v.isActive;
      _isVerified = $v.isVerified;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  User build() => _build();

  _$User _build() {
    final _$result =
        _$v ??
        _$User._(
          id: id,
          userId: userId,
          userName: userName,
          role: role,
          userNumber: userNumber,
          shopName: shopName,
          isActive: isActive,
          isVerified: isVerified,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
