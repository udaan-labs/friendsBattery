// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_service_bill_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateServiceBillResult extends CreateServiceBillResult {
  @override
  final int? serviceBillId;

  factory _$CreateServiceBillResult([
    void Function(CreateServiceBillResultBuilder)? updates,
  ]) => (CreateServiceBillResultBuilder()..update(updates))._build();

  _$CreateServiceBillResult._({this.serviceBillId}) : super._();
  @override
  CreateServiceBillResult rebuild(
    void Function(CreateServiceBillResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateServiceBillResultBuilder toBuilder() =>
      CreateServiceBillResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateServiceBillResult &&
        serviceBillId == other.serviceBillId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, serviceBillId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'CreateServiceBillResult',
    )..add('serviceBillId', serviceBillId)).toString();
  }
}

class CreateServiceBillResultBuilder
    implements
        Builder<CreateServiceBillResult, CreateServiceBillResultBuilder> {
  _$CreateServiceBillResult? _$v;

  int? _serviceBillId;
  int? get serviceBillId => _$this._serviceBillId;
  set serviceBillId(int? serviceBillId) =>
      _$this._serviceBillId = serviceBillId;

  CreateServiceBillResultBuilder() {
    CreateServiceBillResult._defaults(this);
  }

  CreateServiceBillResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _serviceBillId = $v.serviceBillId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateServiceBillResult other) {
    _$v = other as _$CreateServiceBillResult;
  }

  @override
  void update(void Function(CreateServiceBillResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateServiceBillResult build() => _build();

  _$CreateServiceBillResult _build() {
    final _$result =
        _$v ?? _$CreateServiceBillResult._(serviceBillId: serviceBillId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
