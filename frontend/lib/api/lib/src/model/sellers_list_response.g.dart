// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sellers_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellersListResponse extends SellersListResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<SellerShopSummary>? data;

  factory _$SellersListResponse([
    void Function(SellersListResponseBuilder)? updates,
  ]) => (SellersListResponseBuilder()..update(updates))._build();

  _$SellersListResponse._({this.success, this.message, this.data}) : super._();
  @override
  SellersListResponse rebuild(
    void Function(SellersListResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SellersListResponseBuilder toBuilder() =>
      SellersListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellersListResponse &&
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
    return (newBuiltValueToStringHelper(r'SellersListResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class SellersListResponseBuilder
    implements Builder<SellersListResponse, SellersListResponseBuilder> {
  _$SellersListResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<SellerShopSummary>? _data;
  ListBuilder<SellerShopSummary> get data =>
      _$this._data ??= ListBuilder<SellerShopSummary>();
  set data(ListBuilder<SellerShopSummary>? data) => _$this._data = data;

  SellersListResponseBuilder() {
    SellersListResponse._defaults(this);
  }

  SellersListResponseBuilder get _$this {
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
  void replace(SellersListResponse other) {
    _$v = other as _$SellersListResponse;
  }

  @override
  void update(void Function(SellersListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellersListResponse build() => _build();

  _$SellersListResponse _build() {
    _$SellersListResponse _$result;
    try {
      _$result =
          _$v ??
          _$SellersListResponse._(
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
          r'SellersListResponse',
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
