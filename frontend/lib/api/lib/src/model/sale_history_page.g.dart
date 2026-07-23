// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_history_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SaleHistoryPage extends SaleHistoryPage {
  @override
  final BuiltList<SaleRecord>? data;
  @override
  final int? total;
  @override
  final int? page;
  @override
  final int? limit;
  @override
  final int? totalPages;

  factory _$SaleHistoryPage([void Function(SaleHistoryPageBuilder)? updates]) =>
      (SaleHistoryPageBuilder()..update(updates))._build();

  _$SaleHistoryPage._({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  }) : super._();
  @override
  SaleHistoryPage rebuild(void Function(SaleHistoryPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SaleHistoryPageBuilder toBuilder() => SaleHistoryPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SaleHistoryPage &&
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
    return (newBuiltValueToStringHelper(r'SaleHistoryPage')
          ..add('data', data)
          ..add('total', total)
          ..add('page', page)
          ..add('limit', limit)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class SaleHistoryPageBuilder
    implements Builder<SaleHistoryPage, SaleHistoryPageBuilder> {
  _$SaleHistoryPage? _$v;

  ListBuilder<SaleRecord>? _data;
  ListBuilder<SaleRecord> get data =>
      _$this._data ??= ListBuilder<SaleRecord>();
  set data(ListBuilder<SaleRecord>? data) => _$this._data = data;

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

  SaleHistoryPageBuilder() {
    SaleHistoryPage._defaults(this);
  }

  SaleHistoryPageBuilder get _$this {
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
  void replace(SaleHistoryPage other) {
    _$v = other as _$SaleHistoryPage;
  }

  @override
  void update(void Function(SaleHistoryPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SaleHistoryPage build() => _build();

  _$SaleHistoryPage _build() {
    _$SaleHistoryPage _$result;
    try {
      _$result =
          _$v ??
          _$SaleHistoryPage._(
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
          r'SaleHistoryPage',
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
