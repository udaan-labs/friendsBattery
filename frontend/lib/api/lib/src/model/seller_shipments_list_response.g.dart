// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_shipments_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerShipmentsListResponse extends SellerShipmentsListResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<SellerShipmentListItem>? data;

  factory _$SellerShipmentsListResponse([
    void Function(SellerShipmentsListResponseBuilder)? updates,
  ]) => (SellerShipmentsListResponseBuilder()..update(updates))._build();

  _$SellerShipmentsListResponse._({this.success, this.message, this.data})
    : super._();
  @override
  SellerShipmentsListResponse rebuild(
    void Function(SellerShipmentsListResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SellerShipmentsListResponseBuilder toBuilder() =>
      SellerShipmentsListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerShipmentsListResponse &&
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
    return (newBuiltValueToStringHelper(r'SellerShipmentsListResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class SellerShipmentsListResponseBuilder
    implements
        Builder<
          SellerShipmentsListResponse,
          SellerShipmentsListResponseBuilder
        > {
  _$SellerShipmentsListResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<SellerShipmentListItem>? _data;
  ListBuilder<SellerShipmentListItem> get data =>
      _$this._data ??= ListBuilder<SellerShipmentListItem>();
  set data(ListBuilder<SellerShipmentListItem>? data) => _$this._data = data;

  SellerShipmentsListResponseBuilder() {
    SellerShipmentsListResponse._defaults(this);
  }

  SellerShipmentsListResponseBuilder get _$this {
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
  void replace(SellerShipmentsListResponse other) {
    _$v = other as _$SellerShipmentsListResponse;
  }

  @override
  void update(void Function(SellerShipmentsListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerShipmentsListResponse build() => _build();

  _$SellerShipmentsListResponse _build() {
    _$SellerShipmentsListResponse _$result;
    try {
      _$result =
          _$v ??
          _$SellerShipmentsListResponse._(
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
          r'SellerShipmentsListResponse',
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
