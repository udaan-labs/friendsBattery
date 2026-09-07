// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_return_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateReturnRequestRestockAsEnum
_$createReturnRequestRestockAsEnum_AVAILABLE =
    const CreateReturnRequestRestockAsEnum._('AVAILABLE');
const CreateReturnRequestRestockAsEnum
_$createReturnRequestRestockAsEnum_DEFECTIVE =
    const CreateReturnRequestRestockAsEnum._('DEFECTIVE');

CreateReturnRequestRestockAsEnum _$createReturnRequestRestockAsEnumValueOf(
  String name,
) {
  switch (name) {
    case 'AVAILABLE':
      return _$createReturnRequestRestockAsEnum_AVAILABLE;
    case 'DEFECTIVE':
      return _$createReturnRequestRestockAsEnum_DEFECTIVE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateReturnRequestRestockAsEnum>
_$createReturnRequestRestockAsEnumValues =
    BuiltSet<CreateReturnRequestRestockAsEnum>(
      const <CreateReturnRequestRestockAsEnum>[
        _$createReturnRequestRestockAsEnum_AVAILABLE,
        _$createReturnRequestRestockAsEnum_DEFECTIVE,
      ],
    );

Serializer<CreateReturnRequestRestockAsEnum>
_$createReturnRequestRestockAsEnumSerializer =
    _$CreateReturnRequestRestockAsEnumSerializer();

class _$CreateReturnRequestRestockAsEnumSerializer
    implements PrimitiveSerializer<CreateReturnRequestRestockAsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'AVAILABLE': 'AVAILABLE',
    'DEFECTIVE': 'DEFECTIVE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'AVAILABLE': 'AVAILABLE',
    'DEFECTIVE': 'DEFECTIVE',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateReturnRequestRestockAsEnum];
  @override
  final String wireName = 'CreateReturnRequestRestockAsEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateReturnRequestRestockAsEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateReturnRequestRestockAsEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateReturnRequestRestockAsEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateReturnRequest extends CreateReturnRequest {
  @override
  final String serialNumber;
  @override
  final String reason;
  @override
  final CreateReturnRequestRestockAsEnum? restockAs;

  factory _$CreateReturnRequest([
    void Function(CreateReturnRequestBuilder)? updates,
  ]) => (CreateReturnRequestBuilder()..update(updates))._build();

  _$CreateReturnRequest._({
    required this.serialNumber,
    required this.reason,
    this.restockAs,
  }) : super._();
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
        reason == other.reason &&
        restockAs == other.restockAs;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, restockAs.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateReturnRequest')
          ..add('serialNumber', serialNumber)
          ..add('reason', reason)
          ..add('restockAs', restockAs))
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

  CreateReturnRequestRestockAsEnum? _restockAs;
  CreateReturnRequestRestockAsEnum? get restockAs => _$this._restockAs;
  set restockAs(CreateReturnRequestRestockAsEnum? restockAs) =>
      _$this._restockAs = restockAs;

  CreateReturnRequestBuilder() {
    CreateReturnRequest._defaults(this);
  }

  CreateReturnRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _serialNumber = $v.serialNumber;
      _reason = $v.reason;
      _restockAs = $v.restockAs;
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
          restockAs: restockAs,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
