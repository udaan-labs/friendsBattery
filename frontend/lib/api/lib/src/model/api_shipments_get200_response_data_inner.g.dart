// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_shipments_get200_response_data_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiShipmentsGet200ResponseDataInner
    extends ApiShipmentsGet200ResponseDataInner {
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
  final ApiShipmentsGet200ResponseDataInnerSeller? seller;
  @override
  final int? totalProducts;
  @override
  final int? totalQuantity;

  factory _$ApiShipmentsGet200ResponseDataInner([
    void Function(ApiShipmentsGet200ResponseDataInnerBuilder)? updates,
  ]) =>
      (ApiShipmentsGet200ResponseDataInnerBuilder()..update(updates))._build();

  _$ApiShipmentsGet200ResponseDataInner._({
    this.shipmentId,
    this.shipmentNumber,
    this.status,
    this.createdAt,
    this.acceptedAt,
    this.seller,
    this.totalProducts,
    this.totalQuantity,
  }) : super._();
  @override
  ApiShipmentsGet200ResponseDataInner rebuild(
    void Function(ApiShipmentsGet200ResponseDataInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiShipmentsGet200ResponseDataInnerBuilder toBuilder() =>
      ApiShipmentsGet200ResponseDataInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiShipmentsGet200ResponseDataInner &&
        shipmentId == other.shipmentId &&
        shipmentNumber == other.shipmentNumber &&
        status == other.status &&
        createdAt == other.createdAt &&
        acceptedAt == other.acceptedAt &&
        seller == other.seller &&
        totalProducts == other.totalProducts &&
        totalQuantity == other.totalQuantity;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiShipmentsGet200ResponseDataInner')
          ..add('shipmentId', shipmentId)
          ..add('shipmentNumber', shipmentNumber)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('acceptedAt', acceptedAt)
          ..add('seller', seller)
          ..add('totalProducts', totalProducts)
          ..add('totalQuantity', totalQuantity))
        .toString();
  }
}

class ApiShipmentsGet200ResponseDataInnerBuilder
    implements
        Builder<
          ApiShipmentsGet200ResponseDataInner,
          ApiShipmentsGet200ResponseDataInnerBuilder
        > {
  _$ApiShipmentsGet200ResponseDataInner? _$v;

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

  ApiShipmentsGet200ResponseDataInnerSellerBuilder? _seller;
  ApiShipmentsGet200ResponseDataInnerSellerBuilder get seller =>
      _$this._seller ??= ApiShipmentsGet200ResponseDataInnerSellerBuilder();
  set seller(ApiShipmentsGet200ResponseDataInnerSellerBuilder? seller) =>
      _$this._seller = seller;

  int? _totalProducts;
  int? get totalProducts => _$this._totalProducts;
  set totalProducts(int? totalProducts) =>
      _$this._totalProducts = totalProducts;

  int? _totalQuantity;
  int? get totalQuantity => _$this._totalQuantity;
  set totalQuantity(int? totalQuantity) =>
      _$this._totalQuantity = totalQuantity;

  ApiShipmentsGet200ResponseDataInnerBuilder() {
    ApiShipmentsGet200ResponseDataInner._defaults(this);
  }

  ApiShipmentsGet200ResponseDataInnerBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiShipmentsGet200ResponseDataInner other) {
    _$v = other as _$ApiShipmentsGet200ResponseDataInner;
  }

  @override
  void update(
    void Function(ApiShipmentsGet200ResponseDataInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiShipmentsGet200ResponseDataInner build() => _build();

  _$ApiShipmentsGet200ResponseDataInner _build() {
    _$ApiShipmentsGet200ResponseDataInner _$result;
    try {
      _$result =
          _$v ??
          _$ApiShipmentsGet200ResponseDataInner._(
            shipmentId: shipmentId,
            shipmentNumber: shipmentNumber,
            status: status,
            createdAt: createdAt,
            acceptedAt: acceptedAt,
            seller: _seller?.build(),
            totalProducts: totalProducts,
            totalQuantity: totalQuantity,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'seller';
        _seller?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApiShipmentsGet200ResponseDataInner',
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
