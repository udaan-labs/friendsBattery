// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_details_get200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryDetailsGet200ResponseData
    extends ApiInventoryDetailsGet200ResponseData {
  @override
  final BuiltList<ApiInventoryDetailsGet200ResponseDataCategoriesInner>?
  categories;
  @override
  final ApiInventoryDetailsGet200ResponseDataPagination? pagination;

  factory _$ApiInventoryDetailsGet200ResponseData([
    void Function(ApiInventoryDetailsGet200ResponseDataBuilder)? updates,
  ]) => (ApiInventoryDetailsGet200ResponseDataBuilder()..update(updates))
      ._build();

  _$ApiInventoryDetailsGet200ResponseData._({this.categories, this.pagination})
    : super._();
  @override
  ApiInventoryDetailsGet200ResponseData rebuild(
    void Function(ApiInventoryDetailsGet200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryDetailsGet200ResponseDataBuilder toBuilder() =>
      ApiInventoryDetailsGet200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryDetailsGet200ResponseData &&
        categories == other.categories &&
        pagination == other.pagination;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, pagination.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiInventoryDetailsGet200ResponseData',
          )
          ..add('categories', categories)
          ..add('pagination', pagination))
        .toString();
  }
}

class ApiInventoryDetailsGet200ResponseDataBuilder
    implements
        Builder<
          ApiInventoryDetailsGet200ResponseData,
          ApiInventoryDetailsGet200ResponseDataBuilder
        > {
  _$ApiInventoryDetailsGet200ResponseData? _$v;

  ListBuilder<ApiInventoryDetailsGet200ResponseDataCategoriesInner>?
  _categories;
  ListBuilder<ApiInventoryDetailsGet200ResponseDataCategoriesInner>
  get categories => _$this._categories ??=
      ListBuilder<ApiInventoryDetailsGet200ResponseDataCategoriesInner>();
  set categories(
    ListBuilder<ApiInventoryDetailsGet200ResponseDataCategoriesInner>?
    categories,
  ) => _$this._categories = categories;

  ApiInventoryDetailsGet200ResponseDataPaginationBuilder? _pagination;
  ApiInventoryDetailsGet200ResponseDataPaginationBuilder get pagination =>
      _$this._pagination ??=
          ApiInventoryDetailsGet200ResponseDataPaginationBuilder();
  set pagination(
    ApiInventoryDetailsGet200ResponseDataPaginationBuilder? pagination,
  ) => _$this._pagination = pagination;

  ApiInventoryDetailsGet200ResponseDataBuilder() {
    ApiInventoryDetailsGet200ResponseData._defaults(this);
  }

  ApiInventoryDetailsGet200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categories = $v.categories?.toBuilder();
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiInventoryDetailsGet200ResponseData other) {
    _$v = other as _$ApiInventoryDetailsGet200ResponseData;
  }

  @override
  void update(
    void Function(ApiInventoryDetailsGet200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryDetailsGet200ResponseData build() => _build();

  _$ApiInventoryDetailsGet200ResponseData _build() {
    _$ApiInventoryDetailsGet200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ApiInventoryDetailsGet200ResponseData._(
            categories: _categories?.build(),
            pagination: _pagination?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'categories';
        _categories?.build();
        _$failedField = 'pagination';
        _pagination?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApiInventoryDetailsGet200ResponseData',
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
