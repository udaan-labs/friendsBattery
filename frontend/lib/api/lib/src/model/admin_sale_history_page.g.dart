// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_sale_history_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminSaleHistoryPage extends AdminSaleHistoryPage {
  @override
  final BuiltList<AdminSaleRecord>? data;
  @override
  final int? total;
  @override
  final int? page;
  @override
  final int? limit;
  @override
  final int? totalPages;

  factory _$AdminSaleHistoryPage([
    void Function(AdminSaleHistoryPageBuilder)? updates,
  ]) => (AdminSaleHistoryPageBuilder()..update(updates))._build();

  _$AdminSaleHistoryPage._({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  }) : super._();
  @override
  AdminSaleHistoryPage rebuild(
    void Function(AdminSaleHistoryPageBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminSaleHistoryPageBuilder toBuilder() =>
      AdminSaleHistoryPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminSaleHistoryPage &&
        data == other.data &&
        total == other.total &&
        page == other.page &&
        limit == other.limit &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminSaleHistoryPage')
          ..add('data', data)
          ..add('total', total)
          ..add('page', page)
          ..add('limit', limit)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class AdminSaleHistoryPageBuilder
    implements Builder<AdminSaleHistoryPage, AdminSaleHistoryPageBuilder> {
  _$AdminSaleHistoryPage? _$v;

  ListBuilder<AdminSaleRecord>? _data;
  ListBuilder<AdminSaleRecord> get data =>
      _$this._data ??= ListBuilder<AdminSaleRecord>();
  set data(ListBuilder<AdminSaleRecord>? data) => _$this._data = data;

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

  AdminSaleHistoryPageBuilder() {
    AdminSaleHistoryPage._defaults(this);
  }

  AdminSaleHistoryPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _total = $v.total;
      _page = $v.page;
      _limit = $v.limit;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminSaleHistoryPage other) {
    _$v = other as _$AdminSaleHistoryPage;
  }

  @override
  void update(void Function(AdminSaleHistoryPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminSaleHistoryPage build() => _build();

  _$AdminSaleHistoryPage _build() {
    _$AdminSaleHistoryPage _$result;
    try {
      _$result =
          _$v ??
          _$AdminSaleHistoryPage._(
            data: _data?.build(),
            total: total,
            page: page,
            limit: limit,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminSaleHistoryPage',
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
