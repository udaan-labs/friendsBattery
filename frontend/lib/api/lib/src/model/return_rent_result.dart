//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'return_rent_result.g.dart';

/// ReturnRentResult
///
/// Properties:
/// * [rentId] 
/// * [serialNumber] 
/// * [deposit] 
/// * [rentFee] 
/// * [refundAmount] 
/// * [customerName] 
/// * [customerNumber] 
@BuiltValue()
abstract class ReturnRentResult implements Built<ReturnRentResult, ReturnRentResultBuilder> {
  @BuiltValueField(wireName: r'rent_id')
  int? get rentId;

  @BuiltValueField(wireName: r'serial_number')
  String? get serialNumber;

  @BuiltValueField(wireName: r'deposit')
  num? get deposit;

  @BuiltValueField(wireName: r'rent_fee')
  num? get rentFee;

  @BuiltValueField(wireName: r'refund_amount')
  num? get refundAmount;

  @BuiltValueField(wireName: r'customer_name')
  String? get customerName;

  @BuiltValueField(wireName: r'customer_number')
  String? get customerNumber;

  ReturnRentResult._();

  factory ReturnRentResult([void updates(ReturnRentResultBuilder b)]) = _$ReturnRentResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReturnRentResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReturnRentResult> get serializer => _$ReturnRentResultSerializer();
}

class _$ReturnRentResultSerializer implements PrimitiveSerializer<ReturnRentResult> {
  @override
  final Iterable<Type> types = const [ReturnRentResult, _$ReturnRentResult];

  @override
  final String wireName = r'ReturnRentResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReturnRentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.rentId != null) {
      yield r'rent_id';
      yield serializers.serialize(
        object.rentId,
        specifiedType: const FullType(int),
      );
    }
    if (object.serialNumber != null) {
      yield r'serial_number';
      yield serializers.serialize(
        object.serialNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.deposit != null) {
      yield r'deposit';
      yield serializers.serialize(
        object.deposit,
        specifiedType: const FullType(num),
      );
    }
    if (object.rentFee != null) {
      yield r'rent_fee';
      yield serializers.serialize(
        object.rentFee,
        specifiedType: const FullType(num),
      );
    }
    if (object.refundAmount != null) {
      yield r'refund_amount';
      yield serializers.serialize(
        object.refundAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.customerName != null) {
      yield r'customer_name';
      yield serializers.serialize(
        object.customerName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.customerNumber != null) {
      yield r'customer_number';
      yield serializers.serialize(
        object.customerNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReturnRentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReturnRentResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rent_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.rentId = valueDes;
          break;
        case r'serial_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.serialNumber = valueDes;
          break;
        case r'deposit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.deposit = valueDes;
          break;
        case r'rent_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.rentFee = valueDes;
          break;
        case r'refund_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.refundAmount = valueDes;
          break;
        case r'customer_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.customerName = valueDes;
          break;
        case r'customer_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.customerNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReturnRentResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReturnRentResultBuilder();
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

