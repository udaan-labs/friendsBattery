// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_request_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StockRequestItem extends StockRequestItem {
  @override
  final String? id;
  @override
  final String? stockRequestId;
  @override
  final String? productId;
  @override
  final int? requestedQuantity;

  factory _$StockRequestItem([
    void Function(StockRequestItemBuilder)? updates,
  ]) => (StockRequestItemBuilder()..update(updates))._build();

  _$StockRequestItem._({
    this.id,
    this.stockRequestId,
    this.productId,
    this.requestedQuantity,
  }) : super._();
  @override
  StockRequestItem rebuild(void Function(StockRequestItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StockRequestItemBuilder toBuilder() =>
      StockRequestItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StockRequestItem &&
        id == other.id &&
        stockRequestId == other.stockRequestId &&
        productId == other.productId &&
        requestedQuantity == other.requestedQuantity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, stockRequestId.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, requestedQuantity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StockRequestItem')
          ..add('id', id)
          ..add('stockRequestId', stockRequestId)
          ..add('productId', productId)
          ..add('requestedQuantity', requestedQuantity))
        .toString();
  }
}

class StockRequestItemBuilder
    implements Builder<StockRequestItem, StockRequestItemBuilder> {
  _$StockRequestItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _stockRequestId;
  String? get stockRequestId => _$this._stockRequestId;
  set stockRequestId(String? stockRequestId) =>
      _$this._stockRequestId = stockRequestId;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  int? _requestedQuantity;
  int? get requestedQuantity => _$this._requestedQuantity;
  set requestedQuantity(int? requestedQuantity) =>
      _$this._requestedQuantity = requestedQuantity;

  StockRequestItemBuilder() {
    StockRequestItem._defaults(this);
  }

  StockRequestItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _stockRequestId = $v.stockRequestId;
      _productId = $v.productId;
      _requestedQuantity = $v.requestedQuantity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StockRequestItem other) {
    _$v = other as _$StockRequestItem;
  }

  @override
  void update(void Function(StockRequestItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StockRequestItem build() => _build();

  _$StockRequestItem _build() {
    final _$result =
        _$v ??
        _$StockRequestItem._(
          id: id,
          stockRequestId: stockRequestId,
          productId: productId,
          requestedQuantity: requestedQuantity,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
