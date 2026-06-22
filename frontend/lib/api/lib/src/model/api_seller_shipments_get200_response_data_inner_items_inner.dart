//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_seller_shipments_get200_response_data_inner_items_inner.g.dart';

/// ApiSellerShipmentsGet200ResponseDataInnerItemsInner
///
/// Properties:
/// * [productModel] 
/// * [quantity] 
@BuiltValue()
abstract class ApiSellerShipmentsGet200ResponseDataInnerItemsInner implements Built<ApiSellerShipmentsGet200ResponseDataInnerItemsInner, ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder> {
  @BuiltValueField(wireName: r'productModel')
  String? get productModel;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  ApiSellerShipmentsGet200ResponseDataInnerItemsInner._();

  factory ApiSellerShipmentsGet200ResponseDataInnerItemsInner([void updates(ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder b)]) = _$ApiSellerShipmentsGet200ResponseDataInnerItemsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiSellerShipmentsGet200ResponseDataInnerItemsInner> get serializer => _$ApiSellerShipmentsGet200ResponseDataInnerItemsInnerSerializer();
}

class _$ApiSellerShipmentsGet200ResponseDataInnerItemsInnerSerializer implements PrimitiveSerializer<ApiSellerShipmentsGet200ResponseDataInnerItemsInner> {
  @override
  final Iterable<Type> types = const [ApiSellerShipmentsGet200ResponseDataInnerItemsInner, _$ApiSellerShipmentsGet200ResponseDataInnerItemsInner];

  @override
  final String wireName = r'ApiSellerShipmentsGet200ResponseDataInnerItemsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiSellerShipmentsGet200ResponseDataInnerItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productModel != null) {
      yield r'productModel';
      yield serializers.serialize(
        object.productModel,
        specifiedType: const FullType(String),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiSellerShipmentsGet200ResponseDataInnerItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'productModel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productModel = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.quantity = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiSellerShipmentsGet200ResponseDataInnerItemsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder();
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

