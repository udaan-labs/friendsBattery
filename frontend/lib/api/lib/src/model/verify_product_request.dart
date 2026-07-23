//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_product_request.g.dart';

/// VerifyProductRequest
///
/// Properties:
/// * [identifier] 
@BuiltValue()
abstract class VerifyProductRequest implements Built<VerifyProductRequest, VerifyProductRequestBuilder> {
  @BuiltValueField(wireName: r'identifier')
  String get identifier;

  VerifyProductRequest._();

  factory VerifyProductRequest([void updates(VerifyProductRequestBuilder b)]) = _$VerifyProductRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VerifyProductRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VerifyProductRequest> get serializer => _$VerifyProductRequestSerializer();
}

class _$VerifyProductRequestSerializer implements PrimitiveSerializer<VerifyProductRequest> {
  @override
  final Iterable<Type> types = const [VerifyProductRequest, _$VerifyProductRequest];

  @override
  final String wireName = r'VerifyProductRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VerifyProductRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'identifier';
    yield serializers.serialize(
      object.identifier,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    VerifyProductRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VerifyProductRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'identifier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.identifier = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VerifyProductRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerifyProductRequestBuilder();
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

