// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_products_product_names_list_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiProductsProductNamesListPostRequest
    extends ApiProductsProductNamesListPostRequest {
  @override
  final int? categoryId;

  factory _$ApiProductsProductNamesListPostRequest([
    void Function(ApiProductsProductNamesListPostRequestBuilder)? updates,
  ]) => (ApiProductsProductNamesListPostRequestBuilder()..update(updates))
      ._build();

  _$ApiProductsProductNamesListPostRequest._({this.categoryId}) : super._();
  @override
  ApiProductsProductNamesListPostRequest rebuild(
    void Function(ApiProductsProductNamesListPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiProductsProductNamesListPostRequestBuilder toBuilder() =>
      ApiProductsProductNamesListPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiProductsProductNamesListPostRequest &&
        categoryId == other.categoryId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ApiProductsProductNamesListPostRequest',
    )..add('categoryId', categoryId)).toString();
  }
}

class ApiProductsProductNamesListPostRequestBuilder
    implements
        Builder<
          ApiProductsProductNamesListPostRequest,
          ApiProductsProductNamesListPostRequestBuilder
        > {
  _$ApiProductsProductNamesListPostRequest? _$v;

  int? _categoryId;
  int? get categoryId => _$this._categoryId;
  set categoryId(int? categoryId) => _$this._categoryId = categoryId;

  ApiProductsProductNamesListPostRequestBuilder() {
    ApiProductsProductNamesListPostRequest._defaults(this);
  }

  ApiProductsProductNamesListPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categoryId = $v.categoryId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiProductsProductNamesListPostRequest other) {
    _$v = other as _$ApiProductsProductNamesListPostRequest;
  }

  @override
  void update(
    void Function(ApiProductsProductNamesListPostRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiProductsProductNamesListPostRequest build() => _build();

  _$ApiProductsProductNamesListPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiProductsProductNamesListPostRequest._(categoryId: categoryId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
