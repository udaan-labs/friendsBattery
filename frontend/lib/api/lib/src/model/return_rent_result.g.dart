// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_rent_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReturnRentResult extends ReturnRentResult {
  @override
  final int? rentId;
  @override
  final String? serialNumber;
  @override
  final num? deposit;
  @override
  final num? rentFee;
  @override
  final num? refundAmount;
  @override
  final String? customerName;
  @override
  final String? customerNumber;

  factory _$ReturnRentResult([
    void Function(ReturnRentResultBuilder)? updates,
  ]) => (ReturnRentResultBuilder()..update(updates))._build();

  _$ReturnRentResult._({
    this.rentId,
    this.serialNumber,
    this.deposit,
    this.rentFee,
    this.refundAmount,
    this.customerName,
    this.customerNumber,
  }) : super._();
  @override
  ReturnRentResult rebuild(void Function(ReturnRentResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReturnRentResultBuilder toBuilder() =>
      ReturnRentResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReturnRentResult &&
        rentId == other.rentId &&
        serialNumber == other.serialNumber &&
        deposit == other.deposit &&
        rentFee == other.rentFee &&
        refundAmount == other.refundAmount &&
        customerName == other.customerName &&
        customerNumber == other.customerNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rentId.hashCode);
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, deposit.hashCode);
    _$hash = $jc(_$hash, rentFee.hashCode);
    _$hash = $jc(_$hash, refundAmount.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, customerNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReturnRentResult')
          ..add('rentId', rentId)
          ..add('serialNumber', serialNumber)
          ..add('deposit', deposit)
          ..add('rentFee', rentFee)
          ..add('refundAmount', refundAmount)
          ..add('customerName', customerName)
          ..add('customerNumber', customerNumber))
        .toString();
  }
}

class ReturnRentResultBuilder
    implements Builder<ReturnRentResult, ReturnRentResultBuilder> {
  _$ReturnRentResult? _$v;

  int? _rentId;
  int? get rentId => _$this._rentId;
  set rentId(int? rentId) => _$this._rentId = rentId;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  num? _deposit;
  num? get deposit => _$this._deposit;
  set deposit(num? deposit) => _$this._deposit = deposit;

  num? _rentFee;
  num? get rentFee => _$this._rentFee;
  set rentFee(num? rentFee) => _$this._rentFee = rentFee;

  num? _refundAmount;
  num? get refundAmount => _$this._refundAmount;
  set refundAmount(num? refundAmount) => _$this._refundAmount = refundAmount;

  String? _customerName;
  String? get customerName => _$this._customerName;
  set customerName(String? customerName) => _$this._customerName = customerName;

  String? _customerNumber;
  String? get customerNumber => _$this._customerNumber;
  set customerNumber(String? customerNumber) =>
      _$this._customerNumber = customerNumber;

  ReturnRentResultBuilder() {
    ReturnRentResult._defaults(this);
  }

  ReturnRentResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rentId = $v.rentId;
      _serialNumber = $v.serialNumber;
      _deposit = $v.deposit;
      _rentFee = $v.rentFee;
      _refundAmount = $v.refundAmount;
      _customerName = $v.customerName;
      _customerNumber = $v.customerNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReturnRentResult other) {
    _$v = other as _$ReturnRentResult;
  }

  @override
  void update(void Function(ReturnRentResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReturnRentResult build() => _build();

  _$ReturnRentResult _build() {
    final _$result =
        _$v ??
        _$ReturnRentResult._(
          rentId: rentId,
          serialNumber: serialNumber,
          deposit: deposit,
          rentFee: rentFee,
          refundAmount: refundAmount,
          customerName: customerName,
          customerNumber: customerNumber,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
