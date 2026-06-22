// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_transfer_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryTransferPostRequest
    extends ApiInventoryTransferPostRequest {
  @override
  final int sellerId;
  @override
  final BuiltList<ApiInventoryTransferPostRequestProductsInner> products;

  factory _$ApiInventoryTransferPostRequest([
    void Function(ApiInventoryTransferPostRequestBuilder)? updates,
  ]) => (ApiInventoryTransferPostRequestBuilder()..update(updates))._build();

  _$ApiInventoryTransferPostRequest._({
    required this.sellerId,
    required this.products,
  }) : super._();
  @override
  ApiInventoryTransferPostRequest rebuild(
    void Function(ApiInventoryTransferPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryTransferPostRequestBuilder toBuilder() =>
      ApiInventoryTransferPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryTransferPostRequest &&
        sellerId == other.sellerId &&
        products == other.products;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sellerId.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiInventoryTransferPostRequest')
          ..add('sellerId', sellerId)
          ..add('products', products))
        .toString();
  }
}

class ApiInventoryTransferPostRequestBuilder
    implements
        Builder<
          ApiInventoryTransferPostRequest,
          ApiInventoryTransferPostRequestBuilder
        > {
  _$ApiInventoryTransferPostRequest? _$v;

  int? _sellerId;
  int? get sellerId => _$this._sellerId;
  set sellerId(int? sellerId) => _$this._sellerId = sellerId;

  ListBuilder<ApiInventoryTransferPostRequestProductsInner>? _products;
  ListBuilder<ApiInventoryTransferPostRequestProductsInner> get products =>
      _$this._products ??=
          ListBuilder<ApiInventoryTransferPostRequestProductsInner>();
  set products(
    ListBuilder<ApiInventoryTransferPostRequestProductsInner>? products,
  ) => _$this._products = products;

  ApiInventoryTransferPostRequestBuilder() {
    ApiInventoryTransferPostRequest._defaults(this);
  }

  ApiInventoryTransferPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sellerId = $v.sellerId;
      _products = $v.products.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiInventoryTransferPostRequest other) {
    _$v = other as _$ApiInventoryTransferPostRequest;
  }

  @override
  void update(void Function(ApiInventoryTransferPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryTransferPostRequest build() => _build();

  _$ApiInventoryTransferPostRequest _build() {
    _$ApiInventoryTransferPostRequest _$result;
    try {
      _$result =
          _$v ??
          _$ApiInventoryTransferPostRequest._(
            sellerId: BuiltValueNullFieldError.checkNotNull(
              sellerId,
              r'ApiInventoryTransferPostRequest',
              'sellerId',
            ),
            products: products.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'products';
        products.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApiInventoryTransferPostRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
