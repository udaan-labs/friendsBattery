// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_credit_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PayCreditRequest extends PayCreditRequest {
  @override
  final num amount;

  factory _$PayCreditRequest([
    void Function(PayCreditRequestBuilder)? updates,
  ]) => (PayCreditRequestBuilder()..update(updates))._build();

  _$PayCreditRequest._({required this.amount}) : super._();
  @override
  PayCreditRequest rebuild(void Function(PayCreditRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PayCreditRequestBuilder toBuilder() =>
      PayCreditRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayCreditRequest && amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'PayCreditRequest',
    )..add('amount', amount)).toString();
  }
}

class PayCreditRequestBuilder
    implements Builder<PayCreditRequest, PayCreditRequestBuilder> {
  _$PayCreditRequest? _$v;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  PayCreditRequestBuilder() {
    PayCreditRequest._defaults(this);
  }

  PayCreditRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayCreditRequest other) {
    _$v = other as _$PayCreditRequest;
  }

  @override
  void update(void Function(PayCreditRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PayCreditRequest build() => _build();

  _$PayCreditRequest _build() {
    final _$result =
        _$v ??
        _$PayCreditRequest._(
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'PayCreditRequest',
            'amount',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
