// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_status_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppStatusResponse extends AppStatusResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final AppStatus? data;

  factory _$AppStatusResponse([
    void Function(AppStatusResponseBuilder)? updates,
  ]) => (AppStatusResponseBuilder()..update(updates))._build();

  _$AppStatusResponse._({this.success, this.message, this.data}) : super._();
  @override
  AppStatusResponse rebuild(void Function(AppStatusResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStatusResponseBuilder toBuilder() =>
      AppStatusResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppStatusResponse &&
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
    return (newBuiltValueToStringHelper(r'AppStatusResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class AppStatusResponseBuilder
    implements Builder<AppStatusResponse, AppStatusResponseBuilder> {
  _$AppStatusResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AppStatusBuilder? _data;
  AppStatusBuilder get data => _$this._data ??= AppStatusBuilder();
  set data(AppStatusBuilder? data) => _$this._data = data;

  AppStatusResponseBuilder() {
    AppStatusResponse._defaults(this);
  }

  AppStatusResponseBuilder get _$this {
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
  void replace(AppStatusResponse other) {
    _$v = other as _$AppStatusResponse;
  }

  @override
  void update(void Function(AppStatusResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppStatusResponse build() => _build();

  _$AppStatusResponse _build() {
    _$AppStatusResponse _$result;
    try {
      _$result =
          _$v ??
          _$AppStatusResponse._(
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
          r'AppStatusResponse',
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
