// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountUserRoleEnum _$accountUserRoleEnum_ADMIN =
    const AccountUserRoleEnum._('ADMIN');
const AccountUserRoleEnum _$accountUserRoleEnum_SELLER =
    const AccountUserRoleEnum._('SELLER');
const AccountUserRoleEnum _$accountUserRoleEnum_EMPLOYEE =
    const AccountUserRoleEnum._('EMPLOYEE');

AccountUserRoleEnum _$accountUserRoleEnumValueOf(String name) {
  switch (name) {
    case 'ADMIN':
      return _$accountUserRoleEnum_ADMIN;
    case 'SELLER':
      return _$accountUserRoleEnum_SELLER;
    case 'EMPLOYEE':
      return _$accountUserRoleEnum_EMPLOYEE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccountUserRoleEnum> _$accountUserRoleEnumValues =
    BuiltSet<AccountUserRoleEnum>(const <AccountUserRoleEnum>[
      _$accountUserRoleEnum_ADMIN,
      _$accountUserRoleEnum_SELLER,
      _$accountUserRoleEnum_EMPLOYEE,
    ]);

Serializer<AccountUserRoleEnum> _$accountUserRoleEnumSerializer =
    _$AccountUserRoleEnumSerializer();

class _$AccountUserRoleEnumSerializer
    implements PrimitiveSerializer<AccountUserRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ADMIN': 'ADMIN',
    'SELLER': 'SELLER',
    'EMPLOYEE': 'EMPLOYEE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ADMIN': 'ADMIN',
    'SELLER': 'SELLER',
    'EMPLOYEE': 'EMPLOYEE',
  };

  @override
  final Iterable<Type> types = const <Type>[AccountUserRoleEnum];
  @override
  final String wireName = 'AccountUserRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    AccountUserRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AccountUserRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AccountUserRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AccountUser extends AccountUser {
  @override
  final int? id;
  @override
  final String? userId;
  @override
  final String? userName;
  @override
  final AccountUserRoleEnum? role;
  @override
  final bool? isActive;
  @override
  final AccountUserLocation? location;

  factory _$AccountUser([void Function(AccountUserBuilder)? updates]) =>
      (AccountUserBuilder()..update(updates))._build();

  _$AccountUser._({
    this.id,
    this.userId,
    this.userName,
    this.role,
    this.isActive,
    this.location,
  }) : super._();
  @override
  AccountUser rebuild(void Function(AccountUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountUserBuilder toBuilder() => AccountUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountUser &&
        id == other.id &&
        userId == other.userId &&
        userName == other.userName &&
        role == other.role &&
        isActive == other.isActive &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountUser')
          ..add('id', id)
          ..add('userId', userId)
          ..add('userName', userName)
          ..add('role', role)
          ..add('isActive', isActive)
          ..add('location', location))
        .toString();
  }
}

class AccountUserBuilder implements Builder<AccountUser, AccountUserBuilder> {
  _$AccountUser? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  AccountUserRoleEnum? _role;
  AccountUserRoleEnum? get role => _$this._role;
  set role(AccountUserRoleEnum? role) => _$this._role = role;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  AccountUserLocationBuilder? _location;
  AccountUserLocationBuilder get location =>
      _$this._location ??= AccountUserLocationBuilder();
  set location(AccountUserLocationBuilder? location) =>
      _$this._location = location;

  AccountUserBuilder() {
    AccountUser._defaults(this);
  }

  AccountUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _userName = $v.userName;
      _role = $v.role;
      _isActive = $v.isActive;
      _location = $v.location?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountUser other) {
    _$v = other as _$AccountUser;
  }

  @override
  void update(void Function(AccountUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountUser build() => _build();

  _$AccountUser _build() {
    _$AccountUser _$result;
    try {
      _$result =
          _$v ??
          _$AccountUser._(
            id: id,
            userId: userId,
            userName: userName,
            role: role,
            isActive: isActive,
            location: _location?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountUser',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
