//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pay_credit_request.g.dart';

/// PayCreditRequest
///
/// Properties:
/// * [amount] - Amount to collect against remaining due
@BuiltValue()
abstract class PayCreditRequest implements Built<PayCreditRequest, PayCreditRequestBuilder> {
  /// Amount to collect against remaining due
  @BuiltValueField(wireName: r'amount')
  num get amount;

  PayCreditRequest._();

  factory PayCreditRequest([void updates(PayCreditRequestBuilder b)]) = _$PayCreditRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayCreditRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayCreditRequest> get serializer => _$PayCreditRequestSerializer();
}

class _$PayCreditRequestSerializer implements PrimitiveSerializer<PayCreditRequest> {
  @override
  final Iterable<Type> types = const [PayCreditRequest, _$PayCreditRequest];

  @override
  final String wireName = r'PayCreditRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayCreditRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PayCreditRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayCreditRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PayCreditRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayCreditRequestBuilder();
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

