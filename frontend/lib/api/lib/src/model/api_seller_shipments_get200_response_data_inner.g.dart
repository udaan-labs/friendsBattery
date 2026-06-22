// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_seller_shipments_get200_response_data_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiSellerShipmentsGet200ResponseDataInner
    extends ApiSellerShipmentsGet200ResponseDataInner {
  @override
  final int? shipmentId;
  @override
  final String? shipmentNumber;
  @override
  final String? status;
  @override
  final String? createdAt;
  @override
  final BuiltList<ApiSellerShipmentsGet200ResponseDataInnerItemsInner>? items;

  factory _$ApiSellerShipmentsGet200ResponseDataInner([
    void Function(ApiSellerShipmentsGet200ResponseDataInnerBuilder)? updates,
  ]) => (ApiSellerShipmentsGet200ResponseDataInnerBuilder()..update(updates))
      ._build();

  _$ApiSellerShipmentsGet200ResponseDataInner._({
    this.shipmentId,
    this.shipmentNumber,
    this.status,
    this.createdAt,
    this.items,
  }) : super._();
  @override
  ApiSellerShipmentsGet200ResponseDataInner rebuild(
    void Function(ApiSellerShipmentsGet200ResponseDataInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiSellerShipmentsGet200ResponseDataInnerBuilder toBuilder() =>
      ApiSellerShipmentsGet200ResponseDataInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiSellerShipmentsGet200ResponseDataInner &&
        shipmentId == other.shipmentId &&
        shipmentNumber == other.shipmentNumber &&
        status == other.status &&
        createdAt == other.createdAt &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, shipmentId.hashCode);
    _$hash = $jc(_$hash, shipmentNumber.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiSellerShipmentsGet200ResponseDataInner',
          )
          ..add('shipmentId', shipmentId)
          ..add('shipmentNumber', shipmentNumber)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('items', items))
        .toString();
  }
}

class ApiSellerShipmentsGet200ResponseDataInnerBuilder
    implements
        Builder<
          ApiSellerShipmentsGet200ResponseDataInner,
          ApiSellerShipmentsGet200ResponseDataInnerBuilder
        > {
  _$ApiSellerShipmentsGet200ResponseDataInner? _$v;

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

  ListBuilder<ApiSellerShipmentsGet200ResponseDataInnerItemsInner>? _items;
  ListBuilder<ApiSellerShipmentsGet200ResponseDataInnerItemsInner> get items =>
      _$this._items ??=
          ListBuilder<ApiSellerShipmentsGet200ResponseDataInnerItemsInner>();
  set items(
    ListBuilder<ApiSellerShipmentsGet200ResponseDataInnerItemsInner>? items,
  ) => _$this._items = items;

  ApiSellerShipmentsGet200ResponseDataInnerBuilder() {
    ApiSellerShipmentsGet200ResponseDataInner._defaults(this);
  }

  ApiSellerShipmentsGet200ResponseDataInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _shipmentId = $v.shipmentId;
      _shipmentNumber = $v.shipmentNumber;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiSellerShipmentsGet200ResponseDataInner other) {
    _$v = other as _$ApiSellerShipmentsGet200ResponseDataInner;
  }

  @override
  void update(
    void Function(ApiSellerShipmentsGet200ResponseDataInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiSellerShipmentsGet200ResponseDataInner build() => _build();

  _$ApiSellerShipmentsGet200ResponseDataInner _build() {
    _$ApiSellerShipmentsGet200ResponseDataInner _$result;
    try {
      _$result =
          _$v ??
          _$ApiSellerShipmentsGet200ResponseDataInner._(
            shipmentId: shipmentId,
            shipmentNumber: shipmentNumber,
            status: status,
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
          r'ApiSellerShipmentsGet200ResponseDataInner',
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
