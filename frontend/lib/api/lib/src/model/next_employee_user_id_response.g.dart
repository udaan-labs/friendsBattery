// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_employee_user_id_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NextEmployeeUserIdResponse extends NextEmployeeUserIdResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final NextEmployeeUserIdData? data;

  factory _$NextEmployeeUserIdResponse([
    void Function(NextEmployeeUserIdResponseBuilder)? updates,
  ]) => (NextEmployeeUserIdResponseBuilder()..update(updates))._build();

  _$NextEmployeeUserIdResponse._({this.success, this.message, this.data})
    : super._();
  @override
  NextEmployeeUserIdResponse rebuild(
    void Function(NextEmployeeUserIdResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NextEmployeeUserIdResponseBuilder toBuilder() =>
      NextEmployeeUserIdResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NextEmployeeUserIdResponse &&
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
    return (newBuiltValueToStringHelper(r'NextEmployeeUserIdResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class NextEmployeeUserIdResponseBuilder
    implements
        Builder<NextEmployeeUserIdResponse, NextEmployeeUserIdResponseBuilder> {
  _$NextEmployeeUserIdResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  NextEmployeeUserIdDataBuilder? _data;
  NextEmployeeUserIdDataBuilder get data =>
      _$this._data ??= NextEmployeeUserIdDataBuilder();
  set data(NextEmployeeUserIdDataBuilder? data) => _$this._data = data;

  NextEmployeeUserIdResponseBuilder() {
    NextEmployeeUserIdResponse._defaults(this);
  }

  NextEmployeeUserIdResponseBuilder get _$this {
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
  void replace(NextEmployeeUserIdResponse other) {
    _$v = other as _$NextEmployeeUserIdResponse;
  }

  @override
  void update(void Function(NextEmployeeUserIdResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NextEmployeeUserIdResponse build() => _build();

  _$NextEmployeeUserIdResponse _build() {
    _$NextEmployeeUserIdResponse _$result;
    try {
      _$result =
          _$v ??
          _$NextEmployeeUserIdResponse._(
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
          r'NextEmployeeUserIdResponse',
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
