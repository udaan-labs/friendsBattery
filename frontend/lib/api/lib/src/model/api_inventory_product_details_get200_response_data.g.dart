// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_product_details_get200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryProductDetailsGet200ResponseData
    extends ApiInventoryProductDetailsGet200ResponseData {
  @override
  final int? currentStock;
  @override
  final num? minSellPrice;

  factory _$ApiInventoryProductDetailsGet200ResponseData([
    void Function(ApiInventoryProductDetailsGet200ResponseDataBuilder)? updates,
  ]) => (ApiInventoryProductDetailsGet200ResponseDataBuilder()..update(updates))
      ._build();

  _$ApiInventoryProductDetailsGet200ResponseData._({
    this.currentStock,
    this.minSellPrice,
  }) : super._();
  @override
  ApiInventoryProductDetailsGet200ResponseData rebuild(
    void Function(ApiInventoryProductDetailsGet200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryProductDetailsGet200ResponseDataBuilder toBuilder() =>
      ApiInventoryProductDetailsGet200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryProductDetailsGet200ResponseData &&
        currentStock == other.currentStock &&
        minSellPrice == other.minSellPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentStock.hashCode);
    _$hash = $jc(_$hash, minSellPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiInventoryProductDetailsGet200ResponseData',
          )
          ..add('currentStock', currentStock)
          ..add('minSellPrice', minSellPrice))
        .toString();
  }
}

class ApiInventoryProductDetailsGet200ResponseDataBuilder
    implements
        Builder<
          ApiInventoryProductDetailsGet200ResponseData,
          ApiInventoryProductDetailsGet200ResponseDataBuilder
        > {
  _$ApiInventoryProductDetailsGet200ResponseData? _$v;

  int? _currentStock;
  int? get currentStock => _$this._currentStock;
  set currentStock(int? currentStock) => _$this._currentStock = currentStock;

  num? _minSellPrice;
  num? get minSellPrice => _$this._minSellPrice;
  set minSellPrice(num? minSellPrice) => _$this._minSellPrice = minSellPrice;

  ApiInventoryProductDetailsGet200ResponseDataBuilder() {
    ApiInventoryProductDetailsGet200ResponseData._defaults(this);
  }

  ApiInventoryProductDetailsGet200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentStock = $v.currentStock;
      _minSellPrice = $v.minSellPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiInventoryProductDetailsGet200ResponseData other) {
    _$v = other as _$ApiInventoryProductDetailsGet200ResponseData;
  }

  @override
  void update(
    void Function(ApiInventoryProductDetailsGet200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryProductDetailsGet200ResponseData build() => _build();

  _$ApiInventoryProductDetailsGet200ResponseData _build() {
    final _$result =
        _$v ??
        _$ApiInventoryProductDetailsGet200ResponseData._(
          currentStock: currentStock,
          minSellPrice: minSellPrice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
