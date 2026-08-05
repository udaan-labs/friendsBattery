// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_role_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EmployeeRoleItem extends EmployeeRoleItem {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;

  factory _$EmployeeRoleItem([
    void Function(EmployeeRoleItemBuilder)? updates,
  ]) => (EmployeeRoleItemBuilder()..update(updates))._build();

  _$EmployeeRoleItem._({this.id, this.name, this.description}) : super._();
  @override
  EmployeeRoleItem rebuild(void Function(EmployeeRoleItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmployeeRoleItemBuilder toBuilder() =>
      EmployeeRoleItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmployeeRoleItem &&
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
    return (newBuiltValueToStringHelper(r'EmployeeRoleItem')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class EmployeeRoleItemBuilder
    implements Builder<EmployeeRoleItem, EmployeeRoleItemBuilder> {
  _$EmployeeRoleItem? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  EmployeeRoleItemBuilder() {
    EmployeeRoleItem._defaults(this);
  }

  EmployeeRoleItemBuilder get _$this {
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
  void replace(EmployeeRoleItem other) {
    _$v = other as _$EmployeeRoleItem;
  }

  @override
  void update(void Function(EmployeeRoleItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EmployeeRoleItem build() => _build();

  _$EmployeeRoleItem _build() {
    final _$result =
        _$v ??
        _$EmployeeRoleItem._(id: id, name: name, description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
