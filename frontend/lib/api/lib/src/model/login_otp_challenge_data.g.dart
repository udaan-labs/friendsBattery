// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_otp_challenge_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginOtpChallengeData extends LoginOtpChallengeData {
  @override
  final bool? requiresOtp;
  @override
  final String? challengeId;
  @override
  final int? expiresIn;
  @override
  final String? phoneMasked;
  @override
  final String? otp;

  factory _$LoginOtpChallengeData([
    void Function(LoginOtpChallengeDataBuilder)? updates,
  ]) => (LoginOtpChallengeDataBuilder()..update(updates))._build();

  _$LoginOtpChallengeData._({
    this.requiresOtp,
    this.challengeId,
    this.expiresIn,
    this.phoneMasked,
    this.otp,
  }) : super._();
  @override
  LoginOtpChallengeData rebuild(
    void Function(LoginOtpChallengeDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LoginOtpChallengeDataBuilder toBuilder() =>
      LoginOtpChallengeDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginOtpChallengeData &&
        requiresOtp == other.requiresOtp &&
        challengeId == other.challengeId &&
        expiresIn == other.expiresIn &&
        phoneMasked == other.phoneMasked &&
        otp == other.otp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, requiresOtp.hashCode);
    _$hash = $jc(_$hash, challengeId.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, phoneMasked.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginOtpChallengeData')
          ..add('requiresOtp', requiresOtp)
          ..add('challengeId', challengeId)
          ..add('expiresIn', expiresIn)
          ..add('phoneMasked', phoneMasked)
          ..add('otp', otp))
        .toString();
  }
}

class LoginOtpChallengeDataBuilder
    implements Builder<LoginOtpChallengeData, LoginOtpChallengeDataBuilder> {
  _$LoginOtpChallengeData? _$v;

  bool? _requiresOtp;
  bool? get requiresOtp => _$this._requiresOtp;
  set requiresOtp(bool? requiresOtp) => _$this._requiresOtp = requiresOtp;

  String? _challengeId;
  String? get challengeId => _$this._challengeId;
  set challengeId(String? challengeId) => _$this._challengeId = challengeId;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  String? _phoneMasked;
  String? get phoneMasked => _$this._phoneMasked;
  set phoneMasked(String? phoneMasked) => _$this._phoneMasked = phoneMasked;

  String? _otp;
  String? get otp => _$this._otp;
  set otp(String? otp) => _$this._otp = otp;

  LoginOtpChallengeDataBuilder() {
    LoginOtpChallengeData._defaults(this);
  }

  LoginOtpChallengeDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _requiresOtp = $v.requiresOtp;
      _challengeId = $v.challengeId;
      _expiresIn = $v.expiresIn;
      _phoneMasked = $v.phoneMasked;
      _otp = $v.otp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginOtpChallengeData other) {
    _$v = other as _$LoginOtpChallengeData;
  }

  @override
  void update(void Function(LoginOtpChallengeDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginOtpChallengeData build() => _build();

  _$LoginOtpChallengeData _build() {
    final _$result =
        _$v ??
        _$LoginOtpChallengeData._(
          requiresOtp: requiresOtp,
          challengeId: challengeId,
          expiresIn: expiresIn,
          phoneMasked: phoneMasked,
          otp: otp,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
