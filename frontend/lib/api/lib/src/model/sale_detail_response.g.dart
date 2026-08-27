// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SaleDetailResponse extends SaleDetailResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final SaleRecord? data;

  factory _$SaleDetailResponse([
    void Function(SaleDetailResponseBuilder)? updates,
  ]) => (SaleDetailResponseBuilder()..update(updates))._build();

  _$SaleDetailResponse._({this.success, this.message, this.data}) : super._();
  @override
  SaleDetailResponse rebuild(
    void Function(SaleDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SaleDetailResponseBuilder toBuilder() =>
      SaleDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SaleDetailResponse &&
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
    return (newBuiltValueToStringHelper(r'SaleDetailResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class SaleDetailResponseBuilder
    implements Builder<SaleDetailResponse, SaleDetailResponseBuilder> {
  _$SaleDetailResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SaleRecordBuilder? _data;
  SaleRecordBuilder get data => _$this._data ??= SaleRecordBuilder();
  set data(SaleRecordBuilder? data) => _$this._data = data;

  SaleDetailResponseBuilder() {
    SaleDetailResponse._defaults(this);
  }

  SaleDetailResponseBuilder get _$this {
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
  void replace(SaleDetailResponse other) {
    _$v = other as _$SaleDetailResponse;
  }

  @override
  void update(void Function(SaleDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SaleDetailResponse build() => _build();

  _$SaleDetailResponse _build() {
    _$SaleDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$SaleDetailResponse._(
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
          r'SaleDetailResponse',
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
