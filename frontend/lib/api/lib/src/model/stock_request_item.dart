//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stock_request_item.g.dart';

/// StockRequestItem
///
/// Properties:
/// * [id] 
/// * [stockRequestId] 
/// * [productId] 
/// * [requestedQuantity] 
@BuiltValue()
abstract class StockRequestItem implements Built<StockRequestItem, StockRequestItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'stockRequestId')
  String? get stockRequestId;

  @BuiltValueField(wireName: r'productId')
  String? get productId;

  @BuiltValueField(wireName: r'requestedQuantity')
  int? get requestedQuantity;

  StockRequestItem._();

  factory StockRequestItem([void updates(StockRequestItemBuilder b)]) = _$StockRequestItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StockRequestItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StockRequestItem> get serializer => _$StockRequestItemSerializer();
}

class _$StockRequestItemSerializer implements PrimitiveSerializer<StockRequestItem> {
  @override
  final Iterable<Type> types = const [StockRequestItem, _$StockRequestItem];

  @override
  final String wireName = r'StockRequestItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StockRequestItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.stockRequestId != null) {
      yield r'stockRequestId';
      yield serializers.serialize(
        object.stockRequestId,
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
    if (object.requestedQuantity != null) {
      yield r'requestedQuantity';
      yield serializers.serialize(
        object.requestedQuantity,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StockRequestItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StockRequestItemBuilder result,
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
        case r'stockRequestId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.stockRequestId = valueDes;
          break;
        case r'productId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'requestedQuantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.requestedQuantity = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StockRequestItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StockRequestItemBuilder();
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

