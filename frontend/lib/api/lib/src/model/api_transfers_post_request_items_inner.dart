//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_transfers_post_request_items_inner.g.dart';

/// ApiTransfersPostRequestItemsInner
///
/// Properties:
/// * [productId] 
/// * [quantity] 
/// * [pricePerPiece] 
@BuiltValue()
abstract class ApiTransfersPostRequestItemsInner implements Built<ApiTransfersPostRequestItemsInner, ApiTransfersPostRequestItemsInnerBuilder> {
  @BuiltValueField(wireName: r'product_id')
  int? get productId;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  @BuiltValueField(wireName: r'price_per_piece')
  num? get pricePerPiece;

  ApiTransfersPostRequestItemsInner._();

  factory ApiTransfersPostRequestItemsInner([void updates(ApiTransfersPostRequestItemsInnerBuilder b)]) = _$ApiTransfersPostRequestItemsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiTransfersPostRequestItemsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiTransfersPostRequestItemsInner> get serializer => _$ApiTransfersPostRequestItemsInnerSerializer();
}

class _$ApiTransfersPostRequestItemsInnerSerializer implements PrimitiveSerializer<ApiTransfersPostRequestItemsInner> {
  @override
  final Iterable<Type> types = const [ApiTransfersPostRequestItemsInner, _$ApiTransfersPostRequestItemsInner];

  @override
  final String wireName = r'ApiTransfersPostRequestItemsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiTransfersPostRequestItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productId != null) {
      yield r'product_id';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(int),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(int),
      );
    }
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
    ApiTransfersPostRequestItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiTransfersPostRequestItemsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productId = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.quantity = valueDes;
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
  ApiTransfersPostRequestItemsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiTransfersPostRequestItemsInnerBuilder();
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

