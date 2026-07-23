// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_product.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SaleProduct extends SaleProduct {
  @override
  final int? id;
  @override
  final String? productName;
  @override
  final String? productModel;

  factory _$SaleProduct([void Function(SaleProductBuilder)? updates]) =>
      (SaleProductBuilder()..update(updates))._build();

  _$SaleProduct._({this.id, this.productName, this.productModel}) : super._();
  @override
  SaleProduct rebuild(void Function(SaleProductBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SaleProductBuilder toBuilder() => SaleProductBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SaleProduct &&
        id == other.id &&
        productName == other.productName &&
        productModel == other.productModel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SaleProduct')
          ..add('id', id)
          ..add('productName', productName)
          ..add('productModel', productModel))
        .toString();
  }
}

class SaleProductBuilder implements Builder<SaleProduct, SaleProductBuilder> {
  _$SaleProduct? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  String? _productModel;
  String? get productModel => _$this._productModel;
  set productModel(String? productModel) => _$this._productModel = productModel;

  SaleProductBuilder() {
    SaleProduct._defaults(this);
  }

  SaleProductBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productName = $v.productName;
      _productModel = $v.productModel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SaleProduct other) {
    _$v = other as _$SaleProduct;
  }

  @override
  void update(void Function(SaleProductBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SaleProduct build() => _build();

  _$SaleProduct _build() {
    final _$result =
        _$v ??
        _$SaleProduct._(
          id: id,
          productName: productName,
          productModel: productModel,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
