//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_return_request.g.dart';

/// CreateReturnRequest
///
/// Properties:
/// * [serialNumber] 
/// * [reason] 
@BuiltValue()
abstract class CreateReturnRequest implements Built<CreateReturnRequest, CreateReturnRequestBuilder> {
  @BuiltValueField(wireName: r'serial_number')
  String get serialNumber;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  CreateReturnRequest._();

  factory CreateReturnRequest([void updates(CreateReturnRequestBuilder b)]) = _$CreateReturnRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateReturnRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateReturnRequest> get serializer => _$CreateReturnRequestSerializer();
}

class _$CreateReturnRequestSerializer implements PrimitiveSerializer<CreateReturnRequest> {
  @override
  final Iterable<Type> types = const [CreateReturnRequest, _$CreateReturnRequest];

  @override
  final String wireName = r'CreateReturnRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateReturnRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'serial_number';
    yield serializers.serialize(
      object.serialNumber,
      specifiedType: const FullType(String),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateReturnRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateReturnRequestBuilder result,
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
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateReturnRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateReturnRequestBuilder();
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

