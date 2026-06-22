// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_sales_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiSalesPostRequest extends ApiSalesPostRequest {
  @override
  final int? productId;
  @override
  final String? serialNumber;
  @override
  final String? customerName;
  @override
  final String? customerNumber;
  @override
  final String? vehicleNumber;
  @override
  final num? sellPrice;

  factory _$ApiSalesPostRequest([
    void Function(ApiSalesPostRequestBuilder)? updates,
  ]) => (ApiSalesPostRequestBuilder()..update(updates))._build();

  _$ApiSalesPostRequest._({
    this.productId,
    this.serialNumber,
    this.customerName,
    this.customerNumber,
    this.vehicleNumber,
    this.sellPrice,
  }) : super._();
  @override
  ApiSalesPostRequest rebuild(
    void Function(ApiSalesPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiSalesPostRequestBuilder toBuilder() =>
      ApiSalesPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiSalesPostRequest &&
        productId == other.productId &&
        serialNumber == other.serialNumber &&
        customerName == other.customerName &&
        customerNumber == other.customerNumber &&
        vehicleNumber == other.vehicleNumber &&
        sellPrice == other.sellPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, customerNumber.hashCode);
    _$hash = $jc(_$hash, vehicleNumber.hashCode);
    _$hash = $jc(_$hash, sellPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiSalesPostRequest')
          ..add('productId', productId)
          ..add('serialNumber', serialNumber)
          ..add('customerName', customerName)
          ..add('customerNumber', customerNumber)
          ..add('vehicleNumber', vehicleNumber)
          ..add('sellPrice', sellPrice))
        .toString();
  }
}

class ApiSalesPostRequestBuilder
    implements Builder<ApiSalesPostRequest, ApiSalesPostRequestBuilder> {
  _$ApiSalesPostRequest? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  String? _customerName;
  String? get customerName => _$this._customerName;
  set customerName(String? customerName) => _$this._customerName = customerName;

  String? _customerNumber;
  String? get customerNumber => _$this._customerNumber;
  set customerNumber(String? customerNumber) =>
      _$this._customerNumber = customerNumber;

  String? _vehicleNumber;
  String? get vehicleNumber => _$this._vehicleNumber;
  set vehicleNumber(String? vehicleNumber) =>
      _$this._vehicleNumber = vehicleNumber;

  num? _sellPrice;
  num? get sellPrice => _$this._sellPrice;
  set sellPrice(num? sellPrice) => _$this._sellPrice = sellPrice;

  ApiSalesPostRequestBuilder() {
    ApiSalesPostRequest._defaults(this);
  }

  ApiSalesPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _serialNumber = $v.serialNumber;
      _customerName = $v.customerName;
      _customerNumber = $v.customerNumber;
      _vehicleNumber = $v.vehicleNumber;
      _sellPrice = $v.sellPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiSalesPostRequest other) {
    _$v = other as _$ApiSalesPostRequest;
  }

  @override
  void update(void Function(ApiSalesPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiSalesPostRequest build() => _build();

  _$ApiSalesPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiSalesPostRequest._(
          productId: productId,
          serialNumber: serialNumber,
          customerName: customerName,
          customerNumber: customerNumber,
          vehicleNumber: vehicleNumber,
          sellPrice: sellPrice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
