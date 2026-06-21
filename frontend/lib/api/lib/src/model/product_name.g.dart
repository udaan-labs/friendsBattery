// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_name.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductName extends ProductName {
  @override
  final String? id;
  @override
  final String? name;

  factory _$ProductName([void Function(ProductNameBuilder)? updates]) =>
      (ProductNameBuilder()..update(updates))._build();

  _$ProductName._({this.id, this.name}) : super._();
  @override
  ProductName rebuild(void Function(ProductNameBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductNameBuilder toBuilder() => ProductNameBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductName && id == other.id && name == other.name;
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
    return (newBuiltValueToStringHelper(r'ProductName')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class ProductNameBuilder implements Builder<ProductName, ProductNameBuilder> {
  _$ProductName? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ProductNameBuilder() {
    ProductName._defaults(this);
  }

  ProductNameBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductName other) {
    _$v = other as _$ProductName;
  }

  @override
  void update(void Function(ProductNameBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductName build() => _build();

  _$ProductName _build() {
    final _$result = _$v ??
        _$ProductName._(
          id: id,
          name: name,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
