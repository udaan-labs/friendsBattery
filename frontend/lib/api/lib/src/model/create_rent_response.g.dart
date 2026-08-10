// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_rent_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateRentResponse extends CreateRentResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final CreateRentResult? data;

  factory _$CreateRentResponse([
    void Function(CreateRentResponseBuilder)? updates,
  ]) => (CreateRentResponseBuilder()..update(updates))._build();

  _$CreateRentResponse._({this.success, this.message, this.data}) : super._();
  @override
  CreateRentResponse rebuild(
    void Function(CreateRentResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateRentResponseBuilder toBuilder() =>
      CreateRentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRentResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateRentResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateRentResponseBuilder
    implements Builder<CreateRentResponse, CreateRentResponseBuilder> {
  _$CreateRentResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CreateRentResultBuilder? _data;
  CreateRentResultBuilder get data =>
      _$this._data ??= CreateRentResultBuilder();
  set data(CreateRentResultBuilder? data) => _$this._data = data;

  CreateRentResponseBuilder() {
    CreateRentResponse._defaults(this);
  }

  CreateRentResponseBuilder get _$this {
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
  void replace(CreateRentResponse other) {
    _$v = other as _$CreateRentResponse;
  }

  @override
  void update(void Function(CreateRentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRentResponse build() => _build();

  _$CreateRentResponse _build() {
    _$CreateRentResponse _$result;
    try {
      _$result =
          _$v ??
          _$CreateRentResponse._(
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
          r'CreateRentResponse',
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
