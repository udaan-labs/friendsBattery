// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_created.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductCreated extends ProductCreated {
  @override
  final int? id;
  @override
  final int? productNameId;
  @override
  final int? productModelId;
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
  @override
  final DateTime? createdAt;

  factory _$ProductCreated([void Function(ProductCreatedBuilder)? updates]) =>
      (ProductCreatedBuilder()..update(updates))._build();

  _$ProductCreated._({
    this.id,
    this.productNameId,
    this.productModelId,
    this.minPrice,
    this.onSale,
    this.offerPrice,
    this.minUnitCountAdmin,
    this.minUnitCountSeller,
    this.createdAt,
  }) : super._();
  @override
  ProductCreated rebuild(void Function(ProductCreatedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductCreatedBuilder toBuilder() => ProductCreatedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductCreated &&
        id == other.id &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        minPrice == other.minPrice &&
        onSale == other.onSale &&
        offerPrice == other.offerPrice &&
        minUnitCountAdmin == other.minUnitCountAdmin &&
        minUnitCountSeller == other.minUnitCountSeller &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, minPrice.hashCode);
    _$hash = $jc(_$hash, onSale.hashCode);
    _$hash = $jc(_$hash, offerPrice.hashCode);
    _$hash = $jc(_$hash, minUnitCountAdmin.hashCode);
    _$hash = $jc(_$hash, minUnitCountSeller.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductCreated')
          ..add('id', id)
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('minPrice', minPrice)
          ..add('onSale', onSale)
          ..add('offerPrice', offerPrice)
          ..add('minUnitCountAdmin', minUnitCountAdmin)
          ..add('minUnitCountSeller', minUnitCountSeller)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ProductCreatedBuilder
    implements Builder<ProductCreated, ProductCreatedBuilder> {
  _$ProductCreated? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

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

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ProductCreatedBuilder() {
    ProductCreated._defaults(this);
  }

  ProductCreatedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _minPrice = $v.minPrice;
      _onSale = $v.onSale;
      _offerPrice = $v.offerPrice;
      _minUnitCountAdmin = $v.minUnitCountAdmin;
      _minUnitCountSeller = $v.minUnitCountSeller;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductCreated other) {
    _$v = other as _$ProductCreated;
  }

  @override
  void update(void Function(ProductCreatedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductCreated build() => _build();

  _$ProductCreated _build() {
    final _$result =
        _$v ??
        _$ProductCreated._(
          id: id,
          productNameId: productNameId,
          productModelId: productModelId,
          minPrice: minPrice,
          onSale: onSale,
          offerPrice: offerPrice,
          minUnitCountAdmin: minUnitCountAdmin,
          minUnitCountSeller: minUnitCountSeller,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
