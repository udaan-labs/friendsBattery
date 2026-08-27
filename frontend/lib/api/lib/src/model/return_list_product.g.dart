// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_list_product.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReturnListProduct extends ReturnListProduct {
  @override
  final String? id;
  @override
  final String? productNameId;
  @override
  final String? productModelId;
  @override
  final ReturnListProductName? productName;
  @override
  final ReturnListProductModel? productModel;

  factory _$ReturnListProduct([
    void Function(ReturnListProductBuilder)? updates,
  ]) => (ReturnListProductBuilder()..update(updates))._build();

  _$ReturnListProduct._({
    this.id,
    this.productNameId,
    this.productModelId,
    this.productName,
    this.productModel,
  }) : super._();
  @override
  ReturnListProduct rebuild(void Function(ReturnListProductBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReturnListProductBuilder toBuilder() =>
      ReturnListProductBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReturnListProduct &&
        id == other.id &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        productName == other.productName &&
        productModel == other.productModel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReturnListProduct')
          ..add('id', id)
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('productName', productName)
          ..add('productModel', productModel))
        .toString();
  }
}

class ReturnListProductBuilder
    implements Builder<ReturnListProduct, ReturnListProductBuilder> {
  _$ReturnListProduct? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _productNameId;
  String? get productNameId => _$this._productNameId;
  set productNameId(String? productNameId) =>
      _$this._productNameId = productNameId;

  String? _productModelId;
  String? get productModelId => _$this._productModelId;
  set productModelId(String? productModelId) =>
      _$this._productModelId = productModelId;

  ReturnListProductNameBuilder? _productName;
  ReturnListProductNameBuilder get productName =>
      _$this._productName ??= ReturnListProductNameBuilder();
  set productName(ReturnListProductNameBuilder? productName) =>
      _$this._productName = productName;

  ReturnListProductModelBuilder? _productModel;
  ReturnListProductModelBuilder get productModel =>
      _$this._productModel ??= ReturnListProductModelBuilder();
  set productModel(ReturnListProductModelBuilder? productModel) =>
      _$this._productModel = productModel;

  ReturnListProductBuilder() {
    ReturnListProduct._defaults(this);
  }

  ReturnListProductBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _productName = $v.productName?.toBuilder();
      _productModel = $v.productModel?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReturnListProduct other) {
    _$v = other as _$ReturnListProduct;
  }

  @override
  void update(void Function(ReturnListProductBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReturnListProduct build() => _build();

  _$ReturnListProduct _build() {
    _$ReturnListProduct _$result;
    try {
      _$result =
          _$v ??
          _$ReturnListProduct._(
            id: id,
            productNameId: productNameId,
            productModelId: productModelId,
            productName: _productName?.build(),
            productModel: _productModel?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'productName';
        _productName?.build();
        _$failedField = 'productModel';
        _productModel?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ReturnListProduct',
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
