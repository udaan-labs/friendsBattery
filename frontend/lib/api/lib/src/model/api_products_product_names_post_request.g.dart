// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_products_product_names_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiProductsProductNamesPostRequest
    extends ApiProductsProductNamesPostRequest {
  @override
  final String? name;

  factory _$ApiProductsProductNamesPostRequest([
    void Function(ApiProductsProductNamesPostRequestBuilder)? updates,
  ]) => (ApiProductsProductNamesPostRequestBuilder()..update(updates))._build();

  _$ApiProductsProductNamesPostRequest._({this.name}) : super._();
  @override
  ApiProductsProductNamesPostRequest rebuild(
    void Function(ApiProductsProductNamesPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiProductsProductNamesPostRequestBuilder toBuilder() =>
      ApiProductsProductNamesPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiProductsProductNamesPostRequest && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ApiProductsProductNamesPostRequest',
    )..add('name', name)).toString();
  }
}

class ApiProductsProductNamesPostRequestBuilder
    implements
        Builder<
          ApiProductsProductNamesPostRequest,
          ApiProductsProductNamesPostRequestBuilder
        > {
  _$ApiProductsProductNamesPostRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ApiProductsProductNamesPostRequestBuilder() {
    ApiProductsProductNamesPostRequest._defaults(this);
  }

  ApiProductsProductNamesPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiProductsProductNamesPostRequest other) {
    _$v = other as _$ApiProductsProductNamesPostRequest;
  }

  @override
  void update(
    void Function(ApiProductsProductNamesPostRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiProductsProductNamesPostRequest build() => _build();

  _$ApiProductsProductNamesPostRequest _build() {
    final _$result = _$v ?? _$ApiProductsProductNamesPostRequest._(name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
