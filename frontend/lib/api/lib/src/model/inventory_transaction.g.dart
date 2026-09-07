// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_transaction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InventoryTransactionActionEnum _$inventoryTransactionActionEnum_RECEIVED =
    const InventoryTransactionActionEnum._('RECEIVED');
const InventoryTransactionActionEnum _$inventoryTransactionActionEnum_SHIPPED =
    const InventoryTransactionActionEnum._('SHIPPED');
const InventoryTransactionActionEnum _$inventoryTransactionActionEnum_SOLD =
    const InventoryTransactionActionEnum._('SOLD');
const InventoryTransactionActionEnum _$inventoryTransactionActionEnum_RETURNED =
    const InventoryTransactionActionEnum._('RETURNED');
const InventoryTransactionActionEnum
_$inventoryTransactionActionEnum_TRANSFERRED =
    const InventoryTransactionActionEnum._('TRANSFERRED');
const InventoryTransactionActionEnum _$inventoryTransactionActionEnum_RENTED =
    const InventoryTransactionActionEnum._('RENTED');
const InventoryTransactionActionEnum
_$inventoryTransactionActionEnum_RENT_RETURNED =
    const InventoryTransactionActionEnum._('RENT_RETURNED');
const InventoryTransactionActionEnum _$inventoryTransactionActionEnum_ADJUSTED =
    const InventoryTransactionActionEnum._('ADJUSTED');

InventoryTransactionActionEnum _$inventoryTransactionActionEnumValueOf(
  String name,
) {
  switch (name) {
    case 'RECEIVED':
      return _$inventoryTransactionActionEnum_RECEIVED;
    case 'SHIPPED':
      return _$inventoryTransactionActionEnum_SHIPPED;
    case 'SOLD':
      return _$inventoryTransactionActionEnum_SOLD;
    case 'RETURNED':
      return _$inventoryTransactionActionEnum_RETURNED;
    case 'TRANSFERRED':
      return _$inventoryTransactionActionEnum_TRANSFERRED;
    case 'RENTED':
      return _$inventoryTransactionActionEnum_RENTED;
    case 'RENT_RETURNED':
      return _$inventoryTransactionActionEnum_RENT_RETURNED;
    case 'ADJUSTED':
      return _$inventoryTransactionActionEnum_ADJUSTED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<InventoryTransactionActionEnum>
_$inventoryTransactionActionEnumValues =
    BuiltSet<InventoryTransactionActionEnum>(
      const <InventoryTransactionActionEnum>[
        _$inventoryTransactionActionEnum_RECEIVED,
        _$inventoryTransactionActionEnum_SHIPPED,
        _$inventoryTransactionActionEnum_SOLD,
        _$inventoryTransactionActionEnum_RETURNED,
        _$inventoryTransactionActionEnum_TRANSFERRED,
        _$inventoryTransactionActionEnum_RENTED,
        _$inventoryTransactionActionEnum_RENT_RETURNED,
        _$inventoryTransactionActionEnum_ADJUSTED,
      ],
    );

Serializer<InventoryTransactionActionEnum>
_$inventoryTransactionActionEnumSerializer =
    _$InventoryTransactionActionEnumSerializer();

class _$InventoryTransactionActionEnumSerializer
    implements PrimitiveSerializer<InventoryTransactionActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'RECEIVED': 'RECEIVED',
    'SHIPPED': 'SHIPPED',
    'SOLD': 'SOLD',
    'RETURNED': 'RETURNED',
    'TRANSFERRED': 'TRANSFERRED',
    'RENTED': 'RENTED',
    'RENT_RETURNED': 'RENT_RETURNED',
    'ADJUSTED': 'ADJUSTED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'RECEIVED': 'RECEIVED',
    'SHIPPED': 'SHIPPED',
    'SOLD': 'SOLD',
    'RETURNED': 'RETURNED',
    'TRANSFERRED': 'TRANSFERRED',
    'RENTED': 'RENTED',
    'RENT_RETURNED': 'RENT_RETURNED',
    'ADJUSTED': 'ADJUSTED',
  };

  @override
  final Iterable<Type> types = const <Type>[InventoryTransactionActionEnum];
  @override
  final String wireName = 'InventoryTransactionActionEnum';

  @override
  Object serialize(
    Serializers serializers,
    InventoryTransactionActionEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  InventoryTransactionActionEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => InventoryTransactionActionEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$InventoryTransaction extends InventoryTransaction {
  @override
  final String? id;
  @override
  final String? productUnitId;
  @override
  final String? fromUserId;
  @override
  final String? toUserId;
  @override
  final InventoryTransactionActionEnum? action;
  @override
  final DateTime? timestamp;

  factory _$InventoryTransaction([
    void Function(InventoryTransactionBuilder)? updates,
  ]) => (InventoryTransactionBuilder()..update(updates))._build();

  _$InventoryTransaction._({
    this.id,
    this.productUnitId,
    this.fromUserId,
    this.toUserId,
    this.action,
    this.timestamp,
  }) : super._();
  @override
  InventoryTransaction rebuild(
    void Function(InventoryTransactionBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InventoryTransactionBuilder toBuilder() =>
      InventoryTransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InventoryTransaction &&
        id == other.id &&
        productUnitId == other.productUnitId &&
        fromUserId == other.fromUserId &&
        toUserId == other.toUserId &&
        action == other.action &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productUnitId.hashCode);
    _$hash = $jc(_$hash, fromUserId.hashCode);
    _$hash = $jc(_$hash, toUserId.hashCode);
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InventoryTransaction')
          ..add('id', id)
          ..add('productUnitId', productUnitId)
          ..add('fromUserId', fromUserId)
          ..add('toUserId', toUserId)
          ..add('action', action)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class InventoryTransactionBuilder
    implements Builder<InventoryTransaction, InventoryTransactionBuilder> {
  _$InventoryTransaction? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _productUnitId;
  String? get productUnitId => _$this._productUnitId;
  set productUnitId(String? productUnitId) =>
      _$this._productUnitId = productUnitId;

  String? _fromUserId;
  String? get fromUserId => _$this._fromUserId;
  set fromUserId(String? fromUserId) => _$this._fromUserId = fromUserId;

  String? _toUserId;
  String? get toUserId => _$this._toUserId;
  set toUserId(String? toUserId) => _$this._toUserId = toUserId;

  InventoryTransactionActionEnum? _action;
  InventoryTransactionActionEnum? get action => _$this._action;
  set action(InventoryTransactionActionEnum? action) => _$this._action = action;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  InventoryTransactionBuilder() {
    InventoryTransaction._defaults(this);
  }

  InventoryTransactionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productUnitId = $v.productUnitId;
      _fromUserId = $v.fromUserId;
      _toUserId = $v.toUserId;
      _action = $v.action;
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InventoryTransaction other) {
    _$v = other as _$InventoryTransaction;
  }

  @override
  void update(void Function(InventoryTransactionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InventoryTransaction build() => _build();

  _$InventoryTransaction _build() {
    final _$result =
        _$v ??
        _$InventoryTransaction._(
          id: id,
          productUnitId: productUnitId,
          fromUserId: fromUserId,
          toUserId: toUserId,
          action: action,
          timestamp: timestamp,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
