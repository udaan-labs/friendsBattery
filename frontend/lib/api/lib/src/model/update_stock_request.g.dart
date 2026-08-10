// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_stock_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateStockRequest extends UpdateStockRequest {
  @override
  final int productNameId;
  @override
  final int productModelId;
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

  factory _$UpdateStockRequest([
    void Function(UpdateStockRequestBuilder)? updates,
  ]) => (UpdateStockRequestBuilder()..update(updates))._build();

  _$UpdateStockRequest._({
    required this.productNameId,
    required this.productModelId,
    this.quantity,
    this.minSellPrice,
    this.minUnitCountAdmin,
    this.minUnitCountSeller,
    this.onSale,
    this.locationId,
  }) : super._();
  @override
  UpdateStockRequest rebuild(
    void Function(UpdateStockRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateStockRequestBuilder toBuilder() =>
      UpdateStockRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateStockRequest &&
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
    return (newBuiltValueToStringHelper(r'UpdateStockRequest')
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

class UpdateStockRequestBuilder
    implements Builder<UpdateStockRequest, UpdateStockRequestBuilder> {
  _$UpdateStockRequest? _$v;

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

  UpdateStockRequestBuilder() {
    UpdateStockRequest._defaults(this);
  }

  UpdateStockRequestBuilder get _$this {
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
  void replace(UpdateStockRequest other) {
    _$v = other as _$UpdateStockRequest;
  }

  @override
  void update(void Function(UpdateStockRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateStockRequest build() => _build();

  _$UpdateStockRequest _build() {
    final _$result =
        _$v ??
        _$UpdateStockRequest._(
          productNameId: BuiltValueNullFieldError.checkNotNull(
            productNameId,
            r'UpdateStockRequest',
            'productNameId',
          ),
          productModelId: BuiltValueNullFieldError.checkNotNull(
            productModelId,
            r'UpdateStockRequest',
            'productModelId',
          ),
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
