// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_sale_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateSaleResult extends CreateSaleResult {
  @override
  final int? transactionId;

  factory _$CreateSaleResult([
    void Function(CreateSaleResultBuilder)? updates,
  ]) => (CreateSaleResultBuilder()..update(updates))._build();

  _$CreateSaleResult._({this.transactionId}) : super._();
  @override
  CreateSaleResult rebuild(void Function(CreateSaleResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateSaleResultBuilder toBuilder() =>
      CreateSaleResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSaleResult && transactionId == other.transactionId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'CreateSaleResult',
    )..add('transactionId', transactionId)).toString();
  }
}

class CreateSaleResultBuilder
    implements Builder<CreateSaleResult, CreateSaleResultBuilder> {
  _$CreateSaleResult? _$v;

  int? _transactionId;
  int? get transactionId => _$this._transactionId;
  set transactionId(int? transactionId) =>
      _$this._transactionId = transactionId;

  CreateSaleResultBuilder() {
    CreateSaleResult._defaults(this);
  }

  CreateSaleResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _transactionId = $v.transactionId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateSaleResult other) {
    _$v = other as _$CreateSaleResult;
  }

  @override
  void update(void Function(CreateSaleResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSaleResult build() => _build();

  _$CreateSaleResult _build() {
    final _$result = _$v ?? _$CreateSaleResult._(transactionId: transactionId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
