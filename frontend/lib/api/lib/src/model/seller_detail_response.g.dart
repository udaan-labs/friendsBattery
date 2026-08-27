// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerDetailResponse extends SellerDetailResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final SellerDetail? data;

  factory _$SellerDetailResponse([
    void Function(SellerDetailResponseBuilder)? updates,
  ]) => (SellerDetailResponseBuilder()..update(updates))._build();

  _$SellerDetailResponse._({this.success, this.message, this.data}) : super._();
  @override
  SellerDetailResponse rebuild(
    void Function(SellerDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SellerDetailResponseBuilder toBuilder() =>
      SellerDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerDetailResponse &&
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
    return (newBuiltValueToStringHelper(r'SellerDetailResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class SellerDetailResponseBuilder
    implements Builder<SellerDetailResponse, SellerDetailResponseBuilder> {
  _$SellerDetailResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SellerDetailBuilder? _data;
  SellerDetailBuilder get data => _$this._data ??= SellerDetailBuilder();
  set data(SellerDetailBuilder? data) => _$this._data = data;

  SellerDetailResponseBuilder() {
    SellerDetailResponse._defaults(this);
  }

  SellerDetailResponseBuilder get _$this {
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
  void replace(SellerDetailResponse other) {
    _$v = other as _$SellerDetailResponse;
  }

  @override
  void update(void Function(SellerDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerDetailResponse build() => _build();

  _$SellerDetailResponse _build() {
    _$SellerDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$SellerDetailResponse._(
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
          r'SellerDetailResponse',
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
