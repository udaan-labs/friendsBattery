// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_shipments_post_request_items_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiShipmentsPostRequestItemsInner
    extends ApiShipmentsPostRequestItemsInner {
  @override
  final int productCategoryId;
  @override
  final int productNameId;
  @override
  final int productModelId;
  @override
  final int quantity;

  factory _$ApiShipmentsPostRequestItemsInner([
    void Function(ApiShipmentsPostRequestItemsInnerBuilder)? updates,
  ]) => (ApiShipmentsPostRequestItemsInnerBuilder()..update(updates))._build();

  _$ApiShipmentsPostRequestItemsInner._({
    required this.productCategoryId,
    required this.productNameId,
    required this.productModelId,
    required this.quantity,
  }) : super._();
  @override
  ApiShipmentsPostRequestItemsInner rebuild(
    void Function(ApiShipmentsPostRequestItemsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiShipmentsPostRequestItemsInnerBuilder toBuilder() =>
      ApiShipmentsPostRequestItemsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiShipmentsPostRequestItemsInner &&
        productCategoryId == other.productCategoryId &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        quantity == other.quantity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productCategoryId.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiShipmentsPostRequestItemsInner')
          ..add('productCategoryId', productCategoryId)
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('quantity', quantity))
        .toString();
  }
}

class ApiShipmentsPostRequestItemsInnerBuilder
    implements
        Builder<
          ApiShipmentsPostRequestItemsInner,
          ApiShipmentsPostRequestItemsInnerBuilder
        > {
  _$ApiShipmentsPostRequestItemsInner? _$v;

  int? _productCategoryId;
  int? get productCategoryId => _$this._productCategoryId;
  set productCategoryId(int? productCategoryId) =>
      _$this._productCategoryId = productCategoryId;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  ApiShipmentsPostRequestItemsInnerBuilder() {
    ApiShipmentsPostRequestItemsInner._defaults(this);
  }

  ApiShipmentsPostRequestItemsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productCategoryId = $v.productCategoryId;
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _quantity = $v.quantity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiShipmentsPostRequestItemsInner other) {
    _$v = other as _$ApiShipmentsPostRequestItemsInner;
  }

  @override
  void update(
    void Function(ApiShipmentsPostRequestItemsInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiShipmentsPostRequestItemsInner build() => _build();

  _$ApiShipmentsPostRequestItemsInner _build() {
    final _$result =
        _$v ??
        _$ApiShipmentsPostRequestItemsInner._(
          productCategoryId: BuiltValueNullFieldError.checkNotNull(
            productCategoryId,
            r'ApiShipmentsPostRequestItemsInner',
            'productCategoryId',
          ),
          productNameId: BuiltValueNullFieldError.checkNotNull(
            productNameId,
            r'ApiShipmentsPostRequestItemsInner',
            'productNameId',
          ),
          productModelId: BuiltValueNullFieldError.checkNotNull(
            productModelId,
            r'ApiShipmentsPostRequestItemsInner',
            'productModelId',
          ),
          quantity: BuiltValueNullFieldError.checkNotNull(
            quantity,
            r'ApiShipmentsPostRequestItemsInner',
            'quantity',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
