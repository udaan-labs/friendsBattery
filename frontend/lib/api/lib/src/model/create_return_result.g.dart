// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_return_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateReturnResult extends CreateReturnResult {
  @override
  final String? message;
  @override
  final String? returnRecordId;
  @override
  final String? productUnitId;
  @override
  final String? status;

  factory _$CreateReturnResult([
    void Function(CreateReturnResultBuilder)? updates,
  ]) => (CreateReturnResultBuilder()..update(updates))._build();

  _$CreateReturnResult._({
    this.message,
    this.returnRecordId,
    this.productUnitId,
    this.status,
  }) : super._();
  @override
  CreateReturnResult rebuild(
    void Function(CreateReturnResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateReturnResultBuilder toBuilder() =>
      CreateReturnResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateReturnResult &&
        message == other.message &&
        returnRecordId == other.returnRecordId &&
        productUnitId == other.productUnitId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, returnRecordId.hashCode);
    _$hash = $jc(_$hash, productUnitId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateReturnResult')
          ..add('message', message)
          ..add('returnRecordId', returnRecordId)
          ..add('productUnitId', productUnitId)
          ..add('status', status))
        .toString();
  }
}

class CreateReturnResultBuilder
    implements Builder<CreateReturnResult, CreateReturnResultBuilder> {
  _$CreateReturnResult? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _returnRecordId;
  String? get returnRecordId => _$this._returnRecordId;
  set returnRecordId(String? returnRecordId) =>
      _$this._returnRecordId = returnRecordId;

  String? _productUnitId;
  String? get productUnitId => _$this._productUnitId;
  set productUnitId(String? productUnitId) =>
      _$this._productUnitId = productUnitId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  CreateReturnResultBuilder() {
    CreateReturnResult._defaults(this);
  }

  CreateReturnResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _returnRecordId = $v.returnRecordId;
      _productUnitId = $v.productUnitId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateReturnResult other) {
    _$v = other as _$CreateReturnResult;
  }

  @override
  void update(void Function(CreateReturnResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateReturnResult build() => _build();

  _$CreateReturnResult _build() {
    final _$result =
        _$v ??
        _$CreateReturnResult._(
          message: message,
          returnRecordId: returnRecordId,
          productUnitId: productUnitId,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
