// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_send_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OtpSendData extends OtpSendData {
  @override
  final String? challengeId;
  @override
  final int? expiresIn;
  @override
  final String? otp;

  factory _$OtpSendData([void Function(OtpSendDataBuilder)? updates]) =>
      (OtpSendDataBuilder()..update(updates))._build();

  _$OtpSendData._({this.challengeId, this.expiresIn, this.otp}) : super._();
  @override
  OtpSendData rebuild(void Function(OtpSendDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OtpSendDataBuilder toBuilder() => OtpSendDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OtpSendData &&
        challengeId == other.challengeId &&
        expiresIn == other.expiresIn &&
        otp == other.otp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, challengeId.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OtpSendData')
          ..add('challengeId', challengeId)
          ..add('expiresIn', expiresIn)
          ..add('otp', otp))
        .toString();
  }
}

class OtpSendDataBuilder implements Builder<OtpSendData, OtpSendDataBuilder> {
  _$OtpSendData? _$v;

  String? _challengeId;
  String? get challengeId => _$this._challengeId;
  set challengeId(String? challengeId) => _$this._challengeId = challengeId;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  String? _otp;
  String? get otp => _$this._otp;
  set otp(String? otp) => _$this._otp = otp;

  OtpSendDataBuilder() {
    OtpSendData._defaults(this);
  }

  OtpSendDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _challengeId = $v.challengeId;
      _expiresIn = $v.expiresIn;
      _otp = $v.otp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OtpSendData other) {
    _$v = other as _$OtpSendData;
  }

  @override
  void update(void Function(OtpSendDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OtpSendData build() => _build();

  _$OtpSendData _build() {
    final _$result =
        _$v ??
        _$OtpSendData._(
          challengeId: challengeId,
          expiresIn: expiresIn,
          otp: otp,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
