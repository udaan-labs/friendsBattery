// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_for_sale_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScanForSaleResponse extends ScanForSaleResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ScanForSaleResult? data;

  factory _$ScanForSaleResponse([
    void Function(ScanForSaleResponseBuilder)? updates,
  ]) => (ScanForSaleResponseBuilder()..update(updates))._build();

  _$ScanForSaleResponse._({this.success, this.message, this.data}) : super._();
  @override
  ScanForSaleResponse rebuild(
    void Function(ScanForSaleResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScanForSaleResponseBuilder toBuilder() =>
      ScanForSaleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScanForSaleResponse &&
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
    return (newBuiltValueToStringHelper(r'ScanForSaleResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ScanForSaleResponseBuilder
    implements Builder<ScanForSaleResponse, ScanForSaleResponseBuilder> {
  _$ScanForSaleResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ScanForSaleResultBuilder? _data;
  ScanForSaleResultBuilder get data =>
      _$this._data ??= ScanForSaleResultBuilder();
  set data(ScanForSaleResultBuilder? data) => _$this._data = data;

  ScanForSaleResponseBuilder() {
    ScanForSaleResponse._defaults(this);
  }

  ScanForSaleResponseBuilder get _$this {
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
  void replace(ScanForSaleResponse other) {
    _$v = other as _$ScanForSaleResponse;
  }

  @override
  void update(void Function(ScanForSaleResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScanForSaleResponse build() => _build();

  _$ScanForSaleResponse _build() {
    _$ScanForSaleResponse _$result;
    try {
      _$result =
          _$v ??
          _$ScanForSaleResponse._(
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
          r'ScanForSaleResponse',
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
