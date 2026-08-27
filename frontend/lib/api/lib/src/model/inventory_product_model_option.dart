//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'inventory_product_model_option.g.dart';

/// InventoryProductModelOption
///
/// Properties:
/// * [id] - Product id
/// * [productModelId] 
/// * [productModel] 
/// * [availableQuantity] 
/// * [minSellPrice] 
@BuiltValue()
abstract class InventoryProductModelOption implements Built<InventoryProductModelOption, InventoryProductModelOptionBuilder> {
  /// Product id
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'productModelId')
  int? get productModelId;

  @BuiltValueField(wireName: r'productModel')
  String? get productModel;

  @BuiltValueField(wireName: r'availableQuantity')
  int? get availableQuantity;

  @BuiltValueField(wireName: r'minSellPrice')
  num? get minSellPrice;

  InventoryProductModelOption._();

  factory InventoryProductModelOption([void updates(InventoryProductModelOptionBuilder b)]) = _$InventoryProductModelOption;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InventoryProductModelOptionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InventoryProductModelOption> get serializer => _$InventoryProductModelOptionSerializer();
}

class _$InventoryProductModelOptionSerializer implements PrimitiveSerializer<InventoryProductModelOption> {
  @override
  final Iterable<Type> types = const [InventoryProductModelOption, _$InventoryProductModelOption];

  @override
  final String wireName = r'InventoryProductModelOption';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InventoryProductModelOption object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.productModelId != null) {
      yield r'productModelId';
      yield serializers.serialize(
        object.productModelId,
        specifiedType: const FullType(int),
      );
    }
    if (object.productModel != null) {
      yield r'productModel';
      yield serializers.serialize(
        object.productModel,
        specifiedType: const FullType(String),
      );
    }
    if (object.availableQuantity != null) {
      yield r'availableQuantity';
      yield serializers.serialize(
        object.availableQuantity,
        specifiedType: const FullType(int),
      );
    }
    if (object.minSellPrice != null) {
      yield r'minSellPrice';
      yield serializers.serialize(
        object.minSellPrice,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InventoryProductModelOption object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InventoryProductModelOptionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'productModelId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productModelId = valueDes;
          break;
        case r'productModel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productModel = valueDes;
          break;
        case r'availableQuantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.availableQuantity = valueDes;
          break;
        case r'minSellPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minSellPrice = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InventoryProductModelOption deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InventoryProductModelOptionBuilder();
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

