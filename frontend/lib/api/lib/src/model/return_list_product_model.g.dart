// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_list_product_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReturnListProductModel extends ReturnListProductModel {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? productNameId;

  factory _$ReturnListProductModel([
    void Function(ReturnListProductModelBuilder)? updates,
  ]) => (ReturnListProductModelBuilder()..update(updates))._build();

  _$ReturnListProductModel._({this.id, this.name, this.productNameId})
    : super._();
  @override
  ReturnListProductModel rebuild(
    void Function(ReturnListProductModelBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReturnListProductModelBuilder toBuilder() =>
      ReturnListProductModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReturnListProductModel &&
        id == other.id &&
        name == other.name &&
        productNameId == other.productNameId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReturnListProductModel')
          ..add('id', id)
          ..add('name', name)
          ..add('productNameId', productNameId))
        .toString();
  }
}

class ReturnListProductModelBuilder
    implements Builder<ReturnListProductModel, ReturnListProductModelBuilder> {
  _$ReturnListProductModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _productNameId;
  String? get productNameId => _$this._productNameId;
  set productNameId(String? productNameId) =>
      _$this._productNameId = productNameId;

  ReturnListProductModelBuilder() {
    ReturnListProductModel._defaults(this);
  }

  ReturnListProductModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _productNameId = $v.productNameId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReturnListProductModel other) {
    _$v = other as _$ReturnListProductModel;
  }

  @override
  void update(void Function(ReturnListProductModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReturnListProductModel build() => _build();

  _$ReturnListProductModel _build() {
    final _$result =
        _$v ??
        _$ReturnListProductModel._(
          id: id,
          name: name,
          productNameId: productNameId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
