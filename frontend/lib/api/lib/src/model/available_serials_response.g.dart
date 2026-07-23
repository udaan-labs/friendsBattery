// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_serials_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AvailableSerialsResponse extends AvailableSerialsResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<String>? data;

  factory _$AvailableSerialsResponse([
    void Function(AvailableSerialsResponseBuilder)? updates,
  ]) => (AvailableSerialsResponseBuilder()..update(updates))._build();

  _$AvailableSerialsResponse._({this.success, this.message, this.data})
    : super._();
  @override
  AvailableSerialsResponse rebuild(
    void Function(AvailableSerialsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AvailableSerialsResponseBuilder toBuilder() =>
      AvailableSerialsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AvailableSerialsResponse &&
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
    return (newBuiltValueToStringHelper(r'AvailableSerialsResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class AvailableSerialsResponseBuilder
    implements
        Builder<AvailableSerialsResponse, AvailableSerialsResponseBuilder> {
  _$AvailableSerialsResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<String>? _data;
  ListBuilder<String> get data => _$this._data ??= ListBuilder<String>();
  set data(ListBuilder<String>? data) => _$this._data = data;

  AvailableSerialsResponseBuilder() {
    AvailableSerialsResponse._defaults(this);
  }

  AvailableSerialsResponseBuilder get _$this {
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
  void replace(AvailableSerialsResponse other) {
    _$v = other as _$AvailableSerialsResponse;
  }

  @override
  void update(void Function(AvailableSerialsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AvailableSerialsResponse build() => _build();

  _$AvailableSerialsResponse _build() {
    _$AvailableSerialsResponse _$result;
    try {
      _$result =
          _$v ??
          _$AvailableSerialsResponse._(
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
          r'AvailableSerialsResponse',
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
