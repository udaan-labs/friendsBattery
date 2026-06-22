// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shops_get200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ShopsGet200ResponseInner extends ShopsGet200ResponseInner {
  @override
  final String? id;
  @override
  final String? name;

  factory _$ShopsGet200ResponseInner([
    void Function(ShopsGet200ResponseInnerBuilder)? updates,
  ]) => (ShopsGet200ResponseInnerBuilder()..update(updates))._build();

  _$ShopsGet200ResponseInner._({this.id, this.name}) : super._();
  @override
  ShopsGet200ResponseInner rebuild(
    void Function(ShopsGet200ResponseInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ShopsGet200ResponseInnerBuilder toBuilder() =>
      ShopsGet200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShopsGet200ResponseInner &&
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
    return (newBuiltValueToStringHelper(r'ShopsGet200ResponseInner')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class ShopsGet200ResponseInnerBuilder
    implements
        Builder<ShopsGet200ResponseInner, ShopsGet200ResponseInnerBuilder> {
  _$ShopsGet200ResponseInner? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ShopsGet200ResponseInnerBuilder() {
    ShopsGet200ResponseInner._defaults(this);
  }

  ShopsGet200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShopsGet200ResponseInner other) {
    _$v = other as _$ShopsGet200ResponseInner;
  }

  @override
  void update(void Function(ShopsGet200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ShopsGet200ResponseInner build() => _build();

  _$ShopsGet200ResponseInner _build() {
    final _$result = _$v ?? _$ShopsGet200ResponseInner._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
