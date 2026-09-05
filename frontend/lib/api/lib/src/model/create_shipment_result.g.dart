// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_shipment_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateShipmentResultStatusEnum _$createShipmentResultStatusEnum_PENDING =
    const CreateShipmentResultStatusEnum._('PENDING');
const CreateShipmentResultStatusEnum _$createShipmentResultStatusEnum_ACCEPTED =
    const CreateShipmentResultStatusEnum._('ACCEPTED');
const CreateShipmentResultStatusEnum _$createShipmentResultStatusEnum_REJECTED =
    const CreateShipmentResultStatusEnum._('REJECTED');

CreateShipmentResultStatusEnum _$createShipmentResultStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'PENDING':
      return _$createShipmentResultStatusEnum_PENDING;
    case 'ACCEPTED':
      return _$createShipmentResultStatusEnum_ACCEPTED;
    case 'REJECTED':
      return _$createShipmentResultStatusEnum_REJECTED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateShipmentResultStatusEnum>
_$createShipmentResultStatusEnumValues =
    BuiltSet<CreateShipmentResultStatusEnum>(
      const <CreateShipmentResultStatusEnum>[
        _$createShipmentResultStatusEnum_PENDING,
        _$createShipmentResultStatusEnum_ACCEPTED,
        _$createShipmentResultStatusEnum_REJECTED,
      ],
    );

Serializer<CreateShipmentResultStatusEnum>
_$createShipmentResultStatusEnumSerializer =
    _$CreateShipmentResultStatusEnumSerializer();

class _$CreateShipmentResultStatusEnumSerializer
    implements PrimitiveSerializer<CreateShipmentResultStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'ACCEPTED': 'ACCEPTED',
    'REJECTED': 'REJECTED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'ACCEPTED': 'ACCEPTED',
    'REJECTED': 'REJECTED',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateShipmentResultStatusEnum];
  @override
  final String wireName = 'CreateShipmentResultStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateShipmentResultStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateShipmentResultStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateShipmentResultStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateShipmentResult extends CreateShipmentResult {
  @override
  final int? shipmentId;
  @override
  final String? shipmentNumber;
  @override
  final CreateShipmentResultStatusEnum? status;
  @override
  final int? transferredUnits;
  @override
  final int? sellerId;

  factory _$CreateShipmentResult([
    void Function(CreateShipmentResultBuilder)? updates,
  ]) => (CreateShipmentResultBuilder()..update(updates))._build();

  _$CreateShipmentResult._({
    this.shipmentId,
    this.shipmentNumber,
    this.status,
    this.transferredUnits,
    this.sellerId,
  }) : super._();
  @override
  CreateShipmentResult rebuild(
    void Function(CreateShipmentResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateShipmentResultBuilder toBuilder() =>
      CreateShipmentResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateShipmentResult &&
        shipmentId == other.shipmentId &&
        shipmentNumber == other.shipmentNumber &&
        status == other.status &&
        transferredUnits == other.transferredUnits &&
        sellerId == other.sellerId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, shipmentId.hashCode);
    _$hash = $jc(_$hash, shipmentNumber.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, transferredUnits.hashCode);
    _$hash = $jc(_$hash, sellerId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateShipmentResult')
          ..add('shipmentId', shipmentId)
          ..add('shipmentNumber', shipmentNumber)
          ..add('status', status)
          ..add('transferredUnits', transferredUnits)
          ..add('sellerId', sellerId))
        .toString();
  }
}

class CreateShipmentResultBuilder
    implements Builder<CreateShipmentResult, CreateShipmentResultBuilder> {
  _$CreateShipmentResult? _$v;

  int? _shipmentId;
  int? get shipmentId => _$this._shipmentId;
  set shipmentId(int? shipmentId) => _$this._shipmentId = shipmentId;

  String? _shipmentNumber;
  String? get shipmentNumber => _$this._shipmentNumber;
  set shipmentNumber(String? shipmentNumber) =>
      _$this._shipmentNumber = shipmentNumber;

  CreateShipmentResultStatusEnum? _status;
  CreateShipmentResultStatusEnum? get status => _$this._status;
  set status(CreateShipmentResultStatusEnum? status) => _$this._status = status;

  int? _transferredUnits;
  int? get transferredUnits => _$this._transferredUnits;
  set transferredUnits(int? transferredUnits) =>
      _$this._transferredUnits = transferredUnits;

  int? _sellerId;
  int? get sellerId => _$this._sellerId;
  set sellerId(int? sellerId) => _$this._sellerId = sellerId;

  CreateShipmentResultBuilder() {
    CreateShipmentResult._defaults(this);
  }

  CreateShipmentResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _shipmentId = $v.shipmentId;
      _shipmentNumber = $v.shipmentNumber;
      _status = $v.status;
      _transferredUnits = $v.transferredUnits;
      _sellerId = $v.sellerId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateShipmentResult other) {
    _$v = other as _$CreateShipmentResult;
  }

  @override
  void update(void Function(CreateShipmentResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateShipmentResult build() => _build();

  _$CreateShipmentResult _build() {
    final _$result =
        _$v ??
        _$CreateShipmentResult._(
          shipmentId: shipmentId,
          shipmentNumber: shipmentNumber,
          status: status,
          transferredUnits: transferredUnits,
          sellerId: sellerId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
