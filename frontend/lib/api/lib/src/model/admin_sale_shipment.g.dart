// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_sale_shipment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminSaleShipment extends AdminSaleShipment {
  @override
  final int? id;
  @override
  final String? shipmentNumber;
  @override
  final DateTime? shipmentDate;
  @override
  final DateTime? arrivalDate;
  @override
  final String? status;

  factory _$AdminSaleShipment([
    void Function(AdminSaleShipmentBuilder)? updates,
  ]) => (AdminSaleShipmentBuilder()..update(updates))._build();

  _$AdminSaleShipment._({
    this.id,
    this.shipmentNumber,
    this.shipmentDate,
    this.arrivalDate,
    this.status,
  }) : super._();
  @override
  AdminSaleShipment rebuild(void Function(AdminSaleShipmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminSaleShipmentBuilder toBuilder() =>
      AdminSaleShipmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminSaleShipment &&
        id == other.id &&
        shipmentNumber == other.shipmentNumber &&
        shipmentDate == other.shipmentDate &&
        arrivalDate == other.arrivalDate &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, shipmentNumber.hashCode);
    _$hash = $jc(_$hash, shipmentDate.hashCode);
    _$hash = $jc(_$hash, arrivalDate.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminSaleShipment')
          ..add('id', id)
          ..add('shipmentNumber', shipmentNumber)
          ..add('shipmentDate', shipmentDate)
          ..add('arrivalDate', arrivalDate)
          ..add('status', status))
        .toString();
  }
}

class AdminSaleShipmentBuilder
    implements Builder<AdminSaleShipment, AdminSaleShipmentBuilder> {
  _$AdminSaleShipment? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _shipmentNumber;
  String? get shipmentNumber => _$this._shipmentNumber;
  set shipmentNumber(String? shipmentNumber) =>
      _$this._shipmentNumber = shipmentNumber;

  DateTime? _shipmentDate;
  DateTime? get shipmentDate => _$this._shipmentDate;
  set shipmentDate(DateTime? shipmentDate) =>
      _$this._shipmentDate = shipmentDate;

  DateTime? _arrivalDate;
  DateTime? get arrivalDate => _$this._arrivalDate;
  set arrivalDate(DateTime? arrivalDate) => _$this._arrivalDate = arrivalDate;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  AdminSaleShipmentBuilder() {
    AdminSaleShipment._defaults(this);
  }

  AdminSaleShipmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _shipmentNumber = $v.shipmentNumber;
      _shipmentDate = $v.shipmentDate;
      _arrivalDate = $v.arrivalDate;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminSaleShipment other) {
    _$v = other as _$AdminSaleShipment;
  }

  @override
  void update(void Function(AdminSaleShipmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminSaleShipment build() => _build();

  _$AdminSaleShipment _build() {
    final _$result =
        _$v ??
        _$AdminSaleShipment._(
          id: id,
          shipmentNumber: shipmentNumber,
          shipmentDate: shipmentDate,
          arrivalDate: arrivalDate,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
