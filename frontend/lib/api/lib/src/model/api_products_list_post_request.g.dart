// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_products_list_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiProductsListPostRequest extends ApiProductsListPostRequest {
  @override
  final int? productNameId;
  @override
  final int? productModelId;

  factory _$ApiProductsListPostRequest([
    void Function(ApiProductsListPostRequestBuilder)? updates,
  ]) => (ApiProductsListPostRequestBuilder()..update(updates))._build();

  _$ApiProductsListPostRequest._({this.productNameId, this.productModelId})
    : super._();
  @override
  ApiProductsListPostRequest rebuild(
    void Function(ApiProductsListPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiProductsListPostRequestBuilder toBuilder() =>
      ApiProductsListPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiProductsListPostRequest &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiProductsListPostRequest')
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId))
        .toString();
  }
}

class ApiProductsListPostRequestBuilder
    implements
        Builder<ApiProductsListPostRequest, ApiProductsListPostRequestBuilder> {
  _$ApiProductsListPostRequest? _$v;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

  ApiProductsListPostRequestBuilder() {
    ApiProductsListPostRequest._defaults(this);
  }

  ApiProductsListPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiProductsListPostRequest other) {
    _$v = other as _$ApiProductsListPostRequest;
  }

  @override
  void update(void Function(ApiProductsListPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiProductsListPostRequest build() => _build();

  _$ApiProductsListPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiProductsListPostRequest._(
          productNameId: productNameId,
          productModelId: productModelId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
