// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_list_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InventoryListItem extends InventoryListItem {
  @override
  final int? productId;
  @override
  final int? productNameId;
  @override
  final int? productModelId;
  @override
  final String? brand;
  @override
  final String? model;
  @override
  final int? quantity;
  @override
  final num? minPrice;
  @override
  final num? offerPrice;
  @override
  final int? minUnitCountSeller;
  @override
  final int? minUnitCountAdmin;
  @override
  final bool? onSale;
  @override
  final bool? isLowStock;

  factory _$InventoryListItem([
    void Function(InventoryListItemBuilder)? updates,
  ]) => (InventoryListItemBuilder()..update(updates))._build();

  _$InventoryListItem._({
    this.productId,
    this.productNameId,
    this.productModelId,
    this.brand,
    this.model,
    this.quantity,
    this.minPrice,
    this.offerPrice,
    this.minUnitCountSeller,
    this.minUnitCountAdmin,
    this.onSale,
    this.isLowStock,
  }) : super._();
  @override
  InventoryListItem rebuild(void Function(InventoryListItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InventoryListItemBuilder toBuilder() =>
      InventoryListItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InventoryListItem &&
        productId == other.productId &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        brand == other.brand &&
        model == other.model &&
        quantity == other.quantity &&
        minPrice == other.minPrice &&
        offerPrice == other.offerPrice &&
        minUnitCountSeller == other.minUnitCountSeller &&
        minUnitCountAdmin == other.minUnitCountAdmin &&
        onSale == other.onSale &&
        isLowStock == other.isLowStock;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, minPrice.hashCode);
    _$hash = $jc(_$hash, offerPrice.hashCode);
    _$hash = $jc(_$hash, minUnitCountSeller.hashCode);
    _$hash = $jc(_$hash, minUnitCountAdmin.hashCode);
    _$hash = $jc(_$hash, onSale.hashCode);
    _$hash = $jc(_$hash, isLowStock.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InventoryListItem')
          ..add('productId', productId)
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('brand', brand)
          ..add('model', model)
          ..add('quantity', quantity)
          ..add('minPrice', minPrice)
          ..add('offerPrice', offerPrice)
          ..add('minUnitCountSeller', minUnitCountSeller)
          ..add('minUnitCountAdmin', minUnitCountAdmin)
          ..add('onSale', onSale)
          ..add('isLowStock', isLowStock))
        .toString();
  }
}

class InventoryListItemBuilder
    implements Builder<InventoryListItem, InventoryListItemBuilder> {
  _$InventoryListItem? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

  String? _brand;
  String? get brand => _$this._brand;
  set brand(String? brand) => _$this._brand = brand;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  num? _minPrice;
  num? get minPrice => _$this._minPrice;
  set minPrice(num? minPrice) => _$this._minPrice = minPrice;

  num? _offerPrice;
  num? get offerPrice => _$this._offerPrice;
  set offerPrice(num? offerPrice) => _$this._offerPrice = offerPrice;

  int? _minUnitCountSeller;
  int? get minUnitCountSeller => _$this._minUnitCountSeller;
  set minUnitCountSeller(int? minUnitCountSeller) =>
      _$this._minUnitCountSeller = minUnitCountSeller;

  int? _minUnitCountAdmin;
  int? get minUnitCountAdmin => _$this._minUnitCountAdmin;
  set minUnitCountAdmin(int? minUnitCountAdmin) =>
      _$this._minUnitCountAdmin = minUnitCountAdmin;

  bool? _onSale;
  bool? get onSale => _$this._onSale;
  set onSale(bool? onSale) => _$this._onSale = onSale;

  bool? _isLowStock;
  bool? get isLowStock => _$this._isLowStock;
  set isLowStock(bool? isLowStock) => _$this._isLowStock = isLowStock;

  InventoryListItemBuilder() {
    InventoryListItem._defaults(this);
  }

  InventoryListItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _brand = $v.brand;
      _model = $v.model;
      _quantity = $v.quantity;
      _minPrice = $v.minPrice;
      _offerPrice = $v.offerPrice;
      _minUnitCountSeller = $v.minUnitCountSeller;
      _minUnitCountAdmin = $v.minUnitCountAdmin;
      _onSale = $v.onSale;
      _isLowStock = $v.isLowStock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InventoryListItem other) {
    _$v = other as _$InventoryListItem;
  }

  @override
  void update(void Function(InventoryListItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InventoryListItem build() => _build();

  _$InventoryListItem _build() {
    final _$result =
        _$v ??
        _$InventoryListItem._(
          productId: productId,
          productNameId: productNameId,
          productModelId: productModelId,
          brand: brand,
          model: model,
          quantity: quantity,
          minPrice: minPrice,
          offerPrice: offerPrice,
          minUnitCountSeller: minUnitCountSeller,
          minUnitCountAdmin: minUnitCountAdmin,
          onSale: onSale,
          isLowStock: isLowStock,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
