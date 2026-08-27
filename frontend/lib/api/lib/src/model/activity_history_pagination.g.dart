// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_pagination.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActivityHistoryPagination extends ActivityHistoryPagination {
  @override
  final int? limit;
  @override
  final String? nextCursor;
  @override
  final bool? hasNextPage;

  factory _$ActivityHistoryPagination([
    void Function(ActivityHistoryPaginationBuilder)? updates,
  ]) => (ActivityHistoryPaginationBuilder()..update(updates))._build();

  _$ActivityHistoryPagination._({this.limit, this.nextCursor, this.hasNextPage})
    : super._();
  @override
  ActivityHistoryPagination rebuild(
    void Function(ActivityHistoryPaginationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ActivityHistoryPaginationBuilder toBuilder() =>
      ActivityHistoryPaginationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityHistoryPagination &&
        limit == other.limit &&
        nextCursor == other.nextCursor &&
        hasNextPage == other.hasNextPage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, hasNextPage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityHistoryPagination')
          ..add('limit', limit)
          ..add('nextCursor', nextCursor)
          ..add('hasNextPage', hasNextPage))
        .toString();
  }
}

class ActivityHistoryPaginationBuilder
    implements
        Builder<ActivityHistoryPagination, ActivityHistoryPaginationBuilder> {
  _$ActivityHistoryPagination? _$v;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(String? nextCursor) => _$this._nextCursor = nextCursor;

  bool? _hasNextPage;
  bool? get hasNextPage => _$this._hasNextPage;
  set hasNextPage(bool? hasNextPage) => _$this._hasNextPage = hasNextPage;

  ActivityHistoryPaginationBuilder() {
    ActivityHistoryPagination._defaults(this);
  }

  ActivityHistoryPaginationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _limit = $v.limit;
      _nextCursor = $v.nextCursor;
      _hasNextPage = $v.hasNextPage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityHistoryPagination other) {
    _$v = other as _$ActivityHistoryPagination;
  }

  @override
  void update(void Function(ActivityHistoryPaginationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActivityHistoryPagination build() => _build();

  _$ActivityHistoryPagination _build() {
    final _$result =
        _$v ??
        _$ActivityHistoryPagination._(
          limit: limit,
          nextCursor: nextCursor,
          hasNextPage: hasNextPage,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
