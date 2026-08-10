//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_service_bill_result.g.dart';

/// CreateServiceBillResult
///
/// Properties:
/// * [serviceBillId] 
@BuiltValue()
abstract class CreateServiceBillResult implements Built<CreateServiceBillResult, CreateServiceBillResultBuilder> {
  @BuiltValueField(wireName: r'service_bill_id')
  int? get serviceBillId;

  CreateServiceBillResult._();

  factory CreateServiceBillResult([void updates(CreateServiceBillResultBuilder b)]) = _$CreateServiceBillResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateServiceBillResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateServiceBillResult> get serializer => _$CreateServiceBillResultSerializer();
}

class _$CreateServiceBillResultSerializer implements PrimitiveSerializer<CreateServiceBillResult> {
  @override
  final Iterable<Type> types = const [CreateServiceBillResult, _$CreateServiceBillResult];

  @override
  final String wireName = r'CreateServiceBillResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateServiceBillResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.serviceBillId != null) {
      yield r'service_bill_id';
      yield serializers.serialize(
        object.serviceBillId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateServiceBillResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateServiceBillResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'service_bill_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.serviceBillId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateServiceBillResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateServiceBillResultBuilder();
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

