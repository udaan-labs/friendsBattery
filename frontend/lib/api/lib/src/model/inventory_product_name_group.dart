//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/inventory_product_model_option.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'inventory_product_name_group.g.dart';

/// InventoryProductNameGroup
///
/// Properties:
/// * [productName] 
/// * [productNameId] 
/// * [models] 
@BuiltValue()
abstract class InventoryProductNameGroup implements Built<InventoryProductNameGroup, InventoryProductNameGroupBuilder> {
  @BuiltValueField(wireName: r'productName')
  String? get productName;

  @BuiltValueField(wireName: r'productNameId')
  int? get productNameId;

  @BuiltValueField(wireName: r'models')
  BuiltList<InventoryProductModelOption>? get models;

  InventoryProductNameGroup._();

  factory InventoryProductNameGroup([void updates(InventoryProductNameGroupBuilder b)]) = _$InventoryProductNameGroup;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InventoryProductNameGroupBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InventoryProductNameGroup> get serializer => _$InventoryProductNameGroupSerializer();
}

class _$InventoryProductNameGroupSerializer implements PrimitiveSerializer<InventoryProductNameGroup> {
  @override
  final Iterable<Type> types = const [InventoryProductNameGroup, _$InventoryProductNameGroup];

  @override
  final String wireName = r'InventoryProductNameGroup';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InventoryProductNameGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productName != null) {
      yield r'productName';
      yield serializers.serialize(
        object.productName,
        specifiedType: const FullType(String),
      );
    }
    if (object.productNameId != null) {
      yield r'productNameId';
      yield serializers.serialize(
        object.productNameId,
        specifiedType: const FullType(int),
      );
    }
    if (object.models != null) {
      yield r'models';
      yield serializers.serialize(
        object.models,
        specifiedType: const FullType(BuiltList, [FullType(InventoryProductModelOption)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InventoryProductNameGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InventoryProductNameGroupBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'productName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productName = valueDes;
          break;
        case r'productNameId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productNameId = valueDes;
          break;
        case r'models':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(InventoryProductModelOption)]),
          ) as BuiltList<InventoryProductModelOption>;
          result.models.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InventoryProductNameGroup deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InventoryProductNameGroupBuilder();
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

