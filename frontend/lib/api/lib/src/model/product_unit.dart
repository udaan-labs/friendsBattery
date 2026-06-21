//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_unit.g.dart';

/// ProductUnit
///
/// Properties:
/// * [id] 
/// * [productId] 
/// * [ownerId] 
/// * [serialNumber] 
/// * [status] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class ProductUnit implements Built<ProductUnit, ProductUnitBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'productId')
  String? get productId;

  @BuiltValueField(wireName: r'ownerId')
  String? get ownerId;

  @BuiltValueField(wireName: r'serialNumber')
  String? get serialNumber;

  @BuiltValueField(wireName: r'status')
  ProductUnitStatusEnum? get status;
  // enum statusEnum {  IN_STOCK,  IN_TRANSIT,  SOLD,  RETURNED,  DEFECTIVE,  };

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime? get updatedAt;

  ProductUnit._();

  factory ProductUnit([void updates(ProductUnitBuilder b)]) = _$ProductUnit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductUnitBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductUnit> get serializer => _$ProductUnitSerializer();
}

class _$ProductUnitSerializer implements PrimitiveSerializer<ProductUnit> {
  @override
  final Iterable<Type> types = const [ProductUnit, _$ProductUnit];

  @override
  final String wireName = r'ProductUnit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductUnit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.productId != null) {
      yield r'productId';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(String),
      );
    }
    if (object.ownerId != null) {
      yield r'ownerId';
      yield serializers.serialize(
        object.ownerId,
        specifiedType: const FullType(String),
      );
    }
    if (object.serialNumber != null) {
      yield r'serialNumber';
      yield serializers.serialize(
        object.serialNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ProductUnitStatusEnum),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updatedAt != null) {
      yield r'updatedAt';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProductUnit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductUnitBuilder result,
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
        case r'productId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'ownerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ownerId = valueDes;
          break;
        case r'serialNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.serialNumber = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductUnitStatusEnum),
          ) as ProductUnitStatusEnum;
          result.status = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProductUnit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductUnitBuilder();
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

class ProductUnitStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'IN_STOCK')
  static const ProductUnitStatusEnum IN_STOCK = _$productUnitStatusEnum_IN_STOCK;
  @BuiltValueEnumConst(wireName: r'IN_TRANSIT')
  static const ProductUnitStatusEnum IN_TRANSIT = _$productUnitStatusEnum_IN_TRANSIT;
  @BuiltValueEnumConst(wireName: r'SOLD')
  static const ProductUnitStatusEnum SOLD = _$productUnitStatusEnum_SOLD;
  @BuiltValueEnumConst(wireName: r'RETURNED')
  static const ProductUnitStatusEnum RETURNED = _$productUnitStatusEnum_RETURNED;
  @BuiltValueEnumConst(wireName: r'DEFECTIVE')
  static const ProductUnitStatusEnum DEFECTIVE = _$productUnitStatusEnum_DEFECTIVE;

  static Serializer<ProductUnitStatusEnum> get serializer => _$productUnitStatusEnumSerializer;

  const ProductUnitStatusEnum._(String name): super(name);

  static BuiltSet<ProductUnitStatusEnum> get values => _$productUnitStatusEnumValues;
  static ProductUnitStatusEnum valueOf(String name) => _$productUnitStatusEnumValueOf(name);
}

