// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_product_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyProductResponse extends VerifyProductResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final VerifyProductPayload? data;

  factory _$VerifyProductResponse([
    void Function(VerifyProductResponseBuilder)? updates,
  ]) => (VerifyProductResponseBuilder()..update(updates))._build();

  _$VerifyProductResponse._({this.success, this.message, this.data})
    : super._();
  @override
  VerifyProductResponse rebuild(
    void Function(VerifyProductResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  VerifyProductResponseBuilder toBuilder() =>
      VerifyProductResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyProductResponse &&
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
    return (newBuiltValueToStringHelper(r'VerifyProductResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class VerifyProductResponseBuilder
    implements Builder<VerifyProductResponse, VerifyProductResponseBuilder> {
  _$VerifyProductResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  VerifyProductPayloadBuilder? _data;
  VerifyProductPayloadBuilder get data =>
      _$this._data ??= VerifyProductPayloadBuilder();
  set data(VerifyProductPayloadBuilder? data) => _$this._data = data;

  VerifyProductResponseBuilder() {
    VerifyProductResponse._defaults(this);
  }

  VerifyProductResponseBuilder get _$this {
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
  void replace(VerifyProductResponse other) {
    _$v = other as _$VerifyProductResponse;
  }

  @override
  void update(void Function(VerifyProductResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyProductResponse build() => _build();

  _$VerifyProductResponse _build() {
    _$VerifyProductResponse _$result;
    try {
      _$result =
          _$v ??
          _$VerifyProductResponse._(
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
          r'VerifyProductResponse',
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
