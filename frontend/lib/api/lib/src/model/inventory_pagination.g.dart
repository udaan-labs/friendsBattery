// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_pagination.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InventoryPagination extends InventoryPagination {
  @override
  final int? total;
  @override
  final int? page;
  @override
  final int? limit;
  @override
  final int? totalPages;

  factory _$InventoryPagination([
    void Function(InventoryPaginationBuilder)? updates,
  ]) => (InventoryPaginationBuilder()..update(updates))._build();

  _$InventoryPagination._({this.total, this.page, this.limit, this.totalPages})
    : super._();
  @override
  InventoryPagination rebuild(
    void Function(InventoryPaginationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InventoryPaginationBuilder toBuilder() =>
      InventoryPaginationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InventoryPagination &&
        total == other.total &&
        page == other.page &&
        limit == other.limit &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InventoryPagination')
          ..add('total', total)
          ..add('page', page)
          ..add('limit', limit)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class InventoryPaginationBuilder
    implements Builder<InventoryPagination, InventoryPaginationBuilder> {
  _$InventoryPagination? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  InventoryPaginationBuilder() {
    InventoryPagination._defaults(this);
  }

  InventoryPaginationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _page = $v.page;
      _limit = $v.limit;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InventoryPagination other) {
    _$v = other as _$InventoryPagination;
  }

  @override
  void update(void Function(InventoryPaginationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InventoryPagination build() => _build();

  _$InventoryPagination _build() {
    final _$result =
        _$v ??
        _$InventoryPagination._(
          total: total,
          page: page,
          limit: limit,
          totalPages: totalPages,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
