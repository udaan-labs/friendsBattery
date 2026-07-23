// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegisterData extends RegisterData {
  @override
  final String? userId;
  @override
  final String? username;
  @override
  final String? userNumber;
  @override
  final String? shopName;
  @override
  final String? role;
  @override
  final bool? isActive;
  @override
  final bool? isVerified;
  @override
  final DateTime? createdAt;

  factory _$RegisterData([void Function(RegisterDataBuilder)? updates]) =>
      (RegisterDataBuilder()..update(updates))._build();

  _$RegisterData._({
    this.userId,
    this.username,
    this.userNumber,
    this.shopName,
    this.role,
    this.isActive,
    this.isVerified,
    this.createdAt,
  }) : super._();
  @override
  RegisterData rebuild(void Function(RegisterDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterDataBuilder toBuilder() => RegisterDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterData &&
        userId == other.userId &&
        username == other.username &&
        userNumber == other.userNumber &&
        shopName == other.shopName &&
        role == other.role &&
        isActive == other.isActive &&
        isVerified == other.isVerified &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, userNumber.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, isVerified.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterData')
          ..add('userId', userId)
          ..add('username', username)
          ..add('userNumber', userNumber)
          ..add('shopName', shopName)
          ..add('role', role)
          ..add('isActive', isActive)
          ..add('isVerified', isVerified)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class RegisterDataBuilder
    implements Builder<RegisterData, RegisterDataBuilder> {
  _$RegisterData? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _userNumber;
  String? get userNumber => _$this._userNumber;
  set userNumber(String? userNumber) => _$this._userNumber = userNumber;

  String? _shopName;
  String? get shopName => _$this._shopName;
  set shopName(String? shopName) => _$this._shopName = shopName;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  bool? _isVerified;
  bool? get isVerified => _$this._isVerified;
  set isVerified(bool? isVerified) => _$this._isVerified = isVerified;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  RegisterDataBuilder() {
    RegisterData._defaults(this);
  }

  RegisterDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _username = $v.username;
      _userNumber = $v.userNumber;
      _shopName = $v.shopName;
      _role = $v.role;
      _isActive = $v.isActive;
      _isVerified = $v.isVerified;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterData other) {
    _$v = other as _$RegisterData;
  }

  @override
  void update(void Function(RegisterDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterData build() => _build();

  _$RegisterData _build() {
    final _$result =
        _$v ??
        _$RegisterData._(
          userId: userId,
          username: username,
          userNumber: userNumber,
          shopName: shopName,
          role: role,
          isActive: isActive,
          isVerified: isVerified,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
