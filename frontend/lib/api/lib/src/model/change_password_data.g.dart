// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChangePasswordDataRoleEnum _$changePasswordDataRoleEnum_ADMIN =
    const ChangePasswordDataRoleEnum._('ADMIN');
const ChangePasswordDataRoleEnum _$changePasswordDataRoleEnum_SELLER =
    const ChangePasswordDataRoleEnum._('SELLER');
const ChangePasswordDataRoleEnum _$changePasswordDataRoleEnum_EMPLOYEE =
    const ChangePasswordDataRoleEnum._('EMPLOYEE');

ChangePasswordDataRoleEnum _$changePasswordDataRoleEnumValueOf(String name) {
  switch (name) {
    case 'ADMIN':
      return _$changePasswordDataRoleEnum_ADMIN;
    case 'SELLER':
      return _$changePasswordDataRoleEnum_SELLER;
    case 'EMPLOYEE':
      return _$changePasswordDataRoleEnum_EMPLOYEE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ChangePasswordDataRoleEnum> _$changePasswordDataRoleEnumValues =
    BuiltSet<ChangePasswordDataRoleEnum>(const <ChangePasswordDataRoleEnum>[
      _$changePasswordDataRoleEnum_ADMIN,
      _$changePasswordDataRoleEnum_SELLER,
      _$changePasswordDataRoleEnum_EMPLOYEE,
    ]);

Serializer<ChangePasswordDataRoleEnum> _$changePasswordDataRoleEnumSerializer =
    _$ChangePasswordDataRoleEnumSerializer();

class _$ChangePasswordDataRoleEnumSerializer
    implements PrimitiveSerializer<ChangePasswordDataRoleEnum> {
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
  final Iterable<Type> types = const <Type>[ChangePasswordDataRoleEnum];
  @override
  final String wireName = 'ChangePasswordDataRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    ChangePasswordDataRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ChangePasswordDataRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ChangePasswordDataRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ChangePasswordData extends ChangePasswordData {
  @override
  final int? id;
  @override
  final String? userId;
  @override
  final ChangePasswordDataRoleEnum? role;

  factory _$ChangePasswordData([
    void Function(ChangePasswordDataBuilder)? updates,
  ]) => (ChangePasswordDataBuilder()..update(updates))._build();

  _$ChangePasswordData._({this.id, this.userId, this.role}) : super._();
  @override
  ChangePasswordData rebuild(
    void Function(ChangePasswordDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChangePasswordDataBuilder toBuilder() =>
      ChangePasswordDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangePasswordData &&
        id == other.id &&
        userId == other.userId &&
        role == other.role;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangePasswordData')
          ..add('id', id)
          ..add('userId', userId)
          ..add('role', role))
        .toString();
  }
}

class ChangePasswordDataBuilder
    implements Builder<ChangePasswordData, ChangePasswordDataBuilder> {
  _$ChangePasswordData? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  ChangePasswordDataRoleEnum? _role;
  ChangePasswordDataRoleEnum? get role => _$this._role;
  set role(ChangePasswordDataRoleEnum? role) => _$this._role = role;

  ChangePasswordDataBuilder() {
    ChangePasswordData._defaults(this);
  }

  ChangePasswordDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangePasswordData other) {
    _$v = other as _$ChangePasswordData;
  }

  @override
  void update(void Function(ChangePasswordDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangePasswordData build() => _build();

  _$ChangePasswordData _build() {
    final _$result =
        _$v ?? _$ChangePasswordData._(id: id, userId: userId, role: role);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
