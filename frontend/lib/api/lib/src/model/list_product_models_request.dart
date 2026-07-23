//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_product_models_request.g.dart';

/// ListProductModelsRequest
///
/// Properties:
/// * [productNameId] 
@BuiltValue()
abstract class ListProductModelsRequest implements Built<ListProductModelsRequest, ListProductModelsRequestBuilder> {
  @BuiltValueField(wireName: r'product_name_id')
  int get productNameId;

  ListProductModelsRequest._();

  factory ListProductModelsRequest([void updates(ListProductModelsRequestBuilder b)]) = _$ListProductModelsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListProductModelsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListProductModelsRequest> get serializer => _$ListProductModelsRequestSerializer();
}

class _$ListProductModelsRequestSerializer implements PrimitiveSerializer<ListProductModelsRequest> {
  @override
  final Iterable<Type> types = const [ListProductModelsRequest, _$ListProductModelsRequest];

  @override
  final String wireName = r'ListProductModelsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListProductModelsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_name_id';
    yield serializers.serialize(
      object.productNameId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListProductModelsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListProductModelsRequestBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ListProductModelsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListProductModelsRequestBuilder();
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

