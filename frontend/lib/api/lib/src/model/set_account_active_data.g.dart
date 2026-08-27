// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_account_active_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SetAccountActiveDataRoleEnum _$setAccountActiveDataRoleEnum_ADMIN =
    const SetAccountActiveDataRoleEnum._('ADMIN');
const SetAccountActiveDataRoleEnum _$setAccountActiveDataRoleEnum_SELLER =
    const SetAccountActiveDataRoleEnum._('SELLER');
const SetAccountActiveDataRoleEnum _$setAccountActiveDataRoleEnum_EMPLOYEE =
    const SetAccountActiveDataRoleEnum._('EMPLOYEE');

SetAccountActiveDataRoleEnum _$setAccountActiveDataRoleEnumValueOf(
  String name,
) {
  switch (name) {
    case 'ADMIN':
      return _$setAccountActiveDataRoleEnum_ADMIN;
    case 'SELLER':
      return _$setAccountActiveDataRoleEnum_SELLER;
    case 'EMPLOYEE':
      return _$setAccountActiveDataRoleEnum_EMPLOYEE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SetAccountActiveDataRoleEnum>
_$setAccountActiveDataRoleEnumValues =
    BuiltSet<SetAccountActiveDataRoleEnum>(const <SetAccountActiveDataRoleEnum>[
      _$setAccountActiveDataRoleEnum_ADMIN,
      _$setAccountActiveDataRoleEnum_SELLER,
      _$setAccountActiveDataRoleEnum_EMPLOYEE,
    ]);

Serializer<SetAccountActiveDataRoleEnum>
_$setAccountActiveDataRoleEnumSerializer =
    _$SetAccountActiveDataRoleEnumSerializer();

class _$SetAccountActiveDataRoleEnumSerializer
    implements PrimitiveSerializer<SetAccountActiveDataRoleEnum> {
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
  final Iterable<Type> types = const <Type>[SetAccountActiveDataRoleEnum];
  @override
  final String wireName = 'SetAccountActiveDataRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    SetAccountActiveDataRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SetAccountActiveDataRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SetAccountActiveDataRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SetAccountActiveData extends SetAccountActiveData {
  @override
  final int? id;
  @override
  final String? userId;
  @override
  final SetAccountActiveDataRoleEnum? role;
  @override
  final bool? isActive;

  factory _$SetAccountActiveData([
    void Function(SetAccountActiveDataBuilder)? updates,
  ]) => (SetAccountActiveDataBuilder()..update(updates))._build();

  _$SetAccountActiveData._({this.id, this.userId, this.role, this.isActive})
    : super._();
  @override
  SetAccountActiveData rebuild(
    void Function(SetAccountActiveDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SetAccountActiveDataBuilder toBuilder() =>
      SetAccountActiveDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetAccountActiveData &&
        id == other.id &&
        userId == other.userId &&
        role == other.role &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetAccountActiveData')
          ..add('id', id)
          ..add('userId', userId)
          ..add('role', role)
          ..add('isActive', isActive))
        .toString();
  }
}

class SetAccountActiveDataBuilder
    implements Builder<SetAccountActiveData, SetAccountActiveDataBuilder> {
  _$SetAccountActiveData? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  SetAccountActiveDataRoleEnum? _role;
  SetAccountActiveDataRoleEnum? get role => _$this._role;
  set role(SetAccountActiveDataRoleEnum? role) => _$this._role = role;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  SetAccountActiveDataBuilder() {
    SetAccountActiveData._defaults(this);
  }

  SetAccountActiveDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _role = $v.role;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetAccountActiveData other) {
    _$v = other as _$SetAccountActiveData;
  }

  @override
  void update(void Function(SetAccountActiveDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetAccountActiveData build() => _build();

  _$SetAccountActiveData _build() {
    final _$result =
        _$v ??
        _$SetAccountActiveData._(
          id: id,
          userId: userId,
          role: role,
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
