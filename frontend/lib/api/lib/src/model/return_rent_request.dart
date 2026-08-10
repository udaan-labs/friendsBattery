//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'return_rent_request.g.dart';

/// ReturnRentRequest
///
/// Properties:
/// * [serialNumber] 
/// * [rentFee] - Fee taken from deposit; refund = deposit - fee
@BuiltValue()
abstract class ReturnRentRequest implements Built<ReturnRentRequest, ReturnRentRequestBuilder> {
  @BuiltValueField(wireName: r'serial_number')
  String get serialNumber;

  /// Fee taken from deposit; refund = deposit - fee
  @BuiltValueField(wireName: r'rent_fee')
  num get rentFee;

  ReturnRentRequest._();

  factory ReturnRentRequest([void updates(ReturnRentRequestBuilder b)]) = _$ReturnRentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReturnRentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReturnRentRequest> get serializer => _$ReturnRentRequestSerializer();
}

class _$ReturnRentRequestSerializer implements PrimitiveSerializer<ReturnRentRequest> {
  @override
  final Iterable<Type> types = const [ReturnRentRequest, _$ReturnRentRequest];

  @override
  final String wireName = r'ReturnRentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReturnRentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'serial_number';
    yield serializers.serialize(
      object.serialNumber,
      specifiedType: const FullType(String),
    );
    yield r'rent_fee';
    yield serializers.serialize(
      object.rentFee,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReturnRentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReturnRentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'serial_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.serialNumber = valueDes;
          break;
        case r'rent_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.rentFee = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReturnRentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReturnRentRequestBuilder();
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

