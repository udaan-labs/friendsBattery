//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'return_list_product_model.g.dart';

/// ReturnListProductModel
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [productNameId] 
@BuiltValue()
abstract class ReturnListProductModel implements Built<ReturnListProductModel, ReturnListProductModelBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'productNameId')
  String? get productNameId;

  ReturnListProductModel._();

  factory ReturnListProductModel([void updates(ReturnListProductModelBuilder b)]) = _$ReturnListProductModel;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReturnListProductModelBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReturnListProductModel> get serializer => _$ReturnListProductModelSerializer();
}

class _$ReturnListProductModelSerializer implements PrimitiveSerializer<ReturnListProductModel> {
  @override
  final Iterable<Type> types = const [ReturnListProductModel, _$ReturnListProductModel];

  @override
  final String wireName = r'ReturnListProductModel';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReturnListProductModel object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.productNameId != null) {
      yield r'productNameId';
      yield serializers.serialize(
        object.productNameId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReturnListProductModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReturnListProductModelBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'productNameId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  ReturnListProductModel deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReturnListProductModelBuilder();
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

