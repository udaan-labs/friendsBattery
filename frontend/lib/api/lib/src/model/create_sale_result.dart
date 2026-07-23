//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_sale_result.g.dart';

/// CreateSaleResult
///
/// Properties:
/// * [transactionId] 
@BuiltValue()
abstract class CreateSaleResult implements Built<CreateSaleResult, CreateSaleResultBuilder> {
  @BuiltValueField(wireName: r'transaction_id')
  int? get transactionId;

  CreateSaleResult._();

  factory CreateSaleResult([void updates(CreateSaleResultBuilder b)]) = _$CreateSaleResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateSaleResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateSaleResult> get serializer => _$CreateSaleResultSerializer();
}

class _$CreateSaleResultSerializer implements PrimitiveSerializer<CreateSaleResult> {
  @override
  final Iterable<Type> types = const [CreateSaleResult, _$CreateSaleResult];

  @override
  final String wireName = r'CreateSaleResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateSaleResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.transactionId != null) {
      yield r'transaction_id';
      yield serializers.serialize(
        object.transactionId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateSaleResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateSaleResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'transaction_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.transactionId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateSaleResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateSaleResultBuilder();
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

