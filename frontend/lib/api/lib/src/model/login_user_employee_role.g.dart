// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_employee_role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginUserEmployeeRole extends LoginUserEmployeeRole {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;

  factory _$LoginUserEmployeeRole([
    void Function(LoginUserEmployeeRoleBuilder)? updates,
  ]) => (LoginUserEmployeeRoleBuilder()..update(updates))._build();

  _$LoginUserEmployeeRole._({this.id, this.name, this.description}) : super._();
  @override
  LoginUserEmployeeRole rebuild(
    void Function(LoginUserEmployeeRoleBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LoginUserEmployeeRoleBuilder toBuilder() =>
      LoginUserEmployeeRoleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginUserEmployeeRole &&
        id == other.id &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginUserEmployeeRole')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class LoginUserEmployeeRoleBuilder
    implements Builder<LoginUserEmployeeRole, LoginUserEmployeeRoleBuilder> {
  _$LoginUserEmployeeRole? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  LoginUserEmployeeRoleBuilder() {
    LoginUserEmployeeRole._defaults(this);
  }

  LoginUserEmployeeRoleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginUserEmployeeRole other) {
    _$v = other as _$LoginUserEmployeeRole;
  }

  @override
  void update(void Function(LoginUserEmployeeRoleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginUserEmployeeRole build() => _build();

  _$LoginUserEmployeeRole _build() {
    final _$result =
        _$v ??
        _$LoginUserEmployeeRole._(id: id, name: name, description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
