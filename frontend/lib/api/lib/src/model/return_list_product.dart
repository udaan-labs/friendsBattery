//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/return_list_product_name.dart';
import 'package:friends_battery_api/src/model/return_list_product_model.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'return_list_product.g.dart';

/// ReturnListProduct
///
/// Properties:
/// * [id] 
/// * [productNameId] 
/// * [productModelId] 
/// * [productName] 
/// * [productModel] 
@BuiltValue()
abstract class ReturnListProduct implements Built<ReturnListProduct, ReturnListProductBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'productNameId')
  String? get productNameId;

  @BuiltValueField(wireName: r'productModelId')
  String? get productModelId;

  @BuiltValueField(wireName: r'productName')
  ReturnListProductName? get productName;

  @BuiltValueField(wireName: r'productModel')
  ReturnListProductModel? get productModel;

  ReturnListProduct._();

  factory ReturnListProduct([void updates(ReturnListProductBuilder b)]) = _$ReturnListProduct;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReturnListProductBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReturnListProduct> get serializer => _$ReturnListProductSerializer();
}

class _$ReturnListProductSerializer implements PrimitiveSerializer<ReturnListProduct> {
  @override
  final Iterable<Type> types = const [ReturnListProduct, _$ReturnListProduct];

  @override
  final String wireName = r'ReturnListProduct';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReturnListProduct object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.productModelId != null) {
      yield r'productModelId';
      yield serializers.serialize(
        object.productModelId,
        specifiedType: const FullType(String),
      );
    }
    if (object.productName != null) {
      yield r'productName';
      yield serializers.serialize(
        object.productName,
        specifiedType: const FullType(ReturnListProductName),
      );
    }
    if (object.productModel != null) {
      yield r'productModel';
      yield serializers.serialize(
        object.productModel,
        specifiedType: const FullType(ReturnListProductModel),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReturnListProduct object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReturnListProductBuilder result,
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
        case r'productNameId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productNameId = valueDes;
          break;
        case r'productModelId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productModelId = valueDes;
          break;
        case r'productName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReturnListProductName),
          ) as ReturnListProductName;
          result.productName.replace(valueDes);
          break;
        case r'productModel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReturnListProductModel),
          ) as ReturnListProductModel;
          result.productModel.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReturnListProduct deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReturnListProductBuilder();
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

