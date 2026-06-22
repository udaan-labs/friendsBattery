// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_transfer_post_request_products_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryTransferPostRequestProductsInner
    extends ApiInventoryTransferPostRequestProductsInner {
  @override
  final int? productId;
  @override
  final int? quantity;

  factory _$ApiInventoryTransferPostRequestProductsInner([
    void Function(ApiInventoryTransferPostRequestProductsInnerBuilder)? updates,
  ]) => (ApiInventoryTransferPostRequestProductsInnerBuilder()..update(updates))
      ._build();

  _$ApiInventoryTransferPostRequestProductsInner._({
    this.productId,
    this.quantity,
  }) : super._();
  @override
  ApiInventoryTransferPostRequestProductsInner rebuild(
    void Function(ApiInventoryTransferPostRequestProductsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryTransferPostRequestProductsInnerBuilder toBuilder() =>
      ApiInventoryTransferPostRequestProductsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryTransferPostRequestProductsInner &&
        productId == other.productId &&
        quantity == other.quantity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiInventoryTransferPostRequestProductsInner',
          )
          ..add('productId', productId)
          ..add('quantity', quantity))
        .toString();
  }
}

class ApiInventoryTransferPostRequestProductsInnerBuilder
    implements
        Builder<
          ApiInventoryTransferPostRequestProductsInner,
          ApiInventoryTransferPostRequestProductsInnerBuilder
        > {
  _$ApiInventoryTransferPostRequestProductsInner? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  ApiInventoryTransferPostRequestProductsInnerBuilder() {
    ApiInventoryTransferPostRequestProductsInner._defaults(this);
  }

  ApiInventoryTransferPostRequestProductsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _quantity = $v.quantity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiInventoryTransferPostRequestProductsInner other) {
    _$v = other as _$ApiInventoryTransferPostRequestProductsInner;
  }

  @override
  void update(
    void Function(ApiInventoryTransferPostRequestProductsInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryTransferPostRequestProductsInner build() => _build();

  _$ApiInventoryTransferPostRequestProductsInner _build() {
    final _$result =
        _$v ??
        _$ApiInventoryTransferPostRequestProductsInner._(
          productId: productId,
          quantity: quantity,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
