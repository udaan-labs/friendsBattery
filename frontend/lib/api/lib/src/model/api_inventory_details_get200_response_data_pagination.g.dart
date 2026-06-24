// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_details_get200_response_data_pagination.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryDetailsGet200ResponseDataPagination
    extends ApiInventoryDetailsGet200ResponseDataPagination {
  @override
  final int? total;
  @override
  final int? page;
  @override
  final int? limit;
  @override
  final int? totalPages;

  factory _$ApiInventoryDetailsGet200ResponseDataPagination([
    void Function(ApiInventoryDetailsGet200ResponseDataPaginationBuilder)?
    updates,
  ]) =>
      (ApiInventoryDetailsGet200ResponseDataPaginationBuilder()
            ..update(updates))
          ._build();

  _$ApiInventoryDetailsGet200ResponseDataPagination._({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  }) : super._();
  @override
  ApiInventoryDetailsGet200ResponseDataPagination rebuild(
    void Function(ApiInventoryDetailsGet200ResponseDataPaginationBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryDetailsGet200ResponseDataPaginationBuilder toBuilder() =>
      ApiInventoryDetailsGet200ResponseDataPaginationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryDetailsGet200ResponseDataPagination &&
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
    return (newBuiltValueToStringHelper(
            r'ApiInventoryDetailsGet200ResponseDataPagination',
          )
          ..add('total', total)
          ..add('page', page)
          ..add('limit', limit)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class ApiInventoryDetailsGet200ResponseDataPaginationBuilder
    implements
        Builder<
          ApiInventoryDetailsGet200ResponseDataPagination,
          ApiInventoryDetailsGet200ResponseDataPaginationBuilder
        > {
  _$ApiInventoryDetailsGet200ResponseDataPagination? _$v;

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

  ApiInventoryDetailsGet200ResponseDataPaginationBuilder() {
    ApiInventoryDetailsGet200ResponseDataPagination._defaults(this);
  }

  ApiInventoryDetailsGet200ResponseDataPaginationBuilder get _$this {
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
  void replace(ApiInventoryDetailsGet200ResponseDataPagination other) {
    _$v = other as _$ApiInventoryDetailsGet200ResponseDataPagination;
  }

  @override
  void update(
    void Function(ApiInventoryDetailsGet200ResponseDataPaginationBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryDetailsGet200ResponseDataPagination build() => _build();

  _$ApiInventoryDetailsGet200ResponseDataPagination _build() {
    final _$result =
        _$v ??
        _$ApiInventoryDetailsGet200ResponseDataPagination._(
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
