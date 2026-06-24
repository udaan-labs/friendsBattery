// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_details_get200_response_data_categories_inner_subcategories_inner_products_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
    extends
        ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner {
  @override
  final int? productId;
  @override
  final String? productName;
  @override
  final int? totalQuantity;
  @override
  final int? soldQuantity;
  @override
  final int? remainingQuantity;

  factory _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner([
    void Function(
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder,
    )?
    updates,
  ]) =>
      (ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder()
            ..update(updates))
          ._build();

  _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner._({
    this.productId,
    this.productName,
    this.totalQuantity,
    this.soldQuantity,
    this.remainingQuantity,
  }) : super._();
  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
  rebuild(
    void Function(
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder
  toBuilder() =>
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner &&
        productId == other.productId &&
        productName == other.productName &&
        totalQuantity == other.totalQuantity &&
        soldQuantity == other.soldQuantity &&
        remainingQuantity == other.remainingQuantity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, totalQuantity.hashCode);
    _$hash = $jc(_$hash, soldQuantity.hashCode);
    _$hash = $jc(_$hash, remainingQuantity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner',
          )
          ..add('productId', productId)
          ..add('productName', productName)
          ..add('totalQuantity', totalQuantity)
          ..add('soldQuantity', soldQuantity)
          ..add('remainingQuantity', remainingQuantity))
        .toString();
  }
}

class ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder
    implements
        Builder<
          ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner,
          ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder
        > {
  _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner?
  _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  int? _totalQuantity;
  int? get totalQuantity => _$this._totalQuantity;
  set totalQuantity(int? totalQuantity) =>
      _$this._totalQuantity = totalQuantity;

  int? _soldQuantity;
  int? get soldQuantity => _$this._soldQuantity;
  set soldQuantity(int? soldQuantity) => _$this._soldQuantity = soldQuantity;

  int? _remainingQuantity;
  int? get remainingQuantity => _$this._remainingQuantity;
  set remainingQuantity(int? remainingQuantity) =>
      _$this._remainingQuantity = remainingQuantity;

  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder() {
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner._defaults(
      this,
    );
  }

  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _productName = $v.productName;
      _totalQuantity = $v.totalQuantity;
      _soldQuantity = $v.soldQuantity;
      _remainingQuantity = $v.remainingQuantity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
    other,
  ) {
    _$v =
        other
            as _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner;
  }

  @override
  void update(
    void Function(
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
  build() => _build();

  _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
  _build() {
    final _$result =
        _$v ??
        _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
            ._(
              productId: productId,
              productName: productName,
              totalQuantity: totalQuantity,
              soldQuantity: soldQuantity,
              remainingQuantity: remainingQuantity,
            );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
