// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_otp_send_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiOtpSendPostRequest extends ApiOtpSendPostRequest {
  @override
  final String purpose;

  factory _$ApiOtpSendPostRequest([
    void Function(ApiOtpSendPostRequestBuilder)? updates,
  ]) => (ApiOtpSendPostRequestBuilder()..update(updates))._build();

  _$ApiOtpSendPostRequest._({required this.purpose}) : super._();
  @override
  ApiOtpSendPostRequest rebuild(
    void Function(ApiOtpSendPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiOtpSendPostRequestBuilder toBuilder() =>
      ApiOtpSendPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiOtpSendPostRequest && purpose == other.purpose;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ApiOtpSendPostRequest',
    )..add('purpose', purpose)).toString();
  }
}

class ApiOtpSendPostRequestBuilder
    implements Builder<ApiOtpSendPostRequest, ApiOtpSendPostRequestBuilder> {
  _$ApiOtpSendPostRequest? _$v;

  String? _purpose;
  String? get purpose => _$this._purpose;
  set purpose(String? purpose) => _$this._purpose = purpose;

  ApiOtpSendPostRequestBuilder() {
    ApiOtpSendPostRequest._defaults(this);
  }

  ApiOtpSendPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _purpose = $v.purpose;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiOtpSendPostRequest other) {
    _$v = other as _$ApiOtpSendPostRequest;
  }

  @override
  void update(void Function(ApiOtpSendPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiOtpSendPostRequest build() => _build();

  _$ApiOtpSendPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiOtpSendPostRequest._(
          purpose: BuiltValueNullFieldError.checkNotNull(
            purpose,
            r'ApiOtpSendPostRequest',
            'purpose',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
