// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_config_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductConfigItem extends ProductConfigItem {
  @override
  final int? id;
  @override
  final String? productName;
  @override
  final String? productModel;
  @override
  final num? minPrice;
  @override
  final bool? onSale;
  @override
  final num? offerPrice;
  @override
  final int? minUnitCountAdmin;
  @override
  final int? minUnitCountSeller;

  factory _$ProductConfigItem([
    void Function(ProductConfigItemBuilder)? updates,
  ]) => (ProductConfigItemBuilder()..update(updates))._build();

  _$ProductConfigItem._({
    this.id,
    this.productName,
    this.productModel,
    this.minPrice,
    this.onSale,
    this.offerPrice,
    this.minUnitCountAdmin,
    this.minUnitCountSeller,
  }) : super._();
  @override
  ProductConfigItem rebuild(void Function(ProductConfigItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductConfigItemBuilder toBuilder() =>
      ProductConfigItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductConfigItem &&
        id == other.id &&
        productName == other.productName &&
        productModel == other.productModel &&
        minPrice == other.minPrice &&
        onSale == other.onSale &&
        offerPrice == other.offerPrice &&
        minUnitCountAdmin == other.minUnitCountAdmin &&
        minUnitCountSeller == other.minUnitCountSeller;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jc(_$hash, minPrice.hashCode);
    _$hash = $jc(_$hash, onSale.hashCode);
    _$hash = $jc(_$hash, offerPrice.hashCode);
    _$hash = $jc(_$hash, minUnitCountAdmin.hashCode);
    _$hash = $jc(_$hash, minUnitCountSeller.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductConfigItem')
          ..add('id', id)
          ..add('productName', productName)
          ..add('productModel', productModel)
          ..add('minPrice', minPrice)
          ..add('onSale', onSale)
          ..add('offerPrice', offerPrice)
          ..add('minUnitCountAdmin', minUnitCountAdmin)
          ..add('minUnitCountSeller', minUnitCountSeller))
        .toString();
  }
}

class ProductConfigItemBuilder
    implements Builder<ProductConfigItem, ProductConfigItemBuilder> {
  _$ProductConfigItem? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  String? _productModel;
  String? get productModel => _$this._productModel;
  set productModel(String? productModel) => _$this._productModel = productModel;

  num? _minPrice;
  num? get minPrice => _$this._minPrice;
  set minPrice(num? minPrice) => _$this._minPrice = minPrice;

  bool? _onSale;
  bool? get onSale => _$this._onSale;
  set onSale(bool? onSale) => _$this._onSale = onSale;

  num? _offerPrice;
  num? get offerPrice => _$this._offerPrice;
  set offerPrice(num? offerPrice) => _$this._offerPrice = offerPrice;

  int? _minUnitCountAdmin;
  int? get minUnitCountAdmin => _$this._minUnitCountAdmin;
  set minUnitCountAdmin(int? minUnitCountAdmin) =>
      _$this._minUnitCountAdmin = minUnitCountAdmin;

  int? _minUnitCountSeller;
  int? get minUnitCountSeller => _$this._minUnitCountSeller;
  set minUnitCountSeller(int? minUnitCountSeller) =>
      _$this._minUnitCountSeller = minUnitCountSeller;

  ProductConfigItemBuilder() {
    ProductConfigItem._defaults(this);
  }

  ProductConfigItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productName = $v.productName;
      _productModel = $v.productModel;
      _minPrice = $v.minPrice;
      _onSale = $v.onSale;
      _offerPrice = $v.offerPrice;
      _minUnitCountAdmin = $v.minUnitCountAdmin;
      _minUnitCountSeller = $v.minUnitCountSeller;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductConfigItem other) {
    _$v = other as _$ProductConfigItem;
  }

  @override
  void update(void Function(ProductConfigItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductConfigItem build() => _build();

  _$ProductConfigItem _build() {
    final _$result =
        _$v ??
        _$ProductConfigItem._(
          id: id,
          productName: productName,
          productModel: productModel,
          minPrice: minPrice,
          onSale: onSale,
          offerPrice: offerPrice,
          minUnitCountAdmin: minUnitCountAdmin,
          minUnitCountSeller: minUnitCountSeller,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
