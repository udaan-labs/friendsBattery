// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_details_get200_response_data_categories_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryDetailsGet200ResponseDataCategoriesInner
    extends ApiInventoryDetailsGet200ResponseDataCategoriesInner {
  @override
  final String? categoryId;
  @override
  final String? categoryName;
  @override
  final BuiltList<
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
  >?
  subcategories;

  factory _$ApiInventoryDetailsGet200ResponseDataCategoriesInner([
    void Function(ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder)?
    updates,
  ]) =>
      (ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder()
            ..update(updates))
          ._build();

  _$ApiInventoryDetailsGet200ResponseDataCategoriesInner._({
    this.categoryId,
    this.categoryName,
    this.subcategories,
  }) : super._();
  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInner rebuild(
    void Function(ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder toBuilder() =>
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryDetailsGet200ResponseDataCategoriesInner &&
        categoryId == other.categoryId &&
        categoryName == other.categoryName &&
        subcategories == other.subcategories;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, categoryName.hashCode);
    _$hash = $jc(_$hash, subcategories.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiInventoryDetailsGet200ResponseDataCategoriesInner',
          )
          ..add('categoryId', categoryId)
          ..add('categoryName', categoryName)
          ..add('subcategories', subcategories))
        .toString();
  }
}

class ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder
    implements
        Builder<
          ApiInventoryDetailsGet200ResponseDataCategoriesInner,
          ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder
        > {
  _$ApiInventoryDetailsGet200ResponseDataCategoriesInner? _$v;

  String? _categoryId;
  String? get categoryId => _$this._categoryId;
  set categoryId(String? categoryId) => _$this._categoryId = categoryId;

  String? _categoryName;
  String? get categoryName => _$this._categoryName;
  set categoryName(String? categoryName) => _$this._categoryName = categoryName;

  ListBuilder<
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
  >?
  _subcategories;
  ListBuilder<
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
  >
  get subcategories => _$this._subcategories ??=
      ListBuilder<
        ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
      >();
  set subcategories(
    ListBuilder<
      ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
    >?
    subcategories,
  ) => _$this._subcategories = subcategories;

  ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder() {
    ApiInventoryDetailsGet200ResponseDataCategoriesInner._defaults(this);
  }

  ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categoryId = $v.categoryId;
      _categoryName = $v.categoryName;
      _subcategories = $v.subcategories?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiInventoryDetailsGet200ResponseDataCategoriesInner other) {
    _$v = other as _$ApiInventoryDetailsGet200ResponseDataCategoriesInner;
  }

  @override
  void update(
    void Function(ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInner build() => _build();

  _$ApiInventoryDetailsGet200ResponseDataCategoriesInner _build() {
    _$ApiInventoryDetailsGet200ResponseDataCategoriesInner _$result;
    try {
      _$result =
          _$v ??
          _$ApiInventoryDetailsGet200ResponseDataCategoriesInner._(
            categoryId: categoryId,
            categoryName: categoryName,
            subcategories: _subcategories?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'subcategories';
        _subcategories?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApiInventoryDetailsGet200ResponseDataCategoriesInner',
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
