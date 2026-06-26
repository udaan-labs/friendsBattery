//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_shipments_id_get200_response_data_items_inner.g.dart';

/// ApiShipmentsIdGet200ResponseDataItemsInner
///
/// Properties:
/// * [id] 
/// * [category] 
/// * [productGroup] 
/// * [productName] 
/// * [productModel] 
/// * [quantity] 
/// * [serialNumber] 
@BuiltValue()
abstract class ApiShipmentsIdGet200ResponseDataItemsInner implements Built<ApiShipmentsIdGet200ResponseDataItemsInner, ApiShipmentsIdGet200ResponseDataItemsInnerBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'productGroup')
  String? get productGroup;

  @BuiltValueField(wireName: r'productName')
  String? get productName;

  @BuiltValueField(wireName: r'productModel')
  String? get productModel;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  @BuiltValueField(wireName: r'serialNumber')
  String? get serialNumber;

  ApiShipmentsIdGet200ResponseDataItemsInner._();

  factory ApiShipmentsIdGet200ResponseDataItemsInner([void updates(ApiShipmentsIdGet200ResponseDataItemsInnerBuilder b)]) = _$ApiShipmentsIdGet200ResponseDataItemsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiShipmentsIdGet200ResponseDataItemsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiShipmentsIdGet200ResponseDataItemsInner> get serializer => _$ApiShipmentsIdGet200ResponseDataItemsInnerSerializer();
}

class _$ApiShipmentsIdGet200ResponseDataItemsInnerSerializer implements PrimitiveSerializer<ApiShipmentsIdGet200ResponseDataItemsInner> {
  @override
  final Iterable<Type> types = const [ApiShipmentsIdGet200ResponseDataItemsInner, _$ApiShipmentsIdGet200ResponseDataItemsInner];

  @override
  final String wireName = r'ApiShipmentsIdGet200ResponseDataItemsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiShipmentsIdGet200ResponseDataItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    if (object.productGroup != null) {
      yield r'productGroup';
      yield serializers.serialize(
        object.productGroup,
        specifiedType: const FullType(String),
      );
    }
    if (object.productName != null) {
      yield r'productName';
      yield serializers.serialize(
        object.productName,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.serialNumber != null) {
      yield r'serialNumber';
      yield serializers.serialize(
        object.serialNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiShipmentsIdGet200ResponseDataItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiShipmentsIdGet200ResponseDataItemsInnerBuilder result,
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
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'productGroup':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productGroup = valueDes;
          break;
        case r'productName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productName = valueDes;
          break;
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
        case r'serialNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.serialNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiShipmentsIdGet200ResponseDataItemsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiShipmentsIdGet200ResponseDataItemsInnerBuilder();
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

