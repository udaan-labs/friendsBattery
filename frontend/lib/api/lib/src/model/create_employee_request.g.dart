// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_employee_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateEmployeeRequest extends CreateEmployeeRequest {
  @override
  final String? userId;
  @override
  final String username;
  @override
  final String userNumber;
  @override
  final String password;
  @override
  final int? employeeRoleId;
  @override
  final int? locationId;

  factory _$CreateEmployeeRequest([
    void Function(CreateEmployeeRequestBuilder)? updates,
  ]) => (CreateEmployeeRequestBuilder()..update(updates))._build();

  _$CreateEmployeeRequest._({
    this.userId,
    required this.username,
    required this.userNumber,
    required this.password,
    this.employeeRoleId,
    this.locationId,
  }) : super._();
  @override
  CreateEmployeeRequest rebuild(
    void Function(CreateEmployeeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateEmployeeRequestBuilder toBuilder() =>
      CreateEmployeeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateEmployeeRequest &&
        userId == other.userId &&
        username == other.username &&
        userNumber == other.userNumber &&
        password == other.password &&
        employeeRoleId == other.employeeRoleId &&
        locationId == other.locationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, userNumber.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, employeeRoleId.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateEmployeeRequest')
          ..add('userId', userId)
          ..add('username', username)
          ..add('userNumber', userNumber)
          ..add('password', password)
          ..add('employeeRoleId', employeeRoleId)
          ..add('locationId', locationId))
        .toString();
  }
}

class CreateEmployeeRequestBuilder
    implements Builder<CreateEmployeeRequest, CreateEmployeeRequestBuilder> {
  _$CreateEmployeeRequest? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _userNumber;
  String? get userNumber => _$this._userNumber;
  set userNumber(String? userNumber) => _$this._userNumber = userNumber;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  int? _employeeRoleId;
  int? get employeeRoleId => _$this._employeeRoleId;
  set employeeRoleId(int? employeeRoleId) =>
      _$this._employeeRoleId = employeeRoleId;

  int? _locationId;
  int? get locationId => _$this._locationId;
  set locationId(int? locationId) => _$this._locationId = locationId;

  CreateEmployeeRequestBuilder() {
    CreateEmployeeRequest._defaults(this);
  }

  CreateEmployeeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _username = $v.username;
      _userNumber = $v.userNumber;
      _password = $v.password;
      _employeeRoleId = $v.employeeRoleId;
      _locationId = $v.locationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateEmployeeRequest other) {
    _$v = other as _$CreateEmployeeRequest;
  }

  @override
  void update(void Function(CreateEmployeeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateEmployeeRequest build() => _build();

  _$CreateEmployeeRequest _build() {
    final _$result =
        _$v ??
        _$CreateEmployeeRequest._(
          userId: userId,
          username: BuiltValueNullFieldError.checkNotNull(
            username,
            r'CreateEmployeeRequest',
            'username',
          ),
          userNumber: BuiltValueNullFieldError.checkNotNull(
            userNumber,
            r'CreateEmployeeRequest',
            'userNumber',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'CreateEmployeeRequest',
            'password',
          ),
          employeeRoleId: employeeRoleId,
          locationId: locationId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
