// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_products_product_models_list_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiProductsProductModelsListPostRequest
    extends ApiProductsProductModelsListPostRequest {
  @override
  final int? categoryId;
  @override
  final int? productNameId;

  factory _$ApiProductsProductModelsListPostRequest([
    void Function(ApiProductsProductModelsListPostRequestBuilder)? updates,
  ]) => (ApiProductsProductModelsListPostRequestBuilder()..update(updates))
      ._build();

  _$ApiProductsProductModelsListPostRequest._({
    this.categoryId,
    this.productNameId,
  }) : super._();
  @override
  ApiProductsProductModelsListPostRequest rebuild(
    void Function(ApiProductsProductModelsListPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiProductsProductModelsListPostRequestBuilder toBuilder() =>
      ApiProductsProductModelsListPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiProductsProductModelsListPostRequest &&
        categoryId == other.categoryId &&
        productNameId == other.productNameId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiProductsProductModelsListPostRequest',
          )
          ..add('categoryId', categoryId)
          ..add('productNameId', productNameId))
        .toString();
  }
}

class ApiProductsProductModelsListPostRequestBuilder
    implements
        Builder<
          ApiProductsProductModelsListPostRequest,
          ApiProductsProductModelsListPostRequestBuilder
        > {
  _$ApiProductsProductModelsListPostRequest? _$v;

  int? _categoryId;
  int? get categoryId => _$this._categoryId;
  set categoryId(int? categoryId) => _$this._categoryId = categoryId;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  ApiProductsProductModelsListPostRequestBuilder() {
    ApiProductsProductModelsListPostRequest._defaults(this);
  }

  ApiProductsProductModelsListPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categoryId = $v.categoryId;
      _productNameId = $v.productNameId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiProductsProductModelsListPostRequest other) {
    _$v = other as _$ApiProductsProductModelsListPostRequest;
  }

  @override
  void update(
    void Function(ApiProductsProductModelsListPostRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiProductsProductModelsListPostRequest build() => _build();

  _$ApiProductsProductModelsListPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiProductsProductModelsListPostRequest._(
          categoryId: categoryId,
          productNameId: productNameId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
