//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/product_stock_details.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_stock_details_response.g.dart';

/// ProductStockDetailsResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ProductStockDetailsResponse implements Built<ProductStockDetailsResponse, ProductStockDetailsResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  ProductStockDetails? get data;

  ProductStockDetailsResponse._();

  factory ProductStockDetailsResponse([void updates(ProductStockDetailsResponseBuilder b)]) = _$ProductStockDetailsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductStockDetailsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductStockDetailsResponse> get serializer => _$ProductStockDetailsResponseSerializer();
}

class _$ProductStockDetailsResponseSerializer implements PrimitiveSerializer<ProductStockDetailsResponse> {
  @override
  final Iterable<Type> types = const [ProductStockDetailsResponse, _$ProductStockDetailsResponse];

  @override
  final String wireName = r'ProductStockDetailsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductStockDetailsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(ProductStockDetails),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProductStockDetailsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductStockDetailsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductStockDetails),
          ) as ProductStockDetails;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProductStockDetailsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductStockDetailsResponseBuilder();
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

