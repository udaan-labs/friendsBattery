// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_sale_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateSaleRequest extends CreateSaleRequest {
  @override
  final int productNameId;
  @override
  final int productModelId;
  @override
  final String serialNumber;
  @override
  final String customerName;
  @override
  final String customerNumber;
  @override
  final String? vehicleNumber;
  @override
  final num sellPrice;

  factory _$CreateSaleRequest([
    void Function(CreateSaleRequestBuilder)? updates,
  ]) => (CreateSaleRequestBuilder()..update(updates))._build();

  _$CreateSaleRequest._({
    required this.productNameId,
    required this.productModelId,
    required this.serialNumber,
    required this.customerName,
    required this.customerNumber,
    this.vehicleNumber,
    required this.sellPrice,
  }) : super._();
  @override
  CreateSaleRequest rebuild(void Function(CreateSaleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateSaleRequestBuilder toBuilder() =>
      CreateSaleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSaleRequest &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        serialNumber == other.serialNumber &&
        customerName == other.customerName &&
        customerNumber == other.customerNumber &&
        vehicleNumber == other.vehicleNumber &&
        sellPrice == other.sellPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
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
    return (newBuiltValueToStringHelper(r'CreateSaleRequest')
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('serialNumber', serialNumber)
          ..add('customerName', customerName)
          ..add('customerNumber', customerNumber)
          ..add('vehicleNumber', vehicleNumber)
          ..add('sellPrice', sellPrice))
        .toString();
  }
}

class CreateSaleRequestBuilder
    implements Builder<CreateSaleRequest, CreateSaleRequestBuilder> {
  _$CreateSaleRequest? _$v;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

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

  CreateSaleRequestBuilder() {
    CreateSaleRequest._defaults(this);
  }

  CreateSaleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
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
  void replace(CreateSaleRequest other) {
    _$v = other as _$CreateSaleRequest;
  }

  @override
  void update(void Function(CreateSaleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSaleRequest build() => _build();

  _$CreateSaleRequest _build() {
    final _$result =
        _$v ??
        _$CreateSaleRequest._(
          productNameId: BuiltValueNullFieldError.checkNotNull(
            productNameId,
            r'CreateSaleRequest',
            'productNameId',
          ),
          productModelId: BuiltValueNullFieldError.checkNotNull(
            productModelId,
            r'CreateSaleRequest',
            'productModelId',
          ),
          serialNumber: BuiltValueNullFieldError.checkNotNull(
            serialNumber,
            r'CreateSaleRequest',
            'serialNumber',
          ),
          customerName: BuiltValueNullFieldError.checkNotNull(
            customerName,
            r'CreateSaleRequest',
            'customerName',
          ),
          customerNumber: BuiltValueNullFieldError.checkNotNull(
            customerNumber,
            r'CreateSaleRequest',
            'customerNumber',
          ),
          vehicleNumber: vehicleNumber,
          sellPrice: BuiltValueNullFieldError.checkNotNull(
            sellPrice,
            r'CreateSaleRequest',
            'sellPrice',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
