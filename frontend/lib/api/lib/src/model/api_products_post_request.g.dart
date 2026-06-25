// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_products_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiProductsPostRequest extends ApiProductsPostRequest {
  @override
  final int? categoryId;
  @override
  final int? productNameId;
  @override
  final int? productModelId;
  @override
  final num? minPrice;
  @override
  final bool? onSale;
  @override
  final num? offerPrice;
  @override
  final int? minUnitCountAdmin;
  @override
  final int? minUnitCountSeller;

  factory _$ApiProductsPostRequest([
    void Function(ApiProductsPostRequestBuilder)? updates,
  ]) => (ApiProductsPostRequestBuilder()..update(updates))._build();

  _$ApiProductsPostRequest._({
    this.categoryId,
    this.productNameId,
    this.productModelId,
    this.minPrice,
    this.onSale,
    this.offerPrice,
    this.minUnitCountAdmin,
    this.minUnitCountSeller,
  }) : super._();
  @override
  ApiProductsPostRequest rebuild(
    void Function(ApiProductsPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiProductsPostRequestBuilder toBuilder() =>
      ApiProductsPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiProductsPostRequest &&
        categoryId == other.categoryId &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        minPrice == other.minPrice &&
        onSale == other.onSale &&
        offerPrice == other.offerPrice &&
        minUnitCountAdmin == other.minUnitCountAdmin &&
        minUnitCountSeller == other.minUnitCountSeller;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, minPrice.hashCode);
    _$hash = $jc(_$hash, onSale.hashCode);
    _$hash = $jc(_$hash, offerPrice.hashCode);
    _$hash = $jc(_$hash, minUnitCountAdmin.hashCode);
    _$hash = $jc(_$hash, minUnitCountSeller.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiProductsPostRequest')
          ..add('categoryId', categoryId)
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('minPrice', minPrice)
          ..add('onSale', onSale)
          ..add('offerPrice', offerPrice)
          ..add('minUnitCountAdmin', minUnitCountAdmin)
          ..add('minUnitCountSeller', minUnitCountSeller))
        .toString();
  }
}

class ApiProductsPostRequestBuilder
    implements Builder<ApiProductsPostRequest, ApiProductsPostRequestBuilder> {
  _$ApiProductsPostRequest? _$v;

  int? _categoryId;
  int? get categoryId => _$this._categoryId;
  set categoryId(int? categoryId) => _$this._categoryId = categoryId;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

  num? _minPrice;
  num? get minPrice => _$this._minPrice;
  set minPrice(num? minPrice) => _$this._minPrice = minPrice;

  bool? _onSale;
  bool? get onSale => _$this._onSale;
  set onSale(bool? onSale) => _$this._onSale = onSale;

  num? _offerPrice;
  num? get offerPrice => _$this._offerPrice;
  set offerPrice(num? offerPrice) => _$this._offerPrice = offerPrice;

  int? _minUnitCountAdmin;
  int? get minUnitCountAdmin => _$this._minUnitCountAdmin;
  set minUnitCountAdmin(int? minUnitCountAdmin) =>
      _$this._minUnitCountAdmin = minUnitCountAdmin;

  int? _minUnitCountSeller;
  int? get minUnitCountSeller => _$this._minUnitCountSeller;
  set minUnitCountSeller(int? minUnitCountSeller) =>
      _$this._minUnitCountSeller = minUnitCountSeller;

  ApiProductsPostRequestBuilder() {
    ApiProductsPostRequest._defaults(this);
  }

  ApiProductsPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categoryId = $v.categoryId;
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _minPrice = $v.minPrice;
      _onSale = $v.onSale;
      _offerPrice = $v.offerPrice;
      _minUnitCountAdmin = $v.minUnitCountAdmin;
      _minUnitCountSeller = $v.minUnitCountSeller;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiProductsPostRequest other) {
    _$v = other as _$ApiProductsPostRequest;
  }

  @override
  void update(void Function(ApiProductsPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiProductsPostRequest build() => _build();

  _$ApiProductsPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiProductsPostRequest._(
          categoryId: categoryId,
          productNameId: productNameId,
          productModelId: productModelId,
          minPrice: minPrice,
          onSale: onSale,
          offerPrice: offerPrice,
          minUnitCountAdmin: minUnitCountAdmin,
          minUnitCountSeller: minUnitCountSeller,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
