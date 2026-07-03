// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_update_stock_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryUpdateStockPostRequest
    extends ApiInventoryUpdateStockPostRequest {
  @override
  final int productNameId;
  @override
  final int productModelId;
  @override
  final int quantity;
  @override
  final num? minSellPrice;
  @override
  final int? minUnitCountAdmin;
  @override
  final int? minUnitCountSeller;

  factory _$ApiInventoryUpdateStockPostRequest([
    void Function(ApiInventoryUpdateStockPostRequestBuilder)? updates,
  ]) => (ApiInventoryUpdateStockPostRequestBuilder()..update(updates))._build();

  _$ApiInventoryUpdateStockPostRequest._({
    required this.productNameId,
    required this.productModelId,
    required this.quantity,
    this.minSellPrice,
    this.minUnitCountAdmin,
    this.minUnitCountSeller,
  }) : super._();
  @override
  ApiInventoryUpdateStockPostRequest rebuild(
    void Function(ApiInventoryUpdateStockPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryUpdateStockPostRequestBuilder toBuilder() =>
      ApiInventoryUpdateStockPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryUpdateStockPostRequest &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        quantity == other.quantity &&
        minSellPrice == other.minSellPrice &&
        minUnitCountAdmin == other.minUnitCountAdmin &&
        minUnitCountSeller == other.minUnitCountSeller;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiInventoryUpdateStockPostRequest')
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('quantity', quantity)
          ..add('minSellPrice', minSellPrice)
          ..add('minUnitCountAdmin', minUnitCountAdmin)
          ..add('minUnitCountSeller', minUnitCountSeller))
        .toString();
  }
}

class ApiInventoryUpdateStockPostRequestBuilder
    implements
        Builder<
          ApiInventoryUpdateStockPostRequest,
          ApiInventoryUpdateStockPostRequestBuilder
        > {
  _$ApiInventoryUpdateStockPostRequest? _$v;

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

  ApiInventoryUpdateStockPostRequestBuilder() {
    ApiInventoryUpdateStockPostRequest._defaults(this);
  }

  ApiInventoryUpdateStockPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _quantity = $v.quantity;
      _minSellPrice = $v.minSellPrice;
      _minUnitCountAdmin = $v.minUnitCountAdmin;
      _minUnitCountSeller = $v.minUnitCountSeller;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiInventoryUpdateStockPostRequest other) {
    _$v = other as _$ApiInventoryUpdateStockPostRequest;
  }

  @override
  void update(
    void Function(ApiInventoryUpdateStockPostRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryUpdateStockPostRequest build() => _build();

  _$ApiInventoryUpdateStockPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiInventoryUpdateStockPostRequest._(
          productNameId: BuiltValueNullFieldError.checkNotNull(
            productNameId,
            r'ApiInventoryUpdateStockPostRequest',
            'productNameId',
          ),
          productModelId: BuiltValueNullFieldError.checkNotNull(
            productModelId,
            r'ApiInventoryUpdateStockPostRequest',
            'productModelId',
          ),
          quantity: BuiltValueNullFieldError.checkNotNull(
            quantity,
            r'ApiInventoryUpdateStockPostRequest',
            'quantity',
          ),
          minSellPrice: minSellPrice,
          minUnitCountAdmin: minUnitCountAdmin,
          minUnitCountSeller: minUnitCountSeller,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
