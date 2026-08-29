// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_rent_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateRentRequestPaymentModeEnum _$createRentRequestPaymentModeEnum_CASH =
    const CreateRentRequestPaymentModeEnum._('CASH');
const CreateRentRequestPaymentModeEnum
_$createRentRequestPaymentModeEnum_ONLINE =
    const CreateRentRequestPaymentModeEnum._('ONLINE');
const CreateRentRequestPaymentModeEnum
_$createRentRequestPaymentModeEnum_CREDIT =
    const CreateRentRequestPaymentModeEnum._('CREDIT');

CreateRentRequestPaymentModeEnum _$createRentRequestPaymentModeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'CASH':
      return _$createRentRequestPaymentModeEnum_CASH;
    case 'ONLINE':
      return _$createRentRequestPaymentModeEnum_ONLINE;
    case 'CREDIT':
      return _$createRentRequestPaymentModeEnum_CREDIT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateRentRequestPaymentModeEnum>
_$createRentRequestPaymentModeEnumValues =
    BuiltSet<CreateRentRequestPaymentModeEnum>(
      const <CreateRentRequestPaymentModeEnum>[
        _$createRentRequestPaymentModeEnum_CASH,
        _$createRentRequestPaymentModeEnum_ONLINE,
        _$createRentRequestPaymentModeEnum_CREDIT,
      ],
    );

Serializer<CreateRentRequestPaymentModeEnum>
_$createRentRequestPaymentModeEnumSerializer =
    _$CreateRentRequestPaymentModeEnumSerializer();

class _$CreateRentRequestPaymentModeEnumSerializer
    implements PrimitiveSerializer<CreateRentRequestPaymentModeEnum> {
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
  final Iterable<Type> types = const <Type>[CreateRentRequestPaymentModeEnum];
  @override
  final String wireName = 'CreateRentRequestPaymentModeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateRentRequestPaymentModeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateRentRequestPaymentModeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateRentRequestPaymentModeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateRentRequest extends CreateRentRequest {
  @override
  final String serialNumber;
  @override
  final String customerName;
  @override
  final String customerNumber;
  @override
  final num deposit;
  @override
  final CreateRentRequestPaymentModeEnum? paymentMode;

  factory _$CreateRentRequest([
    void Function(CreateRentRequestBuilder)? updates,
  ]) => (CreateRentRequestBuilder()..update(updates))._build();

  _$CreateRentRequest._({
    required this.serialNumber,
    required this.customerName,
    required this.customerNumber,
    required this.deposit,
    this.paymentMode,
  }) : super._();
  @override
  CreateRentRequest rebuild(void Function(CreateRentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateRentRequestBuilder toBuilder() =>
      CreateRentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRentRequest &&
        serialNumber == other.serialNumber &&
        customerName == other.customerName &&
        customerNumber == other.customerNumber &&
        deposit == other.deposit &&
        paymentMode == other.paymentMode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, customerNumber.hashCode);
    _$hash = $jc(_$hash, deposit.hashCode);
    _$hash = $jc(_$hash, paymentMode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateRentRequest')
          ..add('serialNumber', serialNumber)
          ..add('customerName', customerName)
          ..add('customerNumber', customerNumber)
          ..add('deposit', deposit)
          ..add('paymentMode', paymentMode))
        .toString();
  }
}

class CreateRentRequestBuilder
    implements Builder<CreateRentRequest, CreateRentRequestBuilder> {
  _$CreateRentRequest? _$v;

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

  num? _deposit;
  num? get deposit => _$this._deposit;
  set deposit(num? deposit) => _$this._deposit = deposit;

  CreateRentRequestPaymentModeEnum? _paymentMode;
  CreateRentRequestPaymentModeEnum? get paymentMode => _$this._paymentMode;
  set paymentMode(CreateRentRequestPaymentModeEnum? paymentMode) =>
      _$this._paymentMode = paymentMode;

  CreateRentRequestBuilder() {
    CreateRentRequest._defaults(this);
  }

  CreateRentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _serialNumber = $v.serialNumber;
      _customerName = $v.customerName;
      _customerNumber = $v.customerNumber;
      _deposit = $v.deposit;
      _paymentMode = $v.paymentMode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateRentRequest other) {
    _$v = other as _$CreateRentRequest;
  }

  @override
  void update(void Function(CreateRentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRentRequest build() => _build();

  _$CreateRentRequest _build() {
    final _$result =
        _$v ??
        _$CreateRentRequest._(
          serialNumber: BuiltValueNullFieldError.checkNotNull(
            serialNumber,
            r'CreateRentRequest',
            'serialNumber',
          ),
          customerName: BuiltValueNullFieldError.checkNotNull(
            customerName,
            r'CreateRentRequest',
            'customerName',
          ),
          customerNumber: BuiltValueNullFieldError.checkNotNull(
            customerNumber,
            r'CreateRentRequest',
            'customerNumber',
          ),
          deposit: BuiltValueNullFieldError.checkNotNull(
            deposit,
            r'CreateRentRequest',
            'deposit',
          ),
          paymentMode: paymentMode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
