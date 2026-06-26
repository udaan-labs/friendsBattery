// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_shipments_id_get200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiShipmentsIdGet200ResponseData
    extends ApiShipmentsIdGet200ResponseData {
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
  final ApiShipmentsIdGet200ResponseDataSeller? seller;
  @override
  final int? totalProducts;
  @override
  final int? totalQuantity;
  @override
  final BuiltList<ApiShipmentsIdGet200ResponseDataItemsInner>? items;

  factory _$ApiShipmentsIdGet200ResponseData([
    void Function(ApiShipmentsIdGet200ResponseDataBuilder)? updates,
  ]) => (ApiShipmentsIdGet200ResponseDataBuilder()..update(updates))._build();

  _$ApiShipmentsIdGet200ResponseData._({
    this.shipmentId,
    this.shipmentNumber,
    this.status,
    this.createdAt,
    this.acceptedAt,
    this.seller,
    this.totalProducts,
    this.totalQuantity,
    this.items,
  }) : super._();
  @override
  ApiShipmentsIdGet200ResponseData rebuild(
    void Function(ApiShipmentsIdGet200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiShipmentsIdGet200ResponseDataBuilder toBuilder() =>
      ApiShipmentsIdGet200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiShipmentsIdGet200ResponseData &&
        shipmentId == other.shipmentId &&
        shipmentNumber == other.shipmentNumber &&
        status == other.status &&
        createdAt == other.createdAt &&
        acceptedAt == other.acceptedAt &&
        seller == other.seller &&
        totalProducts == other.totalProducts &&
        totalQuantity == other.totalQuantity &&
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
    _$hash = $jc(_$hash, seller.hashCode);
    _$hash = $jc(_$hash, totalProducts.hashCode);
    _$hash = $jc(_$hash, totalQuantity.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiShipmentsIdGet200ResponseData')
          ..add('shipmentId', shipmentId)
          ..add('shipmentNumber', shipmentNumber)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('acceptedAt', acceptedAt)
          ..add('seller', seller)
          ..add('totalProducts', totalProducts)
          ..add('totalQuantity', totalQuantity)
          ..add('items', items))
        .toString();
  }
}

class ApiShipmentsIdGet200ResponseDataBuilder
    implements
        Builder<
          ApiShipmentsIdGet200ResponseData,
          ApiShipmentsIdGet200ResponseDataBuilder
        > {
  _$ApiShipmentsIdGet200ResponseData? _$v;

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

  ApiShipmentsIdGet200ResponseDataSellerBuilder? _seller;
  ApiShipmentsIdGet200ResponseDataSellerBuilder get seller =>
      _$this._seller ??= ApiShipmentsIdGet200ResponseDataSellerBuilder();
  set seller(ApiShipmentsIdGet200ResponseDataSellerBuilder? seller) =>
      _$this._seller = seller;

  int? _totalProducts;
  int? get totalProducts => _$this._totalProducts;
  set totalProducts(int? totalProducts) =>
      _$this._totalProducts = totalProducts;

  int? _totalQuantity;
  int? get totalQuantity => _$this._totalQuantity;
  set totalQuantity(int? totalQuantity) =>
      _$this._totalQuantity = totalQuantity;

  ListBuilder<ApiShipmentsIdGet200ResponseDataItemsInner>? _items;
  ListBuilder<ApiShipmentsIdGet200ResponseDataItemsInner> get items =>
      _$this._items ??=
          ListBuilder<ApiShipmentsIdGet200ResponseDataItemsInner>();
  set items(ListBuilder<ApiShipmentsIdGet200ResponseDataItemsInner>? items) =>
      _$this._items = items;

  ApiShipmentsIdGet200ResponseDataBuilder() {
    ApiShipmentsIdGet200ResponseData._defaults(this);
  }

  ApiShipmentsIdGet200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _shipmentId = $v.shipmentId;
      _shipmentNumber = $v.shipmentNumber;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _acceptedAt = $v.acceptedAt;
      _seller = $v.seller?.toBuilder();
      _totalProducts = $v.totalProducts;
      _totalQuantity = $v.totalQuantity;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiShipmentsIdGet200ResponseData other) {
    _$v = other as _$ApiShipmentsIdGet200ResponseData;
  }

  @override
  void update(void Function(ApiShipmentsIdGet200ResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiShipmentsIdGet200ResponseData build() => _build();

  _$ApiShipmentsIdGet200ResponseData _build() {
    _$ApiShipmentsIdGet200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ApiShipmentsIdGet200ResponseData._(
            shipmentId: shipmentId,
            shipmentNumber: shipmentNumber,
            status: status,
            createdAt: createdAt,
            acceptedAt: acceptedAt,
            seller: _seller?.build(),
            totalProducts: totalProducts,
            totalQuantity: totalQuantity,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'seller';
        _seller?.build();

        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApiShipmentsIdGet200ResponseData',
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
