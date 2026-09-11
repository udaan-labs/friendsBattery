// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_service_bill_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateServiceBillRequestServiceTypeEnum
_$createServiceBillRequestServiceTypeEnum_BATTERY_CHECK_2W =
    const CreateServiceBillRequestServiceTypeEnum._('BATTERY_CHECK_2W');
const CreateServiceBillRequestServiceTypeEnum
_$createServiceBillRequestServiceTypeEnum_BATTERY_CHECK_4W =
    const CreateServiceBillRequestServiceTypeEnum._('BATTERY_CHECK_4W');
const CreateServiceBillRequestServiceTypeEnum
_$createServiceBillRequestServiceTypeEnum_BATTERY_CHARGING =
    const CreateServiceBillRequestServiceTypeEnum._('BATTERY_CHARGING');
const CreateServiceBillRequestServiceTypeEnum
_$createServiceBillRequestServiceTypeEnum_JUMPSTART =
    const CreateServiceBillRequestServiceTypeEnum._('JUMPSTART');
const CreateServiceBillRequestServiceTypeEnum
_$createServiceBillRequestServiceTypeEnum_INVERTER_SERVICE =
    const CreateServiceBillRequestServiceTypeEnum._('INVERTER_SERVICE');

CreateServiceBillRequestServiceTypeEnum
_$createServiceBillRequestServiceTypeEnumValueOf(String name) {
  switch (name) {
    case 'BATTERY_CHECK_2W':
      return _$createServiceBillRequestServiceTypeEnum_BATTERY_CHECK_2W;
    case 'BATTERY_CHECK_4W':
      return _$createServiceBillRequestServiceTypeEnum_BATTERY_CHECK_4W;
    case 'BATTERY_CHARGING':
      return _$createServiceBillRequestServiceTypeEnum_BATTERY_CHARGING;
    case 'JUMPSTART':
      return _$createServiceBillRequestServiceTypeEnum_JUMPSTART;
    case 'INVERTER_SERVICE':
      return _$createServiceBillRequestServiceTypeEnum_INVERTER_SERVICE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateServiceBillRequestServiceTypeEnum>
_$createServiceBillRequestServiceTypeEnumValues =
    BuiltSet<CreateServiceBillRequestServiceTypeEnum>(
      const <CreateServiceBillRequestServiceTypeEnum>[
        _$createServiceBillRequestServiceTypeEnum_BATTERY_CHECK_2W,
        _$createServiceBillRequestServiceTypeEnum_BATTERY_CHECK_4W,
        _$createServiceBillRequestServiceTypeEnum_BATTERY_CHARGING,
        _$createServiceBillRequestServiceTypeEnum_JUMPSTART,
        _$createServiceBillRequestServiceTypeEnum_INVERTER_SERVICE,
      ],
    );

const CreateServiceBillRequestPaymentModeEnum
_$createServiceBillRequestPaymentModeEnum_CASH =
    const CreateServiceBillRequestPaymentModeEnum._('CASH');
const CreateServiceBillRequestPaymentModeEnum
_$createServiceBillRequestPaymentModeEnum_ONLINE =
    const CreateServiceBillRequestPaymentModeEnum._('ONLINE');
const CreateServiceBillRequestPaymentModeEnum
_$createServiceBillRequestPaymentModeEnum_CREDIT =
    const CreateServiceBillRequestPaymentModeEnum._('CREDIT');

CreateServiceBillRequestPaymentModeEnum
_$createServiceBillRequestPaymentModeEnumValueOf(String name) {
  switch (name) {
    case 'CASH':
      return _$createServiceBillRequestPaymentModeEnum_CASH;
    case 'ONLINE':
      return _$createServiceBillRequestPaymentModeEnum_ONLINE;
    case 'CREDIT':
      return _$createServiceBillRequestPaymentModeEnum_CREDIT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateServiceBillRequestPaymentModeEnum>
_$createServiceBillRequestPaymentModeEnumValues =
    BuiltSet<CreateServiceBillRequestPaymentModeEnum>(
      const <CreateServiceBillRequestPaymentModeEnum>[
        _$createServiceBillRequestPaymentModeEnum_CASH,
        _$createServiceBillRequestPaymentModeEnum_ONLINE,
        _$createServiceBillRequestPaymentModeEnum_CREDIT,
      ],
    );

Serializer<CreateServiceBillRequestServiceTypeEnum>
_$createServiceBillRequestServiceTypeEnumSerializer =
    _$CreateServiceBillRequestServiceTypeEnumSerializer();
Serializer<CreateServiceBillRequestPaymentModeEnum>
_$createServiceBillRequestPaymentModeEnumSerializer =
    _$CreateServiceBillRequestPaymentModeEnumSerializer();

class _$CreateServiceBillRequestServiceTypeEnumSerializer
    implements PrimitiveSerializer<CreateServiceBillRequestServiceTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BATTERY_CHECK_2W': 'BATTERY_CHECK_2W',
    'BATTERY_CHECK_4W': 'BATTERY_CHECK_4W',
    'BATTERY_CHARGING': 'BATTERY_CHARGING',
    'JUMPSTART': 'JUMPSTART',
    'INVERTER_SERVICE': 'INVERTER_SERVICE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BATTERY_CHECK_2W': 'BATTERY_CHECK_2W',
    'BATTERY_CHECK_4W': 'BATTERY_CHECK_4W',
    'BATTERY_CHARGING': 'BATTERY_CHARGING',
    'JUMPSTART': 'JUMPSTART',
    'INVERTER_SERVICE': 'INVERTER_SERVICE',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CreateServiceBillRequestServiceTypeEnum,
  ];
  @override
  final String wireName = 'CreateServiceBillRequestServiceTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateServiceBillRequestServiceTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateServiceBillRequestServiceTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateServiceBillRequestServiceTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateServiceBillRequestPaymentModeEnumSerializer
    implements PrimitiveSerializer<CreateServiceBillRequestPaymentModeEnum> {
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
  final Iterable<Type> types = const <Type>[
    CreateServiceBillRequestPaymentModeEnum,
  ];
  @override
  final String wireName = 'CreateServiceBillRequestPaymentModeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateServiceBillRequestPaymentModeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateServiceBillRequestPaymentModeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateServiceBillRequestPaymentModeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateServiceBillRequest extends CreateServiceBillRequest {
  @override
  final CreateServiceBillRequestServiceTypeEnum serviceType;
  @override
  final num amount;
  @override
  final String customerName;
  @override
  final String customerNumber;
  @override
  final String? vehicleNumber;
  @override
  final String? place;
  @override
  final CreateServiceBillRequestPaymentModeEnum? paymentMode;

  factory _$CreateServiceBillRequest([
    void Function(CreateServiceBillRequestBuilder)? updates,
  ]) => (CreateServiceBillRequestBuilder()..update(updates))._build();

  _$CreateServiceBillRequest._({
    required this.serviceType,
    required this.amount,
    required this.customerName,
    required this.customerNumber,
    this.vehicleNumber,
    this.place,
    this.paymentMode,
  }) : super._();
  @override
  CreateServiceBillRequest rebuild(
    void Function(CreateServiceBillRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateServiceBillRequestBuilder toBuilder() =>
      CreateServiceBillRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateServiceBillRequest &&
        serviceType == other.serviceType &&
        amount == other.amount &&
        customerName == other.customerName &&
        customerNumber == other.customerNumber &&
        vehicleNumber == other.vehicleNumber &&
        place == other.place &&
        paymentMode == other.paymentMode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, serviceType.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, customerNumber.hashCode);
    _$hash = $jc(_$hash, vehicleNumber.hashCode);
    _$hash = $jc(_$hash, place.hashCode);
    _$hash = $jc(_$hash, paymentMode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateServiceBillRequest')
          ..add('serviceType', serviceType)
          ..add('amount', amount)
          ..add('customerName', customerName)
          ..add('customerNumber', customerNumber)
          ..add('vehicleNumber', vehicleNumber)
          ..add('place', place)
          ..add('paymentMode', paymentMode))
        .toString();
  }
}

class CreateServiceBillRequestBuilder
    implements
        Builder<CreateServiceBillRequest, CreateServiceBillRequestBuilder> {
  _$CreateServiceBillRequest? _$v;

  CreateServiceBillRequestServiceTypeEnum? _serviceType;
  CreateServiceBillRequestServiceTypeEnum? get serviceType =>
      _$this._serviceType;
  set serviceType(CreateServiceBillRequestServiceTypeEnum? serviceType) =>
      _$this._serviceType = serviceType;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

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

  String? _place;
  String? get place => _$this._place;
  set place(String? place) => _$this._place = place;

  CreateServiceBillRequestPaymentModeEnum? _paymentMode;
  CreateServiceBillRequestPaymentModeEnum? get paymentMode =>
      _$this._paymentMode;
  set paymentMode(CreateServiceBillRequestPaymentModeEnum? paymentMode) =>
      _$this._paymentMode = paymentMode;

  CreateServiceBillRequestBuilder() {
    CreateServiceBillRequest._defaults(this);
  }

  CreateServiceBillRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _serviceType = $v.serviceType;
      _amount = $v.amount;
      _customerName = $v.customerName;
      _customerNumber = $v.customerNumber;
      _vehicleNumber = $v.vehicleNumber;
      _place = $v.place;
      _paymentMode = $v.paymentMode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateServiceBillRequest other) {
    _$v = other as _$CreateServiceBillRequest;
  }

  @override
  void update(void Function(CreateServiceBillRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateServiceBillRequest build() => _build();

  _$CreateServiceBillRequest _build() {
    final _$result =
        _$v ??
        _$CreateServiceBillRequest._(
          serviceType: BuiltValueNullFieldError.checkNotNull(
            serviceType,
            r'CreateServiceBillRequest',
            'serviceType',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'CreateServiceBillRequest',
            'amount',
          ),
          customerName: BuiltValueNullFieldError.checkNotNull(
            customerName,
            r'CreateServiceBillRequest',
            'customerName',
          ),
          customerNumber: BuiltValueNullFieldError.checkNotNull(
            customerNumber,
            r'CreateServiceBillRequest',
            'customerNumber',
          ),
          vehicleNumber: vehicleNumber,
          place: place,
          paymentMode: paymentMode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
