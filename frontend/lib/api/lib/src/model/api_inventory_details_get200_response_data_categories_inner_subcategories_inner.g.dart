// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_details_get200_response_data_categories_inner_subcategories_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
    extends
        ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner {
  @override
  final String? subcategoryName;
  @override
  final BuiltList<
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
  >?
  products;

  factory _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner([
    void Function(
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder,
    )?
    updates,
  ]) =>
      (ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder()
            ..update(updates))
          ._build();

  _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner._({
    this.subcategoryName,
    this.products,
  }) : super._();
  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
  rebuild(
    void Function(
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder
  toBuilder() =>
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner &&
        subcategoryName == other.subcategoryName &&
        products == other.products;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, subcategoryName.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner',
          )
          ..add('subcategoryName', subcategoryName)
          ..add('products', products))
        .toString();
  }
}

class ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder
    implements
        Builder<
          ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner,
          ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder
        > {
  _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner? _$v;

  String? _subcategoryName;
  String? get subcategoryName => _$this._subcategoryName;
  set subcategoryName(String? subcategoryName) =>
      _$this._subcategoryName = subcategoryName;

  ListBuilder<
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
  >?
  _products;
  ListBuilder<
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
  >
  get products => _$this._products ??=
      ListBuilder<
        ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
      >();
  set products(
    ListBuilder<
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
    >?
    products,
  ) => _$this._products = products;

  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder() {
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner._defaults(
      this,
    );
  }

  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _subcategoryName = $v.subcategoryName;
      _products = $v.products?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
    other,
  ) {
    _$v =
        other
            as _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner;
  }

  @override
  void update(
    void Function(
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
  build() => _build();

  _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
  _build() {
    _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
    _$result;
    try {
      _$result =
          _$v ??
          _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
              ._(
                subcategoryName: subcategoryName,
                products: _products?.build(),
              );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'products';
        _products?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
