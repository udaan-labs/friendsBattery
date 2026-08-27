// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateProductRequest extends CreateProductRequest {
  @override
  final int productNameId;
  @override
  final int productModelId;
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

  factory _$CreateProductRequest([
    void Function(CreateProductRequestBuilder)? updates,
  ]) => (CreateProductRequestBuilder()..update(updates))._build();

  _$CreateProductRequest._({
    required this.productNameId,
    required this.productModelId,
    this.minPrice,
    this.onSale,
    this.offerPrice,
    this.minUnitCountAdmin,
    this.minUnitCountSeller,
  }) : super._();
  @override
  CreateProductRequest rebuild(
    void Function(CreateProductRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateProductRequestBuilder toBuilder() =>
      CreateProductRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateProductRequest &&
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
    return (newBuiltValueToStringHelper(r'CreateProductRequest')
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

class CreateProductRequestBuilder
    implements Builder<CreateProductRequest, CreateProductRequestBuilder> {
  _$CreateProductRequest? _$v;

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

  CreateProductRequestBuilder() {
    CreateProductRequest._defaults(this);
  }

  CreateProductRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(CreateProductRequest other) {
    _$v = other as _$CreateProductRequest;
  }

  @override
  void update(void Function(CreateProductRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateProductRequest build() => _build();

  _$CreateProductRequest _build() {
    final _$result =
        _$v ??
        _$CreateProductRequest._(
          productNameId: BuiltValueNullFieldError.checkNotNull(
            productNameId,
            r'CreateProductRequest',
            'productNameId',
          ),
          productModelId: BuiltValueNullFieldError.checkNotNull(
            productModelId,
            r'CreateProductRequest',
            'productModelId',
          ),
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
