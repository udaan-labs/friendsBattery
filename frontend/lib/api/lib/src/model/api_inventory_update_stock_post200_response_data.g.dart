// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_update_stock_post200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryUpdateStockPost200ResponseData
    extends ApiInventoryUpdateStockPost200ResponseData {
  @override
  final int? productCategoryId;
  @override
  final int? productNameId;
  @override
  final int? productModelId;
  @override
  final int? quantity;
  @override
  final num? minSellPrice;

  factory _$ApiInventoryUpdateStockPost200ResponseData([
    void Function(ApiInventoryUpdateStockPost200ResponseDataBuilder)? updates,
  ]) => (ApiInventoryUpdateStockPost200ResponseDataBuilder()..update(updates))
      ._build();

  _$ApiInventoryUpdateStockPost200ResponseData._({
    this.productCategoryId,
    this.productNameId,
    this.productModelId,
    this.quantity,
    this.minSellPrice,
  }) : super._();
  @override
  ApiInventoryUpdateStockPost200ResponseData rebuild(
    void Function(ApiInventoryUpdateStockPost200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryUpdateStockPost200ResponseDataBuilder toBuilder() =>
      ApiInventoryUpdateStockPost200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryUpdateStockPost200ResponseData &&
        productCategoryId == other.productCategoryId &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        quantity == other.quantity &&
        minSellPrice == other.minSellPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productCategoryId.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, minSellPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiInventoryUpdateStockPost200ResponseData',
          )
          ..add('productCategoryId', productCategoryId)
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('quantity', quantity)
          ..add('minSellPrice', minSellPrice))
        .toString();
  }
}

class ApiInventoryUpdateStockPost200ResponseDataBuilder
    implements
        Builder<
          ApiInventoryUpdateStockPost200ResponseData,
          ApiInventoryUpdateStockPost200ResponseDataBuilder
        > {
  _$ApiInventoryUpdateStockPost200ResponseData? _$v;

  int? _productCategoryId;
  int? get productCategoryId => _$this._productCategoryId;
  set productCategoryId(int? productCategoryId) =>
      _$this._productCategoryId = productCategoryId;

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

  ApiInventoryUpdateStockPost200ResponseDataBuilder() {
    ApiInventoryUpdateStockPost200ResponseData._defaults(this);
  }

  ApiInventoryUpdateStockPost200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productCategoryId = $v.productCategoryId;
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _quantity = $v.quantity;
      _minSellPrice = $v.minSellPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiInventoryUpdateStockPost200ResponseData other) {
    _$v = other as _$ApiInventoryUpdateStockPost200ResponseData;
  }

  @override
  void update(
    void Function(ApiInventoryUpdateStockPost200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryUpdateStockPost200ResponseData build() => _build();

  _$ApiInventoryUpdateStockPost200ResponseData _build() {
    final _$result =
        _$v ??
        _$ApiInventoryUpdateStockPost200ResponseData._(
          productCategoryId: productCategoryId,
          productNameId: productNameId,
          productModelId: productModelId,
          quantity: quantity,
          minSellPrice: minSellPrice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
