// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_product_unit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyProductUnit extends VerifyProductUnit {
  @override
  final String? serialNumber;
  @override
  final String? status;
  @override
  final String? qrCode;
  @override
  final DateTime? manufactureDate;
  @override
  final DateTime? warrantyExpiry;

  factory _$VerifyProductUnit([
    void Function(VerifyProductUnitBuilder)? updates,
  ]) => (VerifyProductUnitBuilder()..update(updates))._build();

  _$VerifyProductUnit._({
    this.serialNumber,
    this.status,
    this.qrCode,
    this.manufactureDate,
    this.warrantyExpiry,
  }) : super._();
  @override
  VerifyProductUnit rebuild(void Function(VerifyProductUnitBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyProductUnitBuilder toBuilder() =>
      VerifyProductUnitBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyProductUnit &&
        serialNumber == other.serialNumber &&
        status == other.status &&
        qrCode == other.qrCode &&
        manufactureDate == other.manufactureDate &&
        warrantyExpiry == other.warrantyExpiry;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, qrCode.hashCode);
    _$hash = $jc(_$hash, manufactureDate.hashCode);
    _$hash = $jc(_$hash, warrantyExpiry.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyProductUnit')
          ..add('serialNumber', serialNumber)
          ..add('status', status)
          ..add('qrCode', qrCode)
          ..add('manufactureDate', manufactureDate)
          ..add('warrantyExpiry', warrantyExpiry))
        .toString();
  }
}

class VerifyProductUnitBuilder
    implements Builder<VerifyProductUnit, VerifyProductUnitBuilder> {
  _$VerifyProductUnit? _$v;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _qrCode;
  String? get qrCode => _$this._qrCode;
  set qrCode(String? qrCode) => _$this._qrCode = qrCode;

  DateTime? _manufactureDate;
  DateTime? get manufactureDate => _$this._manufactureDate;
  set manufactureDate(DateTime? manufactureDate) =>
      _$this._manufactureDate = manufactureDate;

  DateTime? _warrantyExpiry;
  DateTime? get warrantyExpiry => _$this._warrantyExpiry;
  set warrantyExpiry(DateTime? warrantyExpiry) =>
      _$this._warrantyExpiry = warrantyExpiry;

  VerifyProductUnitBuilder() {
    VerifyProductUnit._defaults(this);
  }

  VerifyProductUnitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _serialNumber = $v.serialNumber;
      _status = $v.status;
      _qrCode = $v.qrCode;
      _manufactureDate = $v.manufactureDate;
      _warrantyExpiry = $v.warrantyExpiry;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyProductUnit other) {
    _$v = other as _$VerifyProductUnit;
  }

  @override
  void update(void Function(VerifyProductUnitBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyProductUnit build() => _build();

  _$VerifyProductUnit _build() {
    final _$result =
        _$v ??
        _$VerifyProductUnit._(
          serialNumber: serialNumber,
          status: status,
          qrCode: qrCode,
          manufactureDate: manufactureDate,
          warrantyExpiry: warrantyExpiry,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
