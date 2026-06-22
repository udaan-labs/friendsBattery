// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const StockRequestStatusEnum _$stockRequestStatusEnum_PENDING =
    const StockRequestStatusEnum._('PENDING');
const StockRequestStatusEnum _$stockRequestStatusEnum_APPROVED =
    const StockRequestStatusEnum._('APPROVED');
const StockRequestStatusEnum _$stockRequestStatusEnum_REJECTED =
    const StockRequestStatusEnum._('REJECTED');
const StockRequestStatusEnum _$stockRequestStatusEnum_SHIPPED =
    const StockRequestStatusEnum._('SHIPPED');
const StockRequestStatusEnum _$stockRequestStatusEnum_DELIVERED =
    const StockRequestStatusEnum._('DELIVERED');

StockRequestStatusEnum _$stockRequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'PENDING':
      return _$stockRequestStatusEnum_PENDING;
    case 'APPROVED':
      return _$stockRequestStatusEnum_APPROVED;
    case 'REJECTED':
      return _$stockRequestStatusEnum_REJECTED;
    case 'SHIPPED':
      return _$stockRequestStatusEnum_SHIPPED;
    case 'DELIVERED':
      return _$stockRequestStatusEnum_DELIVERED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<StockRequestStatusEnum> _$stockRequestStatusEnumValues =
    BuiltSet<StockRequestStatusEnum>(const <StockRequestStatusEnum>[
      _$stockRequestStatusEnum_PENDING,
      _$stockRequestStatusEnum_APPROVED,
      _$stockRequestStatusEnum_REJECTED,
      _$stockRequestStatusEnum_SHIPPED,
      _$stockRequestStatusEnum_DELIVERED,
    ]);

Serializer<StockRequestStatusEnum> _$stockRequestStatusEnumSerializer =
    _$StockRequestStatusEnumSerializer();

class _$StockRequestStatusEnumSerializer
    implements PrimitiveSerializer<StockRequestStatusEnum> {
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
  final Iterable<Type> types = const <Type>[StockRequestStatusEnum];
  @override
  final String wireName = 'StockRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    StockRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  StockRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => StockRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$StockRequest extends StockRequest {
  @override
  final String? id;
  @override
  final String? sellerId;
  @override
  final String? requestTo;
  @override
  final StockRequestStatusEnum? status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? approvedAt;
  @override
  final BuiltList<StockRequestItem>? items;

  factory _$StockRequest([void Function(StockRequestBuilder)? updates]) =>
      (StockRequestBuilder()..update(updates))._build();

  _$StockRequest._({
    this.id,
    this.sellerId,
    this.requestTo,
    this.status,
    this.createdAt,
    this.approvedAt,
    this.items,
  }) : super._();
  @override
  StockRequest rebuild(void Function(StockRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StockRequestBuilder toBuilder() => StockRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StockRequest &&
        id == other.id &&
        sellerId == other.sellerId &&
        requestTo == other.requestTo &&
        status == other.status &&
        createdAt == other.createdAt &&
        approvedAt == other.approvedAt &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, sellerId.hashCode);
    _$hash = $jc(_$hash, requestTo.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, approvedAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StockRequest')
          ..add('id', id)
          ..add('sellerId', sellerId)
          ..add('requestTo', requestTo)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('approvedAt', approvedAt)
          ..add('items', items))
        .toString();
  }
}

class StockRequestBuilder
    implements Builder<StockRequest, StockRequestBuilder> {
  _$StockRequest? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _sellerId;
  String? get sellerId => _$this._sellerId;
  set sellerId(String? sellerId) => _$this._sellerId = sellerId;

  String? _requestTo;
  String? get requestTo => _$this._requestTo;
  set requestTo(String? requestTo) => _$this._requestTo = requestTo;

  StockRequestStatusEnum? _status;
  StockRequestStatusEnum? get status => _$this._status;
  set status(StockRequestStatusEnum? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _approvedAt;
  DateTime? get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime? approvedAt) => _$this._approvedAt = approvedAt;

  ListBuilder<StockRequestItem>? _items;
  ListBuilder<StockRequestItem> get items =>
      _$this._items ??= ListBuilder<StockRequestItem>();
  set items(ListBuilder<StockRequestItem>? items) => _$this._items = items;

  StockRequestBuilder() {
    StockRequest._defaults(this);
  }

  StockRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _sellerId = $v.sellerId;
      _requestTo = $v.requestTo;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _approvedAt = $v.approvedAt;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StockRequest other) {
    _$v = other as _$StockRequest;
  }

  @override
  void update(void Function(StockRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StockRequest build() => _build();

  _$StockRequest _build() {
    _$StockRequest _$result;
    try {
      _$result =
          _$v ??
          _$StockRequest._(
            id: id,
            sellerId: sellerId,
            requestTo: requestTo,
            status: status,
            createdAt: createdAt,
            approvedAt: approvedAt,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'StockRequest',
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
