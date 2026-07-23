//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_product_name_request.g.dart';

/// CreateProductNameRequest
///
/// Properties:
/// * [name] 
@BuiltValue()
abstract class CreateProductNameRequest implements Built<CreateProductNameRequest, CreateProductNameRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  CreateProductNameRequest._();

  factory CreateProductNameRequest([void updates(CreateProductNameRequestBuilder b)]) = _$CreateProductNameRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateProductNameRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateProductNameRequest> get serializer => _$CreateProductNameRequestSerializer();
}

class _$CreateProductNameRequestSerializer implements PrimitiveSerializer<CreateProductNameRequest> {
  @override
  final Iterable<Type> types = const [CreateProductNameRequest, _$CreateProductNameRequest];

  @override
  final String wireName = r'CreateProductNameRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateProductNameRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateProductNameRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateProductNameRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateProductNameRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateProductNameRequestBuilder();
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

