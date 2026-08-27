// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_employee_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransferEmployeeRequest extends TransferEmployeeRequest {
  @override
  final int locationId;

  factory _$TransferEmployeeRequest([
    void Function(TransferEmployeeRequestBuilder)? updates,
  ]) => (TransferEmployeeRequestBuilder()..update(updates))._build();

  _$TransferEmployeeRequest._({required this.locationId}) : super._();
  @override
  TransferEmployeeRequest rebuild(
    void Function(TransferEmployeeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TransferEmployeeRequestBuilder toBuilder() =>
      TransferEmployeeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransferEmployeeRequest && locationId == other.locationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'TransferEmployeeRequest',
    )..add('locationId', locationId)).toString();
  }
}

class TransferEmployeeRequestBuilder
    implements
        Builder<TransferEmployeeRequest, TransferEmployeeRequestBuilder> {
  _$TransferEmployeeRequest? _$v;

  int? _locationId;
  int? get locationId => _$this._locationId;
  set locationId(int? locationId) => _$this._locationId = locationId;

  TransferEmployeeRequestBuilder() {
    TransferEmployeeRequest._defaults(this);
  }

  TransferEmployeeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _locationId = $v.locationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransferEmployeeRequest other) {
    _$v = other as _$TransferEmployeeRequest;
  }

  @override
  void update(void Function(TransferEmployeeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransferEmployeeRequest build() => _build();

  _$TransferEmployeeRequest _build() {
    final _$result =
        _$v ??
        _$TransferEmployeeRequest._(
          locationId: BuiltValueNullFieldError.checkNotNull(
            locationId,
            r'TransferEmployeeRequest',
            'locationId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
