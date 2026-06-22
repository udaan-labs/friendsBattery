// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_transfers_post_request_items_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiTransfersPostRequestItemsInner
    extends ApiTransfersPostRequestItemsInner {
  @override
  final int? productId;
  @override
  final int? quantity;
  @override
  final num? pricePerPiece;

  factory _$ApiTransfersPostRequestItemsInner([
    void Function(ApiTransfersPostRequestItemsInnerBuilder)? updates,
  ]) => (ApiTransfersPostRequestItemsInnerBuilder()..update(updates))._build();

  _$ApiTransfersPostRequestItemsInner._({
    this.productId,
    this.quantity,
    this.pricePerPiece,
  }) : super._();
  @override
  ApiTransfersPostRequestItemsInner rebuild(
    void Function(ApiTransfersPostRequestItemsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiTransfersPostRequestItemsInnerBuilder toBuilder() =>
      ApiTransfersPostRequestItemsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiTransfersPostRequestItemsInner &&
        productId == other.productId &&
        quantity == other.quantity &&
        pricePerPiece == other.pricePerPiece;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, pricePerPiece.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiTransfersPostRequestItemsInner')
          ..add('productId', productId)
          ..add('quantity', quantity)
          ..add('pricePerPiece', pricePerPiece))
        .toString();
  }
}

class ApiTransfersPostRequestItemsInnerBuilder
    implements
        Builder<
          ApiTransfersPostRequestItemsInner,
          ApiTransfersPostRequestItemsInnerBuilder
        > {
  _$ApiTransfersPostRequestItemsInner? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  num? _pricePerPiece;
  num? get pricePerPiece => _$this._pricePerPiece;
  set pricePerPiece(num? pricePerPiece) =>
      _$this._pricePerPiece = pricePerPiece;

  ApiTransfersPostRequestItemsInnerBuilder() {
    ApiTransfersPostRequestItemsInner._defaults(this);
  }

  ApiTransfersPostRequestItemsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _quantity = $v.quantity;
      _pricePerPiece = $v.pricePerPiece;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiTransfersPostRequestItemsInner other) {
    _$v = other as _$ApiTransfersPostRequestItemsInner;
  }

  @override
  void update(
    void Function(ApiTransfersPostRequestItemsInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiTransfersPostRequestItemsInner build() => _build();

  _$ApiTransfersPostRequestItemsInner _build() {
    final _$result =
        _$v ??
        _$ApiTransfersPostRequestItemsInner._(
          productId: productId,
          quantity: quantity,
          pricePerPiece: pricePerPiece,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
