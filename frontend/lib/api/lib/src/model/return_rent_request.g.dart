// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_rent_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReturnRentRequest extends ReturnRentRequest {
  @override
  final String serialNumber;
  @override
  final num rentFee;

  factory _$ReturnRentRequest([
    void Function(ReturnRentRequestBuilder)? updates,
  ]) => (ReturnRentRequestBuilder()..update(updates))._build();

  _$ReturnRentRequest._({required this.serialNumber, required this.rentFee})
    : super._();
  @override
  ReturnRentRequest rebuild(void Function(ReturnRentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReturnRentRequestBuilder toBuilder() =>
      ReturnRentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReturnRentRequest &&
        serialNumber == other.serialNumber &&
        rentFee == other.rentFee;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, rentFee.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReturnRentRequest')
          ..add('serialNumber', serialNumber)
          ..add('rentFee', rentFee))
        .toString();
  }
}

class ReturnRentRequestBuilder
    implements Builder<ReturnRentRequest, ReturnRentRequestBuilder> {
  _$ReturnRentRequest? _$v;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  num? _rentFee;
  num? get rentFee => _$this._rentFee;
  set rentFee(num? rentFee) => _$this._rentFee = rentFee;

  ReturnRentRequestBuilder() {
    ReturnRentRequest._defaults(this);
  }

  ReturnRentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _serialNumber = $v.serialNumber;
      _rentFee = $v.rentFee;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReturnRentRequest other) {
    _$v = other as _$ReturnRentRequest;
  }

  @override
  void update(void Function(ReturnRentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReturnRentRequest build() => _build();

  _$ReturnRentRequest _build() {
    final _$result =
        _$v ??
        _$ReturnRentRequest._(
          serialNumber: BuiltValueNullFieldError.checkNotNull(
            serialNumber,
            r'ReturnRentRequest',
            'serialNumber',
          ),
          rentFee: BuiltValueNullFieldError.checkNotNull(
            rentFee,
            r'ReturnRentRequest',
            'rentFee',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
