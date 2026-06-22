// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_product_id_get200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryProductIdGet200ResponseData
    extends ApiInventoryProductIdGet200ResponseData {
  @override
  final int? productId;
  @override
  final String? category;
  @override
  final String? brand;
  @override
  final String? model;
  @override
  final int? quantity;
  @override
  final num? minPrice;
  @override
  final num? offerPrice;

  factory _$ApiInventoryProductIdGet200ResponseData([
    void Function(ApiInventoryProductIdGet200ResponseDataBuilder)? updates,
  ]) => (ApiInventoryProductIdGet200ResponseDataBuilder()..update(updates))
      ._build();

  _$ApiInventoryProductIdGet200ResponseData._({
    this.productId,
    this.category,
    this.brand,
    this.model,
    this.quantity,
    this.minPrice,
    this.offerPrice,
  }) : super._();
  @override
  ApiInventoryProductIdGet200ResponseData rebuild(
    void Function(ApiInventoryProductIdGet200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryProductIdGet200ResponseDataBuilder toBuilder() =>
      ApiInventoryProductIdGet200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryProductIdGet200ResponseData &&
        productId == other.productId &&
        category == other.category &&
        brand == other.brand &&
        model == other.model &&
        quantity == other.quantity &&
        minPrice == other.minPrice &&
        offerPrice == other.offerPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, minPrice.hashCode);
    _$hash = $jc(_$hash, offerPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiInventoryProductIdGet200ResponseData',
          )
          ..add('productId', productId)
          ..add('category', category)
          ..add('brand', brand)
          ..add('model', model)
          ..add('quantity', quantity)
          ..add('minPrice', minPrice)
          ..add('offerPrice', offerPrice))
        .toString();
  }
}

class ApiInventoryProductIdGet200ResponseDataBuilder
    implements
        Builder<
          ApiInventoryProductIdGet200ResponseData,
          ApiInventoryProductIdGet200ResponseDataBuilder
        > {
  _$ApiInventoryProductIdGet200ResponseData? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _brand;
  String? get brand => _$this._brand;
  set brand(String? brand) => _$this._brand = brand;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  num? _minPrice;
  num? get minPrice => _$this._minPrice;
  set minPrice(num? minPrice) => _$this._minPrice = minPrice;

  num? _offerPrice;
  num? get offerPrice => _$this._offerPrice;
  set offerPrice(num? offerPrice) => _$this._offerPrice = offerPrice;

  ApiInventoryProductIdGet200ResponseDataBuilder() {
    ApiInventoryProductIdGet200ResponseData._defaults(this);
  }

  ApiInventoryProductIdGet200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _category = $v.category;
      _brand = $v.brand;
      _model = $v.model;
      _quantity = $v.quantity;
      _minPrice = $v.minPrice;
      _offerPrice = $v.offerPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiInventoryProductIdGet200ResponseData other) {
    _$v = other as _$ApiInventoryProductIdGet200ResponseData;
  }

  @override
  void update(
    void Function(ApiInventoryProductIdGet200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryProductIdGet200ResponseData build() => _build();

  _$ApiInventoryProductIdGet200ResponseData _build() {
    final _$result =
        _$v ??
        _$ApiInventoryProductIdGet200ResponseData._(
          productId: productId,
          category: category,
          brand: brand,
          model: model,
          quantity: quantity,
          minPrice: minPrice,
          offerPrice: offerPrice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
