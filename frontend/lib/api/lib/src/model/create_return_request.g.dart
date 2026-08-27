// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_return_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateReturnRequest extends CreateReturnRequest {
  @override
  final String serialNumber;
  @override
  final String reason;

  factory _$CreateReturnRequest([
    void Function(CreateReturnRequestBuilder)? updates,
  ]) => (CreateReturnRequestBuilder()..update(updates))._build();

  _$CreateReturnRequest._({required this.serialNumber, required this.reason})
    : super._();
  @override
  CreateReturnRequest rebuild(
    void Function(CreateReturnRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateReturnRequestBuilder toBuilder() =>
      CreateReturnRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateReturnRequest &&
        serialNumber == other.serialNumber &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateReturnRequest')
          ..add('serialNumber', serialNumber)
          ..add('reason', reason))
        .toString();
  }
}

class CreateReturnRequestBuilder
    implements Builder<CreateReturnRequest, CreateReturnRequestBuilder> {
  _$CreateReturnRequest? _$v;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  CreateReturnRequestBuilder() {
    CreateReturnRequest._defaults(this);
  }

  CreateReturnRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _serialNumber = $v.serialNumber;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateReturnRequest other) {
    _$v = other as _$CreateReturnRequest;
  }

  @override
  void update(void Function(CreateReturnRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateReturnRequest build() => _build();

  _$CreateReturnRequest _build() {
    final _$result =
        _$v ??
        _$CreateReturnRequest._(
          serialNumber: BuiltValueNullFieldError.checkNotNull(
            serialNumber,
            r'CreateReturnRequest',
            'serialNumber',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'CreateReturnRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
