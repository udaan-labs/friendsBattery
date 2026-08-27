// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_activity_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecentActivityResponse extends RecentActivityResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<ActivityItem>? data;

  factory _$RecentActivityResponse([
    void Function(RecentActivityResponseBuilder)? updates,
  ]) => (RecentActivityResponseBuilder()..update(updates))._build();

  _$RecentActivityResponse._({this.success, this.message, this.data})
    : super._();
  @override
  RecentActivityResponse rebuild(
    void Function(RecentActivityResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RecentActivityResponseBuilder toBuilder() =>
      RecentActivityResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecentActivityResponse &&
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
    return (newBuiltValueToStringHelper(r'RecentActivityResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class RecentActivityResponseBuilder
    implements Builder<RecentActivityResponse, RecentActivityResponseBuilder> {
  _$RecentActivityResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<ActivityItem>? _data;
  ListBuilder<ActivityItem> get data =>
      _$this._data ??= ListBuilder<ActivityItem>();
  set data(ListBuilder<ActivityItem>? data) => _$this._data = data;

  RecentActivityResponseBuilder() {
    RecentActivityResponse._defaults(this);
  }

  RecentActivityResponseBuilder get _$this {
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
  void replace(RecentActivityResponse other) {
    _$v = other as _$RecentActivityResponse;
  }

  @override
  void update(void Function(RecentActivityResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecentActivityResponse build() => _build();

  _$RecentActivityResponse _build() {
    _$RecentActivityResponse _$result;
    try {
      _$result =
          _$v ??
          _$RecentActivityResponse._(
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
          r'RecentActivityResponse',
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
