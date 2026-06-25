//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_products_categories_list_post_request.g.dart';

/// ApiProductsCategoriesListPostRequest
///
/// Properties:
/// * [groupId] 
@BuiltValue()
abstract class ApiProductsCategoriesListPostRequest implements Built<ApiProductsCategoriesListPostRequest, ApiProductsCategoriesListPostRequestBuilder> {
  @BuiltValueField(wireName: r'group_id')
  int? get groupId;

  ApiProductsCategoriesListPostRequest._();

  factory ApiProductsCategoriesListPostRequest([void updates(ApiProductsCategoriesListPostRequestBuilder b)]) = _$ApiProductsCategoriesListPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiProductsCategoriesListPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiProductsCategoriesListPostRequest> get serializer => _$ApiProductsCategoriesListPostRequestSerializer();
}

class _$ApiProductsCategoriesListPostRequestSerializer implements PrimitiveSerializer<ApiProductsCategoriesListPostRequest> {
  @override
  final Iterable<Type> types = const [ApiProductsCategoriesListPostRequest, _$ApiProductsCategoriesListPostRequest];

  @override
  final String wireName = r'ApiProductsCategoriesListPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiProductsCategoriesListPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.groupId != null) {
      yield r'group_id';
      yield serializers.serialize(
        object.groupId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiProductsCategoriesListPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiProductsCategoriesListPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'group_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.groupId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiProductsCategoriesListPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiProductsCategoriesListPostRequestBuilder();
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

