// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_location_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateLocationResponse extends CreateLocationResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final LocationItem? data;

  factory _$CreateLocationResponse([
    void Function(CreateLocationResponseBuilder)? updates,
  ]) => (CreateLocationResponseBuilder()..update(updates))._build();

  _$CreateLocationResponse._({this.success, this.message, this.data})
    : super._();
  @override
  CreateLocationResponse rebuild(
    void Function(CreateLocationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateLocationResponseBuilder toBuilder() =>
      CreateLocationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateLocationResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateLocationResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateLocationResponseBuilder
    implements Builder<CreateLocationResponse, CreateLocationResponseBuilder> {
  _$CreateLocationResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  LocationItemBuilder? _data;
  LocationItemBuilder get data => _$this._data ??= LocationItemBuilder();
  set data(LocationItemBuilder? data) => _$this._data = data;

  CreateLocationResponseBuilder() {
    CreateLocationResponse._defaults(this);
  }

  CreateLocationResponseBuilder get _$this {
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
  void replace(CreateLocationResponse other) {
    _$v = other as _$CreateLocationResponse;
  }

  @override
  void update(void Function(CreateLocationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateLocationResponse build() => _build();

  _$CreateLocationResponse _build() {
    _$CreateLocationResponse _$result;
    try {
      _$result =
          _$v ??
          _$CreateLocationResponse._(
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
          r'CreateLocationResponse',
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
