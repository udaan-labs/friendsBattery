// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_employee.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreatedEmployeeRoleEnum _$createdEmployeeRoleEnum_EMPLOYEE =
    const CreatedEmployeeRoleEnum._('EMPLOYEE');

CreatedEmployeeRoleEnum _$createdEmployeeRoleEnumValueOf(String name) {
  switch (name) {
    case 'EMPLOYEE':
      return _$createdEmployeeRoleEnum_EMPLOYEE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreatedEmployeeRoleEnum> _$createdEmployeeRoleEnumValues =
    BuiltSet<CreatedEmployeeRoleEnum>(const <CreatedEmployeeRoleEnum>[
      _$createdEmployeeRoleEnum_EMPLOYEE,
    ]);

Serializer<CreatedEmployeeRoleEnum> _$createdEmployeeRoleEnumSerializer =
    _$CreatedEmployeeRoleEnumSerializer();

class _$CreatedEmployeeRoleEnumSerializer
    implements PrimitiveSerializer<CreatedEmployeeRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'EMPLOYEE': 'EMPLOYEE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'EMPLOYEE': 'EMPLOYEE',
  };

  @override
  final Iterable<Type> types = const <Type>[CreatedEmployeeRoleEnum];
  @override
  final String wireName = 'CreatedEmployeeRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreatedEmployeeRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreatedEmployeeRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreatedEmployeeRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreatedEmployee extends CreatedEmployee {
  @override
  final int? id;
  @override
  final String? userId;
  @override
  final String? userName;
  @override
  final String? userNumber;
  @override
  final String? shopName;
  @override
  final CreatedEmployeeRoleEnum? role;
  @override
  final bool? isActive;
  @override
  final bool? isVerified;
  @override
  final LoginUserEmployeeRole? employeeRole;
  @override
  final int? locationId;
  @override
  final CreatedEmployeeLocation? location;
  @override
  final DateTime? createdAt;

  factory _$CreatedEmployee([void Function(CreatedEmployeeBuilder)? updates]) =>
      (CreatedEmployeeBuilder()..update(updates))._build();

  _$CreatedEmployee._({
    this.id,
    this.userId,
    this.userName,
    this.userNumber,
    this.shopName,
    this.role,
    this.isActive,
    this.isVerified,
    this.employeeRole,
    this.locationId,
    this.location,
    this.createdAt,
  }) : super._();
  @override
  CreatedEmployee rebuild(void Function(CreatedEmployeeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatedEmployeeBuilder toBuilder() => CreatedEmployeeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatedEmployee &&
        id == other.id &&
        userId == other.userId &&
        userName == other.userName &&
        userNumber == other.userNumber &&
        shopName == other.shopName &&
        role == other.role &&
        isActive == other.isActive &&
        isVerified == other.isVerified &&
        employeeRole == other.employeeRole &&
        locationId == other.locationId &&
        location == other.location &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userNumber.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, isVerified.hashCode);
    _$hash = $jc(_$hash, employeeRole.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatedEmployee')
          ..add('id', id)
          ..add('userId', userId)
          ..add('userName', userName)
          ..add('userNumber', userNumber)
          ..add('shopName', shopName)
          ..add('role', role)
          ..add('isActive', isActive)
          ..add('isVerified', isVerified)
          ..add('employeeRole', employeeRole)
          ..add('locationId', locationId)
          ..add('location', location)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class CreatedEmployeeBuilder
    implements Builder<CreatedEmployee, CreatedEmployeeBuilder> {
  _$CreatedEmployee? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userNumber;
  String? get userNumber => _$this._userNumber;
  set userNumber(String? userNumber) => _$this._userNumber = userNumber;

  String? _shopName;
  String? get shopName => _$this._shopName;
  set shopName(String? shopName) => _$this._shopName = shopName;

  CreatedEmployeeRoleEnum? _role;
  CreatedEmployeeRoleEnum? get role => _$this._role;
  set role(CreatedEmployeeRoleEnum? role) => _$this._role = role;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  bool? _isVerified;
  bool? get isVerified => _$this._isVerified;
  set isVerified(bool? isVerified) => _$this._isVerified = isVerified;

  LoginUserEmployeeRoleBuilder? _employeeRole;
  LoginUserEmployeeRoleBuilder get employeeRole =>
      _$this._employeeRole ??= LoginUserEmployeeRoleBuilder();
  set employeeRole(LoginUserEmployeeRoleBuilder? employeeRole) =>
      _$this._employeeRole = employeeRole;

  int? _locationId;
  int? get locationId => _$this._locationId;
  set locationId(int? locationId) => _$this._locationId = locationId;

  CreatedEmployeeLocationBuilder? _location;
  CreatedEmployeeLocationBuilder get location =>
      _$this._location ??= CreatedEmployeeLocationBuilder();
  set location(CreatedEmployeeLocationBuilder? location) =>
      _$this._location = location;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  CreatedEmployeeBuilder() {
    CreatedEmployee._defaults(this);
  }

  CreatedEmployeeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _userName = $v.userName;
      _userNumber = $v.userNumber;
      _shopName = $v.shopName;
      _role = $v.role;
      _isActive = $v.isActive;
      _isVerified = $v.isVerified;
      _employeeRole = $v.employeeRole?.toBuilder();
      _locationId = $v.locationId;
      _location = $v.location?.toBuilder();
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatedEmployee other) {
    _$v = other as _$CreatedEmployee;
  }

  @override
  void update(void Function(CreatedEmployeeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatedEmployee build() => _build();

  _$CreatedEmployee _build() {
    _$CreatedEmployee _$result;
    try {
      _$result =
          _$v ??
          _$CreatedEmployee._(
            id: id,
            userId: userId,
            userName: userName,
            userNumber: userNumber,
            shopName: shopName,
            role: role,
            isActive: isActive,
            isVerified: isVerified,
            employeeRole: _employeeRole?.build(),
            locationId: locationId,
            location: _location?.build(),
            createdAt: createdAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'employeeRole';
        _employeeRole?.build();

        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreatedEmployee',
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
