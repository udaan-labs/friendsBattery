// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChangePasswordResponse extends ChangePasswordResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ChangePasswordData? data;

  factory _$ChangePasswordResponse([
    void Function(ChangePasswordResponseBuilder)? updates,
  ]) => (ChangePasswordResponseBuilder()..update(updates))._build();

  _$ChangePasswordResponse._({this.success, this.message, this.data})
    : super._();
  @override
  ChangePasswordResponse rebuild(
    void Function(ChangePasswordResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChangePasswordResponseBuilder toBuilder() =>
      ChangePasswordResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangePasswordResponse &&
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
    return (newBuiltValueToStringHelper(r'ChangePasswordResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ChangePasswordResponseBuilder
    implements Builder<ChangePasswordResponse, ChangePasswordResponseBuilder> {
  _$ChangePasswordResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ChangePasswordDataBuilder? _data;
  ChangePasswordDataBuilder get data =>
      _$this._data ??= ChangePasswordDataBuilder();
  set data(ChangePasswordDataBuilder? data) => _$this._data = data;

  ChangePasswordResponseBuilder() {
    ChangePasswordResponse._defaults(this);
  }

  ChangePasswordResponseBuilder get _$this {
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
  void replace(ChangePasswordResponse other) {
    _$v = other as _$ChangePasswordResponse;
  }

  @override
  void update(void Function(ChangePasswordResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangePasswordResponse build() => _build();

  _$ChangePasswordResponse _build() {
    _$ChangePasswordResponse _$result;
    try {
      _$result =
          _$v ??
          _$ChangePasswordResponse._(
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
          r'ChangePasswordResponse',
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
