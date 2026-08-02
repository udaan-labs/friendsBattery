// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_staff_member.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ShopStaffMemberRoleEnum _$shopStaffMemberRoleEnum_SELLER =
    const ShopStaffMemberRoleEnum._('SELLER');
const ShopStaffMemberRoleEnum _$shopStaffMemberRoleEnum_EMPLOYEE =
    const ShopStaffMemberRoleEnum._('EMPLOYEE');

ShopStaffMemberRoleEnum _$shopStaffMemberRoleEnumValueOf(String name) {
  switch (name) {
    case 'SELLER':
      return _$shopStaffMemberRoleEnum_SELLER;
    case 'EMPLOYEE':
      return _$shopStaffMemberRoleEnum_EMPLOYEE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ShopStaffMemberRoleEnum> _$shopStaffMemberRoleEnumValues =
    BuiltSet<ShopStaffMemberRoleEnum>(const <ShopStaffMemberRoleEnum>[
      _$shopStaffMemberRoleEnum_SELLER,
      _$shopStaffMemberRoleEnum_EMPLOYEE,
    ]);

Serializer<ShopStaffMemberRoleEnum> _$shopStaffMemberRoleEnumSerializer =
    _$ShopStaffMemberRoleEnumSerializer();

class _$ShopStaffMemberRoleEnumSerializer
    implements PrimitiveSerializer<ShopStaffMemberRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SELLER': 'SELLER',
    'EMPLOYEE': 'EMPLOYEE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SELLER': 'SELLER',
    'EMPLOYEE': 'EMPLOYEE',
  };

  @override
  final Iterable<Type> types = const <Type>[ShopStaffMemberRoleEnum];
  @override
  final String wireName = 'ShopStaffMemberRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    ShopStaffMemberRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ShopStaffMemberRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ShopStaffMemberRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ShopStaffMember extends ShopStaffMember {
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
  final ShopStaffMemberRoleEnum? role;
  @override
  final bool? isActive;
  @override
  final bool? isVerified;
  @override
  final LoginUserEmployeeRole? employeeRole;

  factory _$ShopStaffMember([void Function(ShopStaffMemberBuilder)? updates]) =>
      (ShopStaffMemberBuilder()..update(updates))._build();

  _$ShopStaffMember._({
    this.id,
    this.userId,
    this.userName,
    this.userNumber,
    this.shopName,
    this.role,
    this.isActive,
    this.isVerified,
    this.employeeRole,
  }) : super._();
  @override
  ShopStaffMember rebuild(void Function(ShopStaffMemberBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShopStaffMemberBuilder toBuilder() => ShopStaffMemberBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShopStaffMember &&
        id == other.id &&
        userId == other.userId &&
        userName == other.userName &&
        userNumber == other.userNumber &&
        shopName == other.shopName &&
        role == other.role &&
        isActive == other.isActive &&
        isVerified == other.isVerified &&
        employeeRole == other.employeeRole;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ShopStaffMember')
          ..add('id', id)
          ..add('userId', userId)
          ..add('userName', userName)
          ..add('userNumber', userNumber)
          ..add('shopName', shopName)
          ..add('role', role)
          ..add('isActive', isActive)
          ..add('isVerified', isVerified)
          ..add('employeeRole', employeeRole))
        .toString();
  }
}

class ShopStaffMemberBuilder
    implements Builder<ShopStaffMember, ShopStaffMemberBuilder> {
  _$ShopStaffMember? _$v;

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

  ShopStaffMemberRoleEnum? _role;
  ShopStaffMemberRoleEnum? get role => _$this._role;
  set role(ShopStaffMemberRoleEnum? role) => _$this._role = role;

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

  ShopStaffMemberBuilder() {
    ShopStaffMember._defaults(this);
  }

  ShopStaffMemberBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShopStaffMember other) {
    _$v = other as _$ShopStaffMember;
  }

  @override
  void update(void Function(ShopStaffMemberBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ShopStaffMember build() => _build();

  _$ShopStaffMember _build() {
    _$ShopStaffMember _$result;
    try {
      _$result =
          _$v ??
          _$ShopStaffMember._(
            id: id,
            userId: userId,
            userName: userName,
            userNumber: userNumber,
            shopName: shopName,
            role: role,
            isActive: isActive,
            isVerified: isVerified,
            employeeRole: _employeeRole?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'employeeRole';
        _employeeRole?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ShopStaffMember',
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
