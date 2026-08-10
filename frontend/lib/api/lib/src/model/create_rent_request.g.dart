// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_rent_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateRentRequest extends CreateRentRequest {
  @override
  final String serialNumber;
  @override
  final String customerName;
  @override
  final String customerNumber;
  @override
  final num deposit;

  factory _$CreateRentRequest([
    void Function(CreateRentRequestBuilder)? updates,
  ]) => (CreateRentRequestBuilder()..update(updates))._build();

  _$CreateRentRequest._({
    required this.serialNumber,
    required this.customerName,
    required this.customerNumber,
    required this.deposit,
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
        deposit == other.deposit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, customerNumber.hashCode);
    _$hash = $jc(_$hash, deposit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateRentRequest')
          ..add('serialNumber', serialNumber)
          ..add('customerName', customerName)
          ..add('customerNumber', customerNumber)
          ..add('deposit', deposit))
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
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
