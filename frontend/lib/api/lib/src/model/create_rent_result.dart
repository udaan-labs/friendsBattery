//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_rent_result.g.dart';

/// CreateRentResult
///
/// Properties:
/// * [rentId] 
/// * [serialNumber] 
/// * [deposit] 
@BuiltValue()
abstract class CreateRentResult implements Built<CreateRentResult, CreateRentResultBuilder> {
  @BuiltValueField(wireName: r'rent_id')
  int? get rentId;

  @BuiltValueField(wireName: r'serial_number')
  String? get serialNumber;

  @BuiltValueField(wireName: r'deposit')
  num? get deposit;

  CreateRentResult._();

  factory CreateRentResult([void updates(CreateRentResultBuilder b)]) = _$CreateRentResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRentResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRentResult> get serializer => _$CreateRentResultSerializer();
}

class _$CreateRentResultSerializer implements PrimitiveSerializer<CreateRentResult> {
  @override
  final Iterable<Type> types = const [CreateRentResult, _$CreateRentResult];

  @override
  final String wireName = r'CreateRentResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRentResult object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateRentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateRentResultBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateRentResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRentResultBuilder();
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

