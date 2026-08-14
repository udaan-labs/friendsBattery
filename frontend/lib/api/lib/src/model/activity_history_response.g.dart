// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActivityHistoryResponse extends ActivityHistoryResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<ActivityItem>? data;
  @override
  final ActivityHistoryPagination? pagination;

  factory _$ActivityHistoryResponse([
    void Function(ActivityHistoryResponseBuilder)? updates,
  ]) => (ActivityHistoryResponseBuilder()..update(updates))._build();

  _$ActivityHistoryResponse._({
    this.success,
    this.message,
    this.data,
    this.pagination,
  }) : super._();
  @override
  ActivityHistoryResponse rebuild(
    void Function(ActivityHistoryResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ActivityHistoryResponseBuilder toBuilder() =>
      ActivityHistoryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityHistoryResponse &&
        success == other.success &&
        message == other.message &&
        data == other.data &&
        pagination == other.pagination;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, pagination.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityHistoryResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data)
          ..add('pagination', pagination))
        .toString();
  }
}

class ActivityHistoryResponseBuilder
    implements
        Builder<ActivityHistoryResponse, ActivityHistoryResponseBuilder> {
  _$ActivityHistoryResponse? _$v;

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

  ActivityHistoryPaginationBuilder? _pagination;
  ActivityHistoryPaginationBuilder get pagination =>
      _$this._pagination ??= ActivityHistoryPaginationBuilder();
  set pagination(ActivityHistoryPaginationBuilder? pagination) =>
      _$this._pagination = pagination;

  ActivityHistoryResponseBuilder() {
    ActivityHistoryResponse._defaults(this);
  }

  ActivityHistoryResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _data = $v.data?.toBuilder();
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityHistoryResponse other) {
    _$v = other as _$ActivityHistoryResponse;
  }

  @override
  void update(void Function(ActivityHistoryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActivityHistoryResponse build() => _build();

  _$ActivityHistoryResponse _build() {
    _$ActivityHistoryResponse _$result;
    try {
      _$result =
          _$v ??
          _$ActivityHistoryResponse._(
            success: success,
            message: message,
            data: _data?.build(),
            pagination: _pagination?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
        _$failedField = 'pagination';
        _pagination?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ActivityHistoryResponse',
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
