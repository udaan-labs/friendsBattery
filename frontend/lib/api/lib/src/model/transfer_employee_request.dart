//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_employee_request.g.dart';

/// TransferEmployeeRequest
///
/// Properties:
/// * [locationId] - Destination shop or warehouse id
@BuiltValue()
abstract class TransferEmployeeRequest implements Built<TransferEmployeeRequest, TransferEmployeeRequestBuilder> {
  /// Destination shop or warehouse id
  @BuiltValueField(wireName: r'location_id')
  int get locationId;

  TransferEmployeeRequest._();

  factory TransferEmployeeRequest([void updates(TransferEmployeeRequestBuilder b)]) = _$TransferEmployeeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransferEmployeeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransferEmployeeRequest> get serializer => _$TransferEmployeeRequestSerializer();
}

class _$TransferEmployeeRequestSerializer implements PrimitiveSerializer<TransferEmployeeRequest> {
  @override
  final Iterable<Type> types = const [TransferEmployeeRequest, _$TransferEmployeeRequest];

  @override
  final String wireName = r'TransferEmployeeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransferEmployeeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'location_id';
    yield serializers.serialize(
      object.locationId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransferEmployeeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransferEmployeeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'location_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.locationId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransferEmployeeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransferEmployeeRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

