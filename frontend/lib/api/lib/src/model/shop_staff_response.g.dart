// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_staff_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ShopStaffResponse extends ShopStaffResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ShopStaffData? data;

  factory _$ShopStaffResponse([
    void Function(ShopStaffResponseBuilder)? updates,
  ]) => (ShopStaffResponseBuilder()..update(updates))._build();

  _$ShopStaffResponse._({this.success, this.message, this.data}) : super._();
  @override
  ShopStaffResponse rebuild(void Function(ShopStaffResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShopStaffResponseBuilder toBuilder() =>
      ShopStaffResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShopStaffResponse &&
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
    return (newBuiltValueToStringHelper(r'ShopStaffResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ShopStaffResponseBuilder
    implements Builder<ShopStaffResponse, ShopStaffResponseBuilder> {
  _$ShopStaffResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ShopStaffDataBuilder? _data;
  ShopStaffDataBuilder get data => _$this._data ??= ShopStaffDataBuilder();
  set data(ShopStaffDataBuilder? data) => _$this._data = data;

  ShopStaffResponseBuilder() {
    ShopStaffResponse._defaults(this);
  }

  ShopStaffResponseBuilder get _$this {
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
  void replace(ShopStaffResponse other) {
    _$v = other as _$ShopStaffResponse;
  }

  @override
  void update(void Function(ShopStaffResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ShopStaffResponse build() => _build();

  _$ShopStaffResponse _build() {
    _$ShopStaffResponse _$result;
    try {
      _$result =
          _$v ??
          _$ShopStaffResponse._(
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
          r'ShopStaffResponse',
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
