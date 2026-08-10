// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_send_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OtpSendResponse extends OtpSendResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final OtpSendData? data;

  factory _$OtpSendResponse([void Function(OtpSendResponseBuilder)? updates]) =>
      (OtpSendResponseBuilder()..update(updates))._build();

  _$OtpSendResponse._({this.success, this.message, this.data}) : super._();
  @override
  OtpSendResponse rebuild(void Function(OtpSendResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OtpSendResponseBuilder toBuilder() => OtpSendResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OtpSendResponse &&
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
    return (newBuiltValueToStringHelper(r'OtpSendResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class OtpSendResponseBuilder
    implements Builder<OtpSendResponse, OtpSendResponseBuilder> {
  _$OtpSendResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  OtpSendDataBuilder? _data;
  OtpSendDataBuilder get data => _$this._data ??= OtpSendDataBuilder();
  set data(OtpSendDataBuilder? data) => _$this._data = data;

  OtpSendResponseBuilder() {
    OtpSendResponse._defaults(this);
  }

  OtpSendResponseBuilder get _$this {
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
  void replace(OtpSendResponse other) {
    _$v = other as _$OtpSendResponse;
  }

  @override
  void update(void Function(OtpSendResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OtpSendResponse build() => _build();

  _$OtpSendResponse _build() {
    _$OtpSendResponse _$result;
    try {
      _$result =
          _$v ??
          _$OtpSendResponse._(
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
          r'OtpSendResponse',
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
