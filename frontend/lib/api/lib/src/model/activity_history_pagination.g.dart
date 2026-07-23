// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_pagination.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActivityHistoryPagination extends ActivityHistoryPagination {
  @override
  final int? page;
  @override
  final int? limit;
  @override
  final int? totalItems;
  @override
  final int? totalPages;
  @override
  final bool? hasNextPage;

  factory _$ActivityHistoryPagination([
    void Function(ActivityHistoryPaginationBuilder)? updates,
  ]) => (ActivityHistoryPaginationBuilder()..update(updates))._build();

  _$ActivityHistoryPagination._({
    this.page,
    this.limit,
    this.totalItems,
    this.totalPages,
    this.hasNextPage,
  }) : super._();
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
        page == other.page &&
        limit == other.limit &&
        totalItems == other.totalItems &&
        totalPages == other.totalPages &&
        hasNextPage == other.hasNextPage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, totalItems.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, hasNextPage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityHistoryPagination')
          ..add('page', page)
          ..add('limit', limit)
          ..add('totalItems', totalItems)
          ..add('totalPages', totalPages)
          ..add('hasNextPage', hasNextPage))
        .toString();
  }
}

class ActivityHistoryPaginationBuilder
    implements
        Builder<ActivityHistoryPagination, ActivityHistoryPaginationBuilder> {
  _$ActivityHistoryPagination? _$v;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _totalItems;
  int? get totalItems => _$this._totalItems;
  set totalItems(int? totalItems) => _$this._totalItems = totalItems;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  bool? _hasNextPage;
  bool? get hasNextPage => _$this._hasNextPage;
  set hasNextPage(bool? hasNextPage) => _$this._hasNextPage = hasNextPage;

  ActivityHistoryPaginationBuilder() {
    ActivityHistoryPagination._defaults(this);
  }

  ActivityHistoryPaginationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _page = $v.page;
      _limit = $v.limit;
      _totalItems = $v.totalItems;
      _totalPages = $v.totalPages;
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
          page: page,
          limit: limit,
          totalItems: totalItems,
          totalPages: totalPages,
          hasNextPage: hasNextPage,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
