// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OtpVerifyData extends OtpVerifyData {
  @override
  final String? purpose;
  @override
  final bool? verified;

  factory _$OtpVerifyData([void Function(OtpVerifyDataBuilder)? updates]) =>
      (OtpVerifyDataBuilder()..update(updates))._build();

  _$OtpVerifyData._({this.purpose, this.verified}) : super._();
  @override
  OtpVerifyData rebuild(void Function(OtpVerifyDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OtpVerifyDataBuilder toBuilder() => OtpVerifyDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OtpVerifyData &&
        purpose == other.purpose &&
        verified == other.verified;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jc(_$hash, verified.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OtpVerifyData')
          ..add('purpose', purpose)
          ..add('verified', verified))
        .toString();
  }
}

class OtpVerifyDataBuilder
    implements Builder<OtpVerifyData, OtpVerifyDataBuilder> {
  _$OtpVerifyData? _$v;

  String? _purpose;
  String? get purpose => _$this._purpose;
  set purpose(String? purpose) => _$this._purpose = purpose;

  bool? _verified;
  bool? get verified => _$this._verified;
  set verified(bool? verified) => _$this._verified = verified;

  OtpVerifyDataBuilder() {
    OtpVerifyData._defaults(this);
  }

  OtpVerifyDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _purpose = $v.purpose;
      _verified = $v.verified;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OtpVerifyData other) {
    _$v = other as _$OtpVerifyData;
  }

  @override
  void update(void Function(OtpVerifyDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OtpVerifyData build() => _build();

  _$OtpVerifyData _build() {
    final _$result =
        _$v ?? _$OtpVerifyData._(purpose: purpose, verified: verified);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
