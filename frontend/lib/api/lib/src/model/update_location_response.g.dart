// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_location_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateLocationResponse extends UpdateLocationResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final LocationItem? data;

  factory _$UpdateLocationResponse([
    void Function(UpdateLocationResponseBuilder)? updates,
  ]) => (UpdateLocationResponseBuilder()..update(updates))._build();

  _$UpdateLocationResponse._({this.success, this.message, this.data})
    : super._();
  @override
  UpdateLocationResponse rebuild(
    void Function(UpdateLocationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateLocationResponseBuilder toBuilder() =>
      UpdateLocationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateLocationResponse &&
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
    return (newBuiltValueToStringHelper(r'UpdateLocationResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UpdateLocationResponseBuilder
    implements Builder<UpdateLocationResponse, UpdateLocationResponseBuilder> {
  _$UpdateLocationResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  LocationItemBuilder? _data;
  LocationItemBuilder get data => _$this._data ??= LocationItemBuilder();
  set data(LocationItemBuilder? data) => _$this._data = data;

  UpdateLocationResponseBuilder() {
    UpdateLocationResponse._defaults(this);
  }

  UpdateLocationResponseBuilder get _$this {
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
  void replace(UpdateLocationResponse other) {
    _$v = other as _$UpdateLocationResponse;
  }

  @override
  void update(void Function(UpdateLocationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateLocationResponse build() => _build();

  _$UpdateLocationResponse _build() {
    _$UpdateLocationResponse _$result;
    try {
      _$result =
          _$v ??
          _$UpdateLocationResponse._(
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
          r'UpdateLocationResponse',
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
