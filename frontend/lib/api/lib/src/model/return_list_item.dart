//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/return_list_product.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'return_list_item.g.dart';

/// ReturnListItem
///
/// Properties:
/// * [id] 
/// * [transactionId] 
/// * [productId] 
/// * [serialNumber] 
/// * [reason] 
/// * [returnType] 
/// * [returnById] 
/// * [returnToId] 
/// * [createdAt] 
/// * [product] 
@BuiltValue()
abstract class ReturnListItem implements Built<ReturnListItem, ReturnListItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'transactionId')
  String? get transactionId;

  @BuiltValueField(wireName: r'productId')
  String? get productId;

  @BuiltValueField(wireName: r'serialNumber')
  String? get serialNumber;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'returnType')
  String? get returnType;

  @BuiltValueField(wireName: r'returnById')
  String? get returnById;

  @BuiltValueField(wireName: r'returnToId')
  String? get returnToId;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'product')
  ReturnListProduct? get product;

  ReturnListItem._();

  factory ReturnListItem([void updates(ReturnListItemBuilder b)]) = _$ReturnListItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReturnListItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReturnListItem> get serializer => _$ReturnListItemSerializer();
}

class _$ReturnListItemSerializer implements PrimitiveSerializer<ReturnListItem> {
  @override
  final Iterable<Type> types = const [ReturnListItem, _$ReturnListItem];

  @override
  final String wireName = r'ReturnListItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReturnListItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.transactionId != null) {
      yield r'transactionId';
      yield serializers.serialize(
        object.transactionId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.productId != null) {
      yield r'productId';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.serialNumber != null) {
      yield r'serialNumber';
      yield serializers.serialize(
        object.serialNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.returnType != null) {
      yield r'returnType';
      yield serializers.serialize(
        object.returnType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.returnById != null) {
      yield r'returnById';
      yield serializers.serialize(
        object.returnById,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.returnToId != null) {
      yield r'returnToId';
      yield serializers.serialize(
        object.returnToId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.product != null) {
      yield r'product';
      yield serializers.serialize(
        object.product,
        specifiedType: const FullType(ReturnListProduct),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReturnListItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReturnListItemBuilder result,
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
        case r'transactionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.transactionId = valueDes;
          break;
        case r'productId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.productId = valueDes;
          break;
        case r'serialNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.serialNumber = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'returnType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.returnType = valueDes;
          break;
        case r'returnById':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.returnById = valueDes;
          break;
        case r'returnToId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.returnToId = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'product':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReturnListProduct),
          ) as ReturnListProduct;
          result.product.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReturnListItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReturnListItemBuilder();
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

