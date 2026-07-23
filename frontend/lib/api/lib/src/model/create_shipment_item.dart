//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_shipment_item.g.dart';

/// CreateShipmentItem
///
/// Properties:
/// * [productNameId] 
/// * [productModelId] 
/// * [serialNumbers] 
/// * [pricePerPiece] 
@BuiltValue()
abstract class CreateShipmentItem implements Built<CreateShipmentItem, CreateShipmentItemBuilder> {
  @BuiltValueField(wireName: r'product_name_id')
  int get productNameId;

  @BuiltValueField(wireName: r'product_model_id')
  int get productModelId;

  @BuiltValueField(wireName: r'serial_numbers')
  BuiltList<String> get serialNumbers;

  @BuiltValueField(wireName: r'price_per_piece')
  num? get pricePerPiece;

  CreateShipmentItem._();

  factory CreateShipmentItem([void updates(CreateShipmentItemBuilder b)]) = _$CreateShipmentItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateShipmentItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateShipmentItem> get serializer => _$CreateShipmentItemSerializer();
}

class _$CreateShipmentItemSerializer implements PrimitiveSerializer<CreateShipmentItem> {
  @override
  final Iterable<Type> types = const [CreateShipmentItem, _$CreateShipmentItem];

  @override
  final String wireName = r'CreateShipmentItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateShipmentItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_name_id';
    yield serializers.serialize(
      object.productNameId,
      specifiedType: const FullType(int),
    );
    yield r'product_model_id';
    yield serializers.serialize(
      object.productModelId,
      specifiedType: const FullType(int),
    );
    yield r'serial_numbers';
    yield serializers.serialize(
      object.serialNumbers,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    if (object.pricePerPiece != null) {
      yield r'price_per_piece';
      yield serializers.serialize(
        object.pricePerPiece,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateShipmentItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateShipmentItemBuilder result,
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
        case r'product_model_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productModelId = valueDes;
          break;
        case r'serial_numbers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.serialNumbers.replace(valueDes);
          break;
        case r'price_per_piece':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.pricePerPiece = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateShipmentItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateShipmentItemBuilder();
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

