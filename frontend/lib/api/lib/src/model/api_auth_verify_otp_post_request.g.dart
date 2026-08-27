// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_auth_verify_otp_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiAuthVerifyOtpPostRequest extends ApiAuthVerifyOtpPostRequest {
  @override
  final String challengeId;
  @override
  final String otp;

  factory _$ApiAuthVerifyOtpPostRequest([
    void Function(ApiAuthVerifyOtpPostRequestBuilder)? updates,
  ]) => (ApiAuthVerifyOtpPostRequestBuilder()..update(updates))._build();

  _$ApiAuthVerifyOtpPostRequest._({
    required this.challengeId,
    required this.otp,
  }) : super._();
  @override
  ApiAuthVerifyOtpPostRequest rebuild(
    void Function(ApiAuthVerifyOtpPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiAuthVerifyOtpPostRequestBuilder toBuilder() =>
      ApiAuthVerifyOtpPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiAuthVerifyOtpPostRequest &&
        challengeId == other.challengeId &&
        otp == other.otp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, challengeId.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiAuthVerifyOtpPostRequest')
          ..add('challengeId', challengeId)
          ..add('otp', otp))
        .toString();
  }
}

class ApiAuthVerifyOtpPostRequestBuilder
    implements
        Builder<
          ApiAuthVerifyOtpPostRequest,
          ApiAuthVerifyOtpPostRequestBuilder
        > {
  _$ApiAuthVerifyOtpPostRequest? _$v;

  String? _challengeId;
  String? get challengeId => _$this._challengeId;
  set challengeId(String? challengeId) => _$this._challengeId = challengeId;

  String? _otp;
  String? get otp => _$this._otp;
  set otp(String? otp) => _$this._otp = otp;

  ApiAuthVerifyOtpPostRequestBuilder() {
    ApiAuthVerifyOtpPostRequest._defaults(this);
  }

  ApiAuthVerifyOtpPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _challengeId = $v.challengeId;
      _otp = $v.otp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiAuthVerifyOtpPostRequest other) {
    _$v = other as _$ApiAuthVerifyOtpPostRequest;
  }

  @override
  void update(void Function(ApiAuthVerifyOtpPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiAuthVerifyOtpPostRequest build() => _build();

  _$ApiAuthVerifyOtpPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiAuthVerifyOtpPostRequest._(
          challengeId: BuiltValueNullFieldError.checkNotNull(
            challengeId,
            r'ApiAuthVerifyOtpPostRequest',
            'challengeId',
          ),
          otp: BuiltValueNullFieldError.checkNotNull(
            otp,
            r'ApiAuthVerifyOtpPostRequest',
            'otp',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
