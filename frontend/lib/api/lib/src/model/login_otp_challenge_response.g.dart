// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_otp_challenge_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginOtpChallengeResponse extends LoginOtpChallengeResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final LoginOtpChallengeData? data;

  factory _$LoginOtpChallengeResponse([
    void Function(LoginOtpChallengeResponseBuilder)? updates,
  ]) => (LoginOtpChallengeResponseBuilder()..update(updates))._build();

  _$LoginOtpChallengeResponse._({this.success, this.message, this.data})
    : super._();
  @override
  LoginOtpChallengeResponse rebuild(
    void Function(LoginOtpChallengeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LoginOtpChallengeResponseBuilder toBuilder() =>
      LoginOtpChallengeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginOtpChallengeResponse &&
        success == other.success &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginOtpChallengeResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class LoginOtpChallengeResponseBuilder
    implements
        Builder<LoginOtpChallengeResponse, LoginOtpChallengeResponseBuilder> {
  _$LoginOtpChallengeResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  LoginOtpChallengeDataBuilder? _data;
  LoginOtpChallengeDataBuilder get data =>
      _$this._data ??= LoginOtpChallengeDataBuilder();
  set data(LoginOtpChallengeDataBuilder? data) => _$this._data = data;

  LoginOtpChallengeResponseBuilder() {
    LoginOtpChallengeResponse._defaults(this);
  }

  LoginOtpChallengeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginOtpChallengeResponse other) {
    _$v = other as _$LoginOtpChallengeResponse;
  }

  @override
  void update(void Function(LoginOtpChallengeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginOtpChallengeResponse build() => _build();

  _$LoginOtpChallengeResponse _build() {
    _$LoginOtpChallengeResponse _$result;
    try {
      _$result =
          _$v ??
          _$LoginOtpChallengeResponse._(
            success: success,
            message: message,
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LoginOtpChallengeResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
