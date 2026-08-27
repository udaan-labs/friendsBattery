// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_shipment_list_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerShipmentListItem extends SellerShipmentListItem {
  @override
  final int? shipmentId;
  @override
  final String? shipmentNumber;
  @override
  final String? status;
  @override
  final String? createdAt;
  @override
  final String? acceptedAt;
  @override
  final BuiltList<SellerShipmentListItemItemsInner>? items;

  factory _$SellerShipmentListItem([
    void Function(SellerShipmentListItemBuilder)? updates,
  ]) => (SellerShipmentListItemBuilder()..update(updates))._build();

  _$SellerShipmentListItem._({
    this.shipmentId,
    this.shipmentNumber,
    this.status,
    this.createdAt,
    this.acceptedAt,
    this.items,
  }) : super._();
  @override
  SellerShipmentListItem rebuild(
    void Function(SellerShipmentListItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SellerShipmentListItemBuilder toBuilder() =>
      SellerShipmentListItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerShipmentListItem &&
        shipmentId == other.shipmentId &&
        shipmentNumber == other.shipmentNumber &&
        status == other.status &&
        createdAt == other.createdAt &&
        acceptedAt == other.acceptedAt &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, shipmentId.hashCode);
    _$hash = $jc(_$hash, shipmentNumber.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, acceptedAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SellerShipmentListItem')
          ..add('shipmentId', shipmentId)
          ..add('shipmentNumber', shipmentNumber)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('acceptedAt', acceptedAt)
          ..add('items', items))
        .toString();
  }
}

class SellerShipmentListItemBuilder
    implements Builder<SellerShipmentListItem, SellerShipmentListItemBuilder> {
  _$SellerShipmentListItem? _$v;

  int? _shipmentId;
  int? get shipmentId => _$this._shipmentId;
  set shipmentId(int? shipmentId) => _$this._shipmentId = shipmentId;

  String? _shipmentNumber;
  String? get shipmentNumber => _$this._shipmentNumber;
  set shipmentNumber(String? shipmentNumber) =>
      _$this._shipmentNumber = shipmentNumber;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _acceptedAt;
  String? get acceptedAt => _$this._acceptedAt;
  set acceptedAt(String? acceptedAt) => _$this._acceptedAt = acceptedAt;

  ListBuilder<SellerShipmentListItemItemsInner>? _items;
  ListBuilder<SellerShipmentListItemItemsInner> get items =>
      _$this._items ??= ListBuilder<SellerShipmentListItemItemsInner>();
  set items(ListBuilder<SellerShipmentListItemItemsInner>? items) =>
      _$this._items = items;

  SellerShipmentListItemBuilder() {
    SellerShipmentListItem._defaults(this);
  }

  SellerShipmentListItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _shipmentId = $v.shipmentId;
      _shipmentNumber = $v.shipmentNumber;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _acceptedAt = $v.acceptedAt;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SellerShipmentListItem other) {
    _$v = other as _$SellerShipmentListItem;
  }

  @override
  void update(void Function(SellerShipmentListItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerShipmentListItem build() => _build();

  _$SellerShipmentListItem _build() {
    _$SellerShipmentListItem _$result;
    try {
      _$result =
          _$v ??
          _$SellerShipmentListItem._(
            shipmentId: shipmentId,
            shipmentNumber: shipmentNumber,
            status: status,
            createdAt: createdAt,
            acceptedAt: acceptedAt,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SellerShipmentListItem',
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
