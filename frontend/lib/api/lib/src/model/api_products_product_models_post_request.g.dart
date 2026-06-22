// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_products_product_models_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiProductsProductModelsPostRequest
    extends ApiProductsProductModelsPostRequest {
  @override
  final int? productNameId;
  @override
  final String? name;

  factory _$ApiProductsProductModelsPostRequest([
    void Function(ApiProductsProductModelsPostRequestBuilder)? updates,
  ]) =>
      (ApiProductsProductModelsPostRequestBuilder()..update(updates))._build();

  _$ApiProductsProductModelsPostRequest._({this.productNameId, this.name})
    : super._();
  @override
  ApiProductsProductModelsPostRequest rebuild(
    void Function(ApiProductsProductModelsPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiProductsProductModelsPostRequestBuilder toBuilder() =>
      ApiProductsProductModelsPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiProductsProductModelsPostRequest &&
        productNameId == other.productNameId &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiProductsProductModelsPostRequest')
          ..add('productNameId', productNameId)
          ..add('name', name))
        .toString();
  }
}

class ApiProductsProductModelsPostRequestBuilder
    implements
        Builder<
          ApiProductsProductModelsPostRequest,
          ApiProductsProductModelsPostRequestBuilder
        > {
  _$ApiProductsProductModelsPostRequest? _$v;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ApiProductsProductModelsPostRequestBuilder() {
    ApiProductsProductModelsPostRequest._defaults(this);
  }

  ApiProductsProductModelsPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productNameId = $v.productNameId;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiProductsProductModelsPostRequest other) {
    _$v = other as _$ApiProductsProductModelsPostRequest;
  }

  @override
  void update(
    void Function(ApiProductsProductModelsPostRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiProductsProductModelsPostRequest build() => _build();

  _$ApiProductsProductModelsPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiProductsProductModelsPostRequest._(
          productNameId: productNameId,
          name: name,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
