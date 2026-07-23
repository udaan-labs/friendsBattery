// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'returns_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReturnsListResponse extends ReturnsListResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<ReturnListItem>? data;

  factory _$ReturnsListResponse([
    void Function(ReturnsListResponseBuilder)? updates,
  ]) => (ReturnsListResponseBuilder()..update(updates))._build();

  _$ReturnsListResponse._({this.success, this.message, this.data}) : super._();
  @override
  ReturnsListResponse rebuild(
    void Function(ReturnsListResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReturnsListResponseBuilder toBuilder() =>
      ReturnsListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReturnsListResponse &&
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
    return (newBuiltValueToStringHelper(r'ReturnsListResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ReturnsListResponseBuilder
    implements Builder<ReturnsListResponse, ReturnsListResponseBuilder> {
  _$ReturnsListResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<ReturnListItem>? _data;
  ListBuilder<ReturnListItem> get data =>
      _$this._data ??= ListBuilder<ReturnListItem>();
  set data(ListBuilder<ReturnListItem>? data) => _$this._data = data;

  ReturnsListResponseBuilder() {
    ReturnsListResponse._defaults(this);
  }

  ReturnsListResponseBuilder get _$this {
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
  void replace(ReturnsListResponse other) {
    _$v = other as _$ReturnsListResponse;
  }

  @override
  void update(void Function(ReturnsListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReturnsListResponse build() => _build();

  _$ReturnsListResponse _build() {
    _$ReturnsListResponse _$result;
    try {
      _$result =
          _$v ??
          _$ReturnsListResponse._(
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
          r'ReturnsListResponse',
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
