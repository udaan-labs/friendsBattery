// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_rent_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReturnRentResponse extends ReturnRentResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ReturnRentResult? data;

  factory _$ReturnRentResponse([
    void Function(ReturnRentResponseBuilder)? updates,
  ]) => (ReturnRentResponseBuilder()..update(updates))._build();

  _$ReturnRentResponse._({this.success, this.message, this.data}) : super._();
  @override
  ReturnRentResponse rebuild(
    void Function(ReturnRentResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReturnRentResponseBuilder toBuilder() =>
      ReturnRentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReturnRentResponse &&
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
    return (newBuiltValueToStringHelper(r'ReturnRentResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ReturnRentResponseBuilder
    implements Builder<ReturnRentResponse, ReturnRentResponseBuilder> {
  _$ReturnRentResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ReturnRentResultBuilder? _data;
  ReturnRentResultBuilder get data =>
      _$this._data ??= ReturnRentResultBuilder();
  set data(ReturnRentResultBuilder? data) => _$this._data = data;

  ReturnRentResponseBuilder() {
    ReturnRentResponse._defaults(this);
  }

  ReturnRentResponseBuilder get _$this {
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
  void replace(ReturnRentResponse other) {
    _$v = other as _$ReturnRentResponse;
  }

  @override
  void update(void Function(ReturnRentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReturnRentResponse build() => _build();

  _$ReturnRentResponse _build() {
    _$ReturnRentResponse _$result;
    try {
      _$result =
          _$v ??
          _$ReturnRentResponse._(
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
          r'ReturnRentResponse',
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
