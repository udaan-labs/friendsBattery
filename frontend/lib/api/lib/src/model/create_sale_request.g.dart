// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_sale_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateSaleRequestSaleTypeEnum _$createSaleRequestSaleTypeEnum_NORMAL =
    const CreateSaleRequestSaleTypeEnum._('NORMAL');
const CreateSaleRequestSaleTypeEnum _$createSaleRequestSaleTypeEnum_SCRAP =
    const CreateSaleRequestSaleTypeEnum._('SCRAP');
const CreateSaleRequestSaleTypeEnum _$createSaleRequestSaleTypeEnum_MECHANIC =
    const CreateSaleRequestSaleTypeEnum._('MECHANIC');

CreateSaleRequestSaleTypeEnum _$createSaleRequestSaleTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'NORMAL':
      return _$createSaleRequestSaleTypeEnum_NORMAL;
    case 'SCRAP':
      return _$createSaleRequestSaleTypeEnum_SCRAP;
    case 'MECHANIC':
      return _$createSaleRequestSaleTypeEnum_MECHANIC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateSaleRequestSaleTypeEnum>
_$createSaleRequestSaleTypeEnumValues = BuiltSet<CreateSaleRequestSaleTypeEnum>(
  const <CreateSaleRequestSaleTypeEnum>[
    _$createSaleRequestSaleTypeEnum_NORMAL,
    _$createSaleRequestSaleTypeEnum_SCRAP,
    _$createSaleRequestSaleTypeEnum_MECHANIC,
  ],
);

const CreateSaleRequestPaymentModeEnum _$createSaleRequestPaymentModeEnum_CASH =
    const CreateSaleRequestPaymentModeEnum._('CASH');
const CreateSaleRequestPaymentModeEnum
_$createSaleRequestPaymentModeEnum_ONLINE =
    const CreateSaleRequestPaymentModeEnum._('ONLINE');
const CreateSaleRequestPaymentModeEnum
_$createSaleRequestPaymentModeEnum_CREDIT =
    const CreateSaleRequestPaymentModeEnum._('CREDIT');

CreateSaleRequestPaymentModeEnum _$createSaleRequestPaymentModeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'CASH':
      return _$createSaleRequestPaymentModeEnum_CASH;
    case 'ONLINE':
      return _$createSaleRequestPaymentModeEnum_ONLINE;
    case 'CREDIT':
      return _$createSaleRequestPaymentModeEnum_CREDIT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateSaleRequestPaymentModeEnum>
_$createSaleRequestPaymentModeEnumValues =
    BuiltSet<CreateSaleRequestPaymentModeEnum>(
      const <CreateSaleRequestPaymentModeEnum>[
        _$createSaleRequestPaymentModeEnum_CASH,
        _$createSaleRequestPaymentModeEnum_ONLINE,
        _$createSaleRequestPaymentModeEnum_CREDIT,
      ],
    );

Serializer<CreateSaleRequestSaleTypeEnum>
_$createSaleRequestSaleTypeEnumSerializer =
    _$CreateSaleRequestSaleTypeEnumSerializer();
Serializer<CreateSaleRequestPaymentModeEnum>
_$createSaleRequestPaymentModeEnumSerializer =
    _$CreateSaleRequestPaymentModeEnumSerializer();

class _$CreateSaleRequestSaleTypeEnumSerializer
    implements PrimitiveSerializer<CreateSaleRequestSaleTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'NORMAL': 'NORMAL',
    'SCRAP': 'SCRAP',
    'MECHANIC': 'MECHANIC',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'NORMAL': 'NORMAL',
    'SCRAP': 'SCRAP',
    'MECHANIC': 'MECHANIC',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateSaleRequestSaleTypeEnum];
  @override
  final String wireName = 'CreateSaleRequestSaleTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateSaleRequestSaleTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateSaleRequestSaleTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateSaleRequestSaleTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateSaleRequestPaymentModeEnumSerializer
    implements PrimitiveSerializer<CreateSaleRequestPaymentModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CASH': 'CASH',
    'ONLINE': 'ONLINE',
    'CREDIT': 'CREDIT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CASH': 'CASH',
    'ONLINE': 'ONLINE',
    'CREDIT': 'CREDIT',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateSaleRequestPaymentModeEnum];
  @override
  final String wireName = 'CreateSaleRequestPaymentModeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateSaleRequestPaymentModeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateSaleRequestPaymentModeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateSaleRequestPaymentModeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

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
  @override
  final CreateSaleRequestSaleTypeEnum? saleType;
  @override
  final String? scrapSerial;
  @override
  final CreateSaleRequestPaymentModeEnum? paymentMode;
  @override
  final num? amountPaid;

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
    this.saleType,
    this.scrapSerial,
    this.paymentMode,
    this.amountPaid,
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
        sellPrice == other.sellPrice &&
        saleType == other.saleType &&
        scrapSerial == other.scrapSerial &&
        paymentMode == other.paymentMode &&
        amountPaid == other.amountPaid;
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
    _$hash = $jc(_$hash, saleType.hashCode);
    _$hash = $jc(_$hash, scrapSerial.hashCode);
    _$hash = $jc(_$hash, paymentMode.hashCode);
    _$hash = $jc(_$hash, amountPaid.hashCode);
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
          ..add('sellPrice', sellPrice)
          ..add('saleType', saleType)
          ..add('scrapSerial', scrapSerial)
          ..add('paymentMode', paymentMode)
          ..add('amountPaid', amountPaid))
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

  CreateSaleRequestSaleTypeEnum? _saleType;
  CreateSaleRequestSaleTypeEnum? get saleType => _$this._saleType;
  set saleType(CreateSaleRequestSaleTypeEnum? saleType) =>
      _$this._saleType = saleType;

  String? _scrapSerial;
  String? get scrapSerial => _$this._scrapSerial;
  set scrapSerial(String? scrapSerial) => _$this._scrapSerial = scrapSerial;

  CreateSaleRequestPaymentModeEnum? _paymentMode;
  CreateSaleRequestPaymentModeEnum? get paymentMode => _$this._paymentMode;
  set paymentMode(CreateSaleRequestPaymentModeEnum? paymentMode) =>
      _$this._paymentMode = paymentMode;

  num? _amountPaid;
  num? get amountPaid => _$this._amountPaid;
  set amountPaid(num? amountPaid) => _$this._amountPaid = amountPaid;

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
      _saleType = $v.saleType;
      _scrapSerial = $v.scrapSerial;
      _paymentMode = $v.paymentMode;
      _amountPaid = $v.amountPaid;
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
          saleType: saleType,
          scrapSerial: scrapSerial,
          paymentMode: paymentMode,
          amountPaid: amountPaid,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
