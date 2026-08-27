// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_list_product_name.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReturnListProductName extends ReturnListProductName {
  @override
  final String? id;
  @override
  final String? name;

  factory _$ReturnListProductName([
    void Function(ReturnListProductNameBuilder)? updates,
  ]) => (ReturnListProductNameBuilder()..update(updates))._build();

  _$ReturnListProductName._({this.id, this.name}) : super._();
  @override
  ReturnListProductName rebuild(
    void Function(ReturnListProductNameBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReturnListProductNameBuilder toBuilder() =>
      ReturnListProductNameBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReturnListProductName &&
        id == other.id &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReturnListProductName')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class ReturnListProductNameBuilder
    implements Builder<ReturnListProductName, ReturnListProductNameBuilder> {
  _$ReturnListProductName? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ReturnListProductNameBuilder() {
    ReturnListProductName._defaults(this);
  }

  ReturnListProductNameBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReturnListProductName other) {
    _$v = other as _$ReturnListProductName;
  }

  @override
  void update(void Function(ReturnListProductNameBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReturnListProductName build() => _build();

  _$ReturnListProductName _build() {
    final _$result = _$v ?? _$ReturnListProductName._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
