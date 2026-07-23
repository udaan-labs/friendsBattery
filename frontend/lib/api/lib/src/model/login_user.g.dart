// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LoginUserRoleEnum _$loginUserRoleEnum_ADMIN = const LoginUserRoleEnum._(
  'ADMIN',
);
const LoginUserRoleEnum _$loginUserRoleEnum_SELLER = const LoginUserRoleEnum._(
  'SELLER',
);

LoginUserRoleEnum _$loginUserRoleEnumValueOf(String name) {
  switch (name) {
    case 'ADMIN':
      return _$loginUserRoleEnum_ADMIN;
    case 'SELLER':
      return _$loginUserRoleEnum_SELLER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<LoginUserRoleEnum> _$loginUserRoleEnumValues =
    BuiltSet<LoginUserRoleEnum>(const <LoginUserRoleEnum>[
      _$loginUserRoleEnum_ADMIN,
      _$loginUserRoleEnum_SELLER,
    ]);

Serializer<LoginUserRoleEnum> _$loginUserRoleEnumSerializer =
    _$LoginUserRoleEnumSerializer();

class _$LoginUserRoleEnumSerializer
    implements PrimitiveSerializer<LoginUserRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ADMIN': 'ADMIN',
    'SELLER': 'SELLER',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ADMIN': 'ADMIN',
    'SELLER': 'SELLER',
  };

  @override
  final Iterable<Type> types = const <Type>[LoginUserRoleEnum];
  @override
  final String wireName = 'LoginUserRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    LoginUserRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LoginUserRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LoginUserRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$LoginUser extends LoginUser {
  @override
  final String? username;
  @override
  final String? userNumber;
  @override
  final String? shopName;
  @override
  final LoginUserRoleEnum? role;

  factory _$LoginUser([void Function(LoginUserBuilder)? updates]) =>
      (LoginUserBuilder()..update(updates))._build();

  _$LoginUser._({this.username, this.userNumber, this.shopName, this.role})
    : super._();
  @override
  LoginUser rebuild(void Function(LoginUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginUserBuilder toBuilder() => LoginUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginUser &&
        username == other.username &&
        userNumber == other.userNumber &&
        shopName == other.shopName &&
        role == other.role;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, userNumber.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginUser')
          ..add('username', username)
          ..add('userNumber', userNumber)
          ..add('shopName', shopName)
          ..add('role', role))
        .toString();
  }
}

class LoginUserBuilder implements Builder<LoginUser, LoginUserBuilder> {
  _$LoginUser? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _userNumber;
  String? get userNumber => _$this._userNumber;
  set userNumber(String? userNumber) => _$this._userNumber = userNumber;

  String? _shopName;
  String? get shopName => _$this._shopName;
  set shopName(String? shopName) => _$this._shopName = shopName;

  LoginUserRoleEnum? _role;
  LoginUserRoleEnum? get role => _$this._role;
  set role(LoginUserRoleEnum? role) => _$this._role = role;

  LoginUserBuilder() {
    LoginUser._defaults(this);
  }

  LoginUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _userNumber = $v.userNumber;
      _shopName = $v.shopName;
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginUser other) {
    _$v = other as _$LoginUser;
  }

  @override
  void update(void Function(LoginUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginUser build() => _build();

  _$LoginUser _build() {
    final _$result =
        _$v ??
        _$LoginUser._(
          username: username,
          userNumber: userNumber,
          shopName: shopName,
          role: role,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
