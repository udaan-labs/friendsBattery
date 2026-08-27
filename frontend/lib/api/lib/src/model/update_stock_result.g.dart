// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_stock_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateStockResult extends UpdateStockResult {
  @override
  final int? productNameId;
  @override
  final int? productModelId;
  @override
  final int? quantity;
  @override
  final num? minSellPrice;
  @override
  final int? minUnitCountAdmin;
  @override
  final int? minUnitCountSeller;
  @override
  final bool? onSale;
  @override
  final int? locationId;

  factory _$UpdateStockResult([
    void Function(UpdateStockResultBuilder)? updates,
  ]) => (UpdateStockResultBuilder()..update(updates))._build();

  _$UpdateStockResult._({
    this.productNameId,
    this.productModelId,
    this.quantity,
    this.minSellPrice,
    this.minUnitCountAdmin,
    this.minUnitCountSeller,
    this.onSale,
    this.locationId,
  }) : super._();
  @override
  UpdateStockResult rebuild(void Function(UpdateStockResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateStockResultBuilder toBuilder() =>
      UpdateStockResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateStockResult &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        quantity == other.quantity &&
        minSellPrice == other.minSellPrice &&
        minUnitCountAdmin == other.minUnitCountAdmin &&
        minUnitCountSeller == other.minUnitCountSeller &&
        onSale == other.onSale &&
        locationId == other.locationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, minSellPrice.hashCode);
    _$hash = $jc(_$hash, minUnitCountAdmin.hashCode);
    _$hash = $jc(_$hash, minUnitCountSeller.hashCode);
    _$hash = $jc(_$hash, onSale.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateStockResult')
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('quantity', quantity)
          ..add('minSellPrice', minSellPrice)
          ..add('minUnitCountAdmin', minUnitCountAdmin)
          ..add('minUnitCountSeller', minUnitCountSeller)
          ..add('onSale', onSale)
          ..add('locationId', locationId))
        .toString();
  }
}

class UpdateStockResultBuilder
    implements Builder<UpdateStockResult, UpdateStockResultBuilder> {
  _$UpdateStockResult? _$v;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  num? _minSellPrice;
  num? get minSellPrice => _$this._minSellPrice;
  set minSellPrice(num? minSellPrice) => _$this._minSellPrice = minSellPrice;

  int? _minUnitCountAdmin;
  int? get minUnitCountAdmin => _$this._minUnitCountAdmin;
  set minUnitCountAdmin(int? minUnitCountAdmin) =>
      _$this._minUnitCountAdmin = minUnitCountAdmin;

  int? _minUnitCountSeller;
  int? get minUnitCountSeller => _$this._minUnitCountSeller;
  set minUnitCountSeller(int? minUnitCountSeller) =>
      _$this._minUnitCountSeller = minUnitCountSeller;

  bool? _onSale;
  bool? get onSale => _$this._onSale;
  set onSale(bool? onSale) => _$this._onSale = onSale;

  int? _locationId;
  int? get locationId => _$this._locationId;
  set locationId(int? locationId) => _$this._locationId = locationId;

  UpdateStockResultBuilder() {
    UpdateStockResult._defaults(this);
  }

  UpdateStockResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _quantity = $v.quantity;
      _minSellPrice = $v.minSellPrice;
      _minUnitCountAdmin = $v.minUnitCountAdmin;
      _minUnitCountSeller = $v.minUnitCountSeller;
      _onSale = $v.onSale;
      _locationId = $v.locationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateStockResult other) {
    _$v = other as _$UpdateStockResult;
  }

  @override
  void update(void Function(UpdateStockResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateStockResult build() => _build();

  _$UpdateStockResult _build() {
    final _$result =
        _$v ??
        _$UpdateStockResult._(
          productNameId: productNameId,
          productModelId: productModelId,
          quantity: quantity,
          minSellPrice: minSellPrice,
          minUnitCountAdmin: minUnitCountAdmin,
          minUnitCountSeller: minUnitCountSeller,
          onSale: onSale,
          locationId: locationId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
