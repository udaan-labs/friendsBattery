// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_shipment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateShipmentRequest extends CreateShipmentRequest {
  @override
  final int sellerId;
  @override
  final BuiltList<String> serialNumbers;

  factory _$CreateShipmentRequest([
    void Function(CreateShipmentRequestBuilder)? updates,
  ]) => (CreateShipmentRequestBuilder()..update(updates))._build();

  _$CreateShipmentRequest._({
    required this.sellerId,
    required this.serialNumbers,
  }) : super._();
  @override
  CreateShipmentRequest rebuild(
    void Function(CreateShipmentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateShipmentRequestBuilder toBuilder() =>
      CreateShipmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateShipmentRequest &&
        sellerId == other.sellerId &&
        serialNumbers == other.serialNumbers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sellerId.hashCode);
    _$hash = $jc(_$hash, serialNumbers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateShipmentRequest')
          ..add('sellerId', sellerId)
          ..add('serialNumbers', serialNumbers))
        .toString();
  }
}

class CreateShipmentRequestBuilder
    implements Builder<CreateShipmentRequest, CreateShipmentRequestBuilder> {
  _$CreateShipmentRequest? _$v;

  int? _sellerId;
  int? get sellerId => _$this._sellerId;
  set sellerId(int? sellerId) => _$this._sellerId = sellerId;

  ListBuilder<String>? _serialNumbers;
  ListBuilder<String> get serialNumbers =>
      _$this._serialNumbers ??= ListBuilder<String>();
  set serialNumbers(ListBuilder<String>? serialNumbers) =>
      _$this._serialNumbers = serialNumbers;

  CreateShipmentRequestBuilder() {
    CreateShipmentRequest._defaults(this);
  }

  CreateShipmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sellerId = $v.sellerId;
      _serialNumbers = $v.serialNumbers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateShipmentRequest other) {
    _$v = other as _$CreateShipmentRequest;
  }

  @override
  void update(void Function(CreateShipmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateShipmentRequest build() => _build();

  _$CreateShipmentRequest _build() {
    _$CreateShipmentRequest _$result;
    try {
      _$result =
          _$v ??
          _$CreateShipmentRequest._(
            sellerId: BuiltValueNullFieldError.checkNotNull(
              sellerId,
              r'CreateShipmentRequest',
              'sellerId',
            ),
            serialNumbers: serialNumbers.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'serialNumbers';
        serialNumbers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreateShipmentRequest',
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
