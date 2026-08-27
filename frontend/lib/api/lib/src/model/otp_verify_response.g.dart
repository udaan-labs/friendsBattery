// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OtpVerifyResponse extends OtpVerifyResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final OtpVerifyData? data;

  factory _$OtpVerifyResponse([
    void Function(OtpVerifyResponseBuilder)? updates,
  ]) => (OtpVerifyResponseBuilder()..update(updates))._build();

  _$OtpVerifyResponse._({this.success, this.message, this.data}) : super._();
  @override
  OtpVerifyResponse rebuild(void Function(OtpVerifyResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OtpVerifyResponseBuilder toBuilder() =>
      OtpVerifyResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OtpVerifyResponse &&
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
    return (newBuiltValueToStringHelper(r'OtpVerifyResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class OtpVerifyResponseBuilder
    implements Builder<OtpVerifyResponse, OtpVerifyResponseBuilder> {
  _$OtpVerifyResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  OtpVerifyDataBuilder? _data;
  OtpVerifyDataBuilder get data => _$this._data ??= OtpVerifyDataBuilder();
  set data(OtpVerifyDataBuilder? data) => _$this._data = data;

  OtpVerifyResponseBuilder() {
    OtpVerifyResponse._defaults(this);
  }

  OtpVerifyResponseBuilder get _$this {
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
  void replace(OtpVerifyResponse other) {
    _$v = other as _$OtpVerifyResponse;
  }

  @override
  void update(void Function(OtpVerifyResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OtpVerifyResponse build() => _build();

  _$OtpVerifyResponse _build() {
    _$OtpVerifyResponse _$result;
    try {
      _$result =
          _$v ??
          _$OtpVerifyResponse._(
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
          r'OtpVerifyResponse',
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
