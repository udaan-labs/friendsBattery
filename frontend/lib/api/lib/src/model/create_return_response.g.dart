// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_return_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateReturnResponse extends CreateReturnResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final CreateReturnResult? data;

  factory _$CreateReturnResponse([
    void Function(CreateReturnResponseBuilder)? updates,
  ]) => (CreateReturnResponseBuilder()..update(updates))._build();

  _$CreateReturnResponse._({this.success, this.message, this.data}) : super._();
  @override
  CreateReturnResponse rebuild(
    void Function(CreateReturnResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateReturnResponseBuilder toBuilder() =>
      CreateReturnResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateReturnResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateReturnResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateReturnResponseBuilder
    implements Builder<CreateReturnResponse, CreateReturnResponseBuilder> {
  _$CreateReturnResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CreateReturnResultBuilder? _data;
  CreateReturnResultBuilder get data =>
      _$this._data ??= CreateReturnResultBuilder();
  set data(CreateReturnResultBuilder? data) => _$this._data = data;

  CreateReturnResponseBuilder() {
    CreateReturnResponse._defaults(this);
  }

  CreateReturnResponseBuilder get _$this {
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
  void replace(CreateReturnResponse other) {
    _$v = other as _$CreateReturnResponse;
  }

  @override
  void update(void Function(CreateReturnResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateReturnResponse build() => _build();

  _$CreateReturnResponse _build() {
    _$CreateReturnResponse _$result;
    try {
      _$result =
          _$v ??
          _$CreateReturnResponse._(
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
          r'CreateReturnResponse',
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
