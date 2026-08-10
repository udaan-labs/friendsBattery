// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_otp_verify_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiOtpVerifyPostRequest extends ApiOtpVerifyPostRequest {
  @override
  final String challengeId;
  @override
  final String otp;
  @override
  final String? purpose;

  factory _$ApiOtpVerifyPostRequest([
    void Function(ApiOtpVerifyPostRequestBuilder)? updates,
  ]) => (ApiOtpVerifyPostRequestBuilder()..update(updates))._build();

  _$ApiOtpVerifyPostRequest._({
    required this.challengeId,
    required this.otp,
    this.purpose,
  }) : super._();
  @override
  ApiOtpVerifyPostRequest rebuild(
    void Function(ApiOtpVerifyPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiOtpVerifyPostRequestBuilder toBuilder() =>
      ApiOtpVerifyPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiOtpVerifyPostRequest &&
        challengeId == other.challengeId &&
        otp == other.otp &&
        purpose == other.purpose;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, challengeId.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiOtpVerifyPostRequest')
          ..add('challengeId', challengeId)
          ..add('otp', otp)
          ..add('purpose', purpose))
        .toString();
  }
}

class ApiOtpVerifyPostRequestBuilder
    implements
        Builder<ApiOtpVerifyPostRequest, ApiOtpVerifyPostRequestBuilder> {
  _$ApiOtpVerifyPostRequest? _$v;

  String? _challengeId;
  String? get challengeId => _$this._challengeId;
  set challengeId(String? challengeId) => _$this._challengeId = challengeId;

  String? _otp;
  String? get otp => _$this._otp;
  set otp(String? otp) => _$this._otp = otp;

  String? _purpose;
  String? get purpose => _$this._purpose;
  set purpose(String? purpose) => _$this._purpose = purpose;

  ApiOtpVerifyPostRequestBuilder() {
    ApiOtpVerifyPostRequest._defaults(this);
  }

  ApiOtpVerifyPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _challengeId = $v.challengeId;
      _otp = $v.otp;
      _purpose = $v.purpose;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiOtpVerifyPostRequest other) {
    _$v = other as _$ApiOtpVerifyPostRequest;
  }

  @override
  void update(void Function(ApiOtpVerifyPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiOtpVerifyPostRequest build() => _build();

  _$ApiOtpVerifyPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiOtpVerifyPostRequest._(
          challengeId: BuiltValueNullFieldError.checkNotNull(
            challengeId,
            r'ApiOtpVerifyPostRequest',
            'challengeId',
          ),
          otp: BuiltValueNullFieldError.checkNotNull(
            otp,
            r'ApiOtpVerifyPostRequest',
            'otp',
          ),
          purpose: purpose,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
