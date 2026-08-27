//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_product_model_request.g.dart';

/// CreateProductModelRequest
///
/// Properties:
/// * [productNameId] 
/// * [name] 
@BuiltValue()
abstract class CreateProductModelRequest implements Built<CreateProductModelRequest, CreateProductModelRequestBuilder> {
  @BuiltValueField(wireName: r'product_name_id')
  int get productNameId;

  @BuiltValueField(wireName: r'name')
  String get name;

  CreateProductModelRequest._();

  factory CreateProductModelRequest([void updates(CreateProductModelRequestBuilder b)]) = _$CreateProductModelRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateProductModelRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateProductModelRequest> get serializer => _$CreateProductModelRequestSerializer();
}

class _$CreateProductModelRequestSerializer implements PrimitiveSerializer<CreateProductModelRequest> {
  @override
  final Iterable<Type> types = const [CreateProductModelRequest, _$CreateProductModelRequest];

  @override
  final String wireName = r'CreateProductModelRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateProductModelRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_name_id';
    yield serializers.serialize(
      object.productNameId,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateProductModelRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateProductModelRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_name_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productNameId = valueDes;
          break;
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
  CreateProductModelRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateProductModelRequestBuilder();
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

