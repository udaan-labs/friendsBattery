// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ShipmentItem extends ShipmentItem {
  @override
  final String? id;
  @override
  final String? shipmentId;
  @override
  final String? productId;
  @override
  final int? quantity;
  @override
  final double? pricePerPiece;
  @override
  final bool? isShipmentRequested;

  factory _$ShipmentItem([void Function(ShipmentItemBuilder)? updates]) =>
      (ShipmentItemBuilder()..update(updates))._build();

  _$ShipmentItem._(
      {this.id,
      this.shipmentId,
      this.productId,
      this.quantity,
      this.pricePerPiece,
      this.isShipmentRequested})
      : super._();
  @override
  ShipmentItem rebuild(void Function(ShipmentItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShipmentItemBuilder toBuilder() => ShipmentItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShipmentItem &&
        id == other.id &&
        shipmentId == other.shipmentId &&
        productId == other.productId &&
        quantity == other.quantity &&
        pricePerPiece == other.pricePerPiece &&
        isShipmentRequested == other.isShipmentRequested;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, shipmentId.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, pricePerPiece.hashCode);
    _$hash = $jc(_$hash, isShipmentRequested.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ShipmentItem')
          ..add('id', id)
          ..add('shipmentId', shipmentId)
          ..add('productId', productId)
          ..add('quantity', quantity)
          ..add('pricePerPiece', pricePerPiece)
          ..add('isShipmentRequested', isShipmentRequested))
        .toString();
  }
}

class ShipmentItemBuilder
    implements Builder<ShipmentItem, ShipmentItemBuilder> {
  _$ShipmentItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _shipmentId;
  String? get shipmentId => _$this._shipmentId;
  set shipmentId(String? shipmentId) => _$this._shipmentId = shipmentId;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  double? _pricePerPiece;
  double? get pricePerPiece => _$this._pricePerPiece;
  set pricePerPiece(double? pricePerPiece) =>
      _$this._pricePerPiece = pricePerPiece;

  bool? _isShipmentRequested;
  bool? get isShipmentRequested => _$this._isShipmentRequested;
  set isShipmentRequested(bool? isShipmentRequested) =>
      _$this._isShipmentRequested = isShipmentRequested;

  ShipmentItemBuilder() {
    ShipmentItem._defaults(this);
  }

  ShipmentItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _shipmentId = $v.shipmentId;
      _productId = $v.productId;
      _quantity = $v.quantity;
      _pricePerPiece = $v.pricePerPiece;
      _isShipmentRequested = $v.isShipmentRequested;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShipmentItem other) {
    _$v = other as _$ShipmentItem;
  }

  @override
  void update(void Function(ShipmentItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ShipmentItem build() => _build();

  _$ShipmentItem _build() {
    final _$result = _$v ??
        _$ShipmentItem._(
          id: id,
          shipmentId: shipmentId,
          productId: productId,
          quantity: quantity,
          pricePerPiece: pricePerPiece,
          isShipmentRequested: isShipmentRequested,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
