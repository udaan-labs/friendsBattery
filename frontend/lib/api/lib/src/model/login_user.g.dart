// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LoginUserRoleEnum _$loginUserRoleEnum_SUPER_ADMIN =
    const LoginUserRoleEnum._('SUPER_ADMIN');
const LoginUserRoleEnum _$loginUserRoleEnum_ADMIN = const LoginUserRoleEnum._(
  'ADMIN',
);
const LoginUserRoleEnum _$loginUserRoleEnum_SELLER = const LoginUserRoleEnum._(
  'SELLER',
);
const LoginUserRoleEnum _$loginUserRoleEnum_EMPLOYEE =
    const LoginUserRoleEnum._('EMPLOYEE');

LoginUserRoleEnum _$loginUserRoleEnumValueOf(String name) {
  switch (name) {
    case 'SUPER_ADMIN':
      return _$loginUserRoleEnum_SUPER_ADMIN;
    case 'ADMIN':
      return _$loginUserRoleEnum_ADMIN;
    case 'SELLER':
      return _$loginUserRoleEnum_SELLER;
    case 'EMPLOYEE':
      return _$loginUserRoleEnum_EMPLOYEE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<LoginUserRoleEnum> _$loginUserRoleEnumValues =
    BuiltSet<LoginUserRoleEnum>(const <LoginUserRoleEnum>[
      _$loginUserRoleEnum_SUPER_ADMIN,
      _$loginUserRoleEnum_ADMIN,
      _$loginUserRoleEnum_SELLER,
      _$loginUserRoleEnum_EMPLOYEE,
    ]);

Serializer<LoginUserRoleEnum> _$loginUserRoleEnumSerializer =
    _$LoginUserRoleEnumSerializer();

class _$LoginUserRoleEnumSerializer
    implements PrimitiveSerializer<LoginUserRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SUPER_ADMIN': 'SUPER_ADMIN',
    'ADMIN': 'ADMIN',
    'SELLER': 'SELLER',
    'EMPLOYEE': 'EMPLOYEE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SUPER_ADMIN': 'SUPER_ADMIN',
    'ADMIN': 'ADMIN',
    'SELLER': 'SELLER',
    'EMPLOYEE': 'EMPLOYEE',
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
  final int? id;
  @override
  final String? username;
  @override
  final String? userNumber;
  @override
  final String? shopName;
  @override
  final LoginUserRoleEnum? role;
  @override
  final int? locationId;
  @override
  final int? employeeRoleId;
  @override
  final LoginUserLocation? location;
  @override
  final LoginUserEmployeeRole? employeeRole;

  factory _$LoginUser([void Function(LoginUserBuilder)? updates]) =>
      (LoginUserBuilder()..update(updates))._build();

  _$LoginUser._({
    this.id,
    this.username,
    this.userNumber,
    this.shopName,
    this.role,
    this.locationId,
    this.employeeRoleId,
    this.location,
    this.employeeRole,
  }) : super._();
  @override
  LoginUser rebuild(void Function(LoginUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginUserBuilder toBuilder() => LoginUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginUser &&
        id == other.id &&
        username == other.username &&
        userNumber == other.userNumber &&
        shopName == other.shopName &&
        role == other.role &&
        locationId == other.locationId &&
        employeeRoleId == other.employeeRoleId &&
        location == other.location &&
        employeeRole == other.employeeRole;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, userNumber.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, employeeRoleId.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, employeeRole.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginUser')
          ..add('id', id)
          ..add('username', username)
          ..add('userNumber', userNumber)
          ..add('shopName', shopName)
          ..add('role', role)
          ..add('locationId', locationId)
          ..add('employeeRoleId', employeeRoleId)
          ..add('location', location)
          ..add('employeeRole', employeeRole))
        .toString();
  }
}

class LoginUserBuilder implements Builder<LoginUser, LoginUserBuilder> {
  _$LoginUser? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

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

  int? _locationId;
  int? get locationId => _$this._locationId;
  set locationId(int? locationId) => _$this._locationId = locationId;

  int? _employeeRoleId;
  int? get employeeRoleId => _$this._employeeRoleId;
  set employeeRoleId(int? employeeRoleId) =>
      _$this._employeeRoleId = employeeRoleId;

  LoginUserLocationBuilder? _location;
  LoginUserLocationBuilder get location =>
      _$this._location ??= LoginUserLocationBuilder();
  set location(LoginUserLocationBuilder? location) =>
      _$this._location = location;

  LoginUserEmployeeRoleBuilder? _employeeRole;
  LoginUserEmployeeRoleBuilder get employeeRole =>
      _$this._employeeRole ??= LoginUserEmployeeRoleBuilder();
  set employeeRole(LoginUserEmployeeRoleBuilder? employeeRole) =>
      _$this._employeeRole = employeeRole;

  LoginUserBuilder() {
    LoginUser._defaults(this);
  }

  LoginUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _username = $v.username;
      _userNumber = $v.userNumber;
      _shopName = $v.shopName;
      _role = $v.role;
      _locationId = $v.locationId;
      _employeeRoleId = $v.employeeRoleId;
      _location = $v.location?.toBuilder();
      _employeeRole = $v.employeeRole?.toBuilder();
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
    _$LoginUser _$result;
    try {
      _$result =
          _$v ??
          _$LoginUser._(
            id: id,
            username: username,
            userNumber: userNumber,
            shopName: shopName,
            role: role,
            locationId: locationId,
            employeeRoleId: employeeRoleId,
            location: _location?.build(),
            employeeRole: _employeeRole?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
        _$failedField = 'employeeRole';
        _employeeRole?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LoginUser',
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
