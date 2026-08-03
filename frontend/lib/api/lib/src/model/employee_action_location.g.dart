// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_action_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EmployeeActionLocation extends EmployeeActionLocation {
  @override
  final int? id;
  @override
  final String? code;
  @override
  final String? name;
  @override
  final String? type;

  factory _$EmployeeActionLocation([
    void Function(EmployeeActionLocationBuilder)? updates,
  ]) => (EmployeeActionLocationBuilder()..update(updates))._build();

  _$EmployeeActionLocation._({this.id, this.code, this.name, this.type})
    : super._();
  @override
  EmployeeActionLocation rebuild(
    void Function(EmployeeActionLocationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EmployeeActionLocationBuilder toBuilder() =>
      EmployeeActionLocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmployeeActionLocation &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EmployeeActionLocation')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('type', type))
        .toString();
  }
}

class EmployeeActionLocationBuilder
    implements Builder<EmployeeActionLocation, EmployeeActionLocationBuilder> {
  _$EmployeeActionLocation? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  EmployeeActionLocationBuilder() {
    EmployeeActionLocation._defaults(this);
  }

  EmployeeActionLocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmployeeActionLocation other) {
    _$v = other as _$EmployeeActionLocation;
  }

  @override
  void update(void Function(EmployeeActionLocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EmployeeActionLocation build() => _build();

  _$EmployeeActionLocation _build() {
    final _$result =
        _$v ??
        _$EmployeeActionLocation._(id: id, code: code, name: name, type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
