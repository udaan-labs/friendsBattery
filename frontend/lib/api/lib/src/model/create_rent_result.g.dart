// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_rent_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateRentResult extends CreateRentResult {
  @override
  final int? rentId;
  @override
  final String? serialNumber;
  @override
  final num? deposit;

  factory _$CreateRentResult([
    void Function(CreateRentResultBuilder)? updates,
  ]) => (CreateRentResultBuilder()..update(updates))._build();

  _$CreateRentResult._({this.rentId, this.serialNumber, this.deposit})
    : super._();
  @override
  CreateRentResult rebuild(void Function(CreateRentResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateRentResultBuilder toBuilder() =>
      CreateRentResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRentResult &&
        rentId == other.rentId &&
        serialNumber == other.serialNumber &&
        deposit == other.deposit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rentId.hashCode);
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, deposit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateRentResult')
          ..add('rentId', rentId)
          ..add('serialNumber', serialNumber)
          ..add('deposit', deposit))
        .toString();
  }
}

class CreateRentResultBuilder
    implements Builder<CreateRentResult, CreateRentResultBuilder> {
  _$CreateRentResult? _$v;

  int? _rentId;
  int? get rentId => _$this._rentId;
  set rentId(int? rentId) => _$this._rentId = rentId;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  num? _deposit;
  num? get deposit => _$this._deposit;
  set deposit(num? deposit) => _$this._deposit = deposit;

  CreateRentResultBuilder() {
    CreateRentResult._defaults(this);
  }

  CreateRentResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rentId = $v.rentId;
      _serialNumber = $v.serialNumber;
      _deposit = $v.deposit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateRentResult other) {
    _$v = other as _$CreateRentResult;
  }

  @override
  void update(void Function(CreateRentResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRentResult build() => _build();

  _$CreateRentResult _build() {
    final _$result =
        _$v ??
        _$CreateRentResult._(
          rentId: rentId,
          serialNumber: serialNumber,
          deposit: deposit,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
