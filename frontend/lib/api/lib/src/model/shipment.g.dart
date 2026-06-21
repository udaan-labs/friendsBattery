// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ShipmentStatusEnum _$shipmentStatusEnum_PENDING =
    const ShipmentStatusEnum._('PENDING');
const ShipmentStatusEnum _$shipmentStatusEnum_APPROVED =
    const ShipmentStatusEnum._('APPROVED');
const ShipmentStatusEnum _$shipmentStatusEnum_REJECTED =
    const ShipmentStatusEnum._('REJECTED');
const ShipmentStatusEnum _$shipmentStatusEnum_SHIPPED =
    const ShipmentStatusEnum._('SHIPPED');
const ShipmentStatusEnum _$shipmentStatusEnum_DELIVERED =
    const ShipmentStatusEnum._('DELIVERED');

ShipmentStatusEnum _$shipmentStatusEnumValueOf(String name) {
  switch (name) {
    case 'PENDING':
      return _$shipmentStatusEnum_PENDING;
    case 'APPROVED':
      return _$shipmentStatusEnum_APPROVED;
    case 'REJECTED':
      return _$shipmentStatusEnum_REJECTED;
    case 'SHIPPED':
      return _$shipmentStatusEnum_SHIPPED;
    case 'DELIVERED':
      return _$shipmentStatusEnum_DELIVERED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ShipmentStatusEnum> _$shipmentStatusEnumValues =
    BuiltSet<ShipmentStatusEnum>(const <ShipmentStatusEnum>[
  _$shipmentStatusEnum_PENDING,
  _$shipmentStatusEnum_APPROVED,
  _$shipmentStatusEnum_REJECTED,
  _$shipmentStatusEnum_SHIPPED,
  _$shipmentStatusEnum_DELIVERED,
]);

Serializer<ShipmentStatusEnum> _$shipmentStatusEnumSerializer =
    _$ShipmentStatusEnumSerializer();

class _$ShipmentStatusEnumSerializer
    implements PrimitiveSerializer<ShipmentStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
    'SHIPPED': 'SHIPPED',
    'DELIVERED': 'DELIVERED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
    'SHIPPED': 'SHIPPED',
    'DELIVERED': 'DELIVERED',
  };

  @override
  final Iterable<Type> types = const <Type>[ShipmentStatusEnum];
  @override
  final String wireName = 'ShipmentStatusEnum';

  @override
  Object serialize(Serializers serializers, ShipmentStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ShipmentStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ShipmentStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Shipment extends Shipment {
  @override
  final String? id;
  @override
  final String? fromUserId;
  @override
  final String? toUserId;
  @override
  final int? totalProductsShipped;
  @override
  final double? shipmentPrice;
  @override
  final ShipmentStatusEnum? status;
  @override
  final DateTime? shippedOn;
  @override
  final DateTime? deliveredOn;
  @override
  final DateTime? createdAt;
  @override
  final BuiltList<ShipmentItem>? items;

  factory _$Shipment([void Function(ShipmentBuilder)? updates]) =>
      (ShipmentBuilder()..update(updates))._build();

  _$Shipment._(
      {this.id,
      this.fromUserId,
      this.toUserId,
      this.totalProductsShipped,
      this.shipmentPrice,
      this.status,
      this.shippedOn,
      this.deliveredOn,
      this.createdAt,
      this.items})
      : super._();
  @override
  Shipment rebuild(void Function(ShipmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShipmentBuilder toBuilder() => ShipmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Shipment &&
        id == other.id &&
        fromUserId == other.fromUserId &&
        toUserId == other.toUserId &&
        totalProductsShipped == other.totalProductsShipped &&
        shipmentPrice == other.shipmentPrice &&
        status == other.status &&
        shippedOn == other.shippedOn &&
        deliveredOn == other.deliveredOn &&
        createdAt == other.createdAt &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, fromUserId.hashCode);
    _$hash = $jc(_$hash, toUserId.hashCode);
    _$hash = $jc(_$hash, totalProductsShipped.hashCode);
    _$hash = $jc(_$hash, shipmentPrice.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, shippedOn.hashCode);
    _$hash = $jc(_$hash, deliveredOn.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Shipment')
          ..add('id', id)
          ..add('fromUserId', fromUserId)
          ..add('toUserId', toUserId)
          ..add('totalProductsShipped', totalProductsShipped)
          ..add('shipmentPrice', shipmentPrice)
          ..add('status', status)
          ..add('shippedOn', shippedOn)
          ..add('deliveredOn', deliveredOn)
          ..add('createdAt', createdAt)
          ..add('items', items))
        .toString();
  }
}

class ShipmentBuilder implements Builder<Shipment, ShipmentBuilder> {
  _$Shipment? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _fromUserId;
  String? get fromUserId => _$this._fromUserId;
  set fromUserId(String? fromUserId) => _$this._fromUserId = fromUserId;

  String? _toUserId;
  String? get toUserId => _$this._toUserId;
  set toUserId(String? toUserId) => _$this._toUserId = toUserId;

  int? _totalProductsShipped;
  int? get totalProductsShipped => _$this._totalProductsShipped;
  set totalProductsShipped(int? totalProductsShipped) =>
      _$this._totalProductsShipped = totalProductsShipped;

  double? _shipmentPrice;
  double? get shipmentPrice => _$this._shipmentPrice;
  set shipmentPrice(double? shipmentPrice) =>
      _$this._shipmentPrice = shipmentPrice;

  ShipmentStatusEnum? _status;
  ShipmentStatusEnum? get status => _$this._status;
  set status(ShipmentStatusEnum? status) => _$this._status = status;

  DateTime? _shippedOn;
  DateTime? get shippedOn => _$this._shippedOn;
  set shippedOn(DateTime? shippedOn) => _$this._shippedOn = shippedOn;

  DateTime? _deliveredOn;
  DateTime? get deliveredOn => _$this._deliveredOn;
  set deliveredOn(DateTime? deliveredOn) => _$this._deliveredOn = deliveredOn;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ListBuilder<ShipmentItem>? _items;
  ListBuilder<ShipmentItem> get items =>
      _$this._items ??= ListBuilder<ShipmentItem>();
  set items(ListBuilder<ShipmentItem>? items) => _$this._items = items;

  ShipmentBuilder() {
    Shipment._defaults(this);
  }

  ShipmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _fromUserId = $v.fromUserId;
      _toUserId = $v.toUserId;
      _totalProductsShipped = $v.totalProductsShipped;
      _shipmentPrice = $v.shipmentPrice;
      _status = $v.status;
      _shippedOn = $v.shippedOn;
      _deliveredOn = $v.deliveredOn;
      _createdAt = $v.createdAt;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Shipment other) {
    _$v = other as _$Shipment;
  }

  @override
  void update(void Function(ShipmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Shipment build() => _build();

  _$Shipment _build() {
    _$Shipment _$result;
    try {
      _$result = _$v ??
          _$Shipment._(
            id: id,
            fromUserId: fromUserId,
            toUserId: toUserId,
            totalProductsShipped: totalProductsShipped,
            shipmentPrice: shipmentPrice,
            status: status,
            shippedOn: shippedOn,
            deliveredOn: deliveredOn,
            createdAt: createdAt,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Shipment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
