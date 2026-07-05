//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_details_get200_response_data_categories_inner_subcategories_inner_products_inner.g.dart';

/// ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner
///
/// Properties:
/// * [productName] 
/// * [totalQuantity] 
/// * [soldQuantity] 
/// * [remainingQuantity] 
@BuiltValue()
abstract class ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner implements Built<ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner, ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder> {
  @BuiltValueField(wireName: r'productName')
  String? get productName;

  @BuiltValueField(wireName: r'totalQuantity')
  int? get totalQuantity;

  @BuiltValueField(wireName: r'soldQuantity')
  int? get soldQuantity;

  @BuiltValueField(wireName: r'remainingQuantity')
  int? get remainingQuantity;

  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner._();

  factory ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner([void updates(ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder b)]) = _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner> get serializer => _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerSerializer();
}

class _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerSerializer implements PrimitiveSerializer<ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner> {
  @override
  final Iterable<Type> types = const [ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner, _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner];

  @override
  final String wireName = r'ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productName != null) {
      yield r'productName';
      yield serializers.serialize(
        object.productName,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalQuantity != null) {
      yield r'totalQuantity';
      yield serializers.serialize(
        object.totalQuantity,
        specifiedType: const FullType(int),
      );
    }
    if (object.soldQuantity != null) {
      yield r'soldQuantity';
      yield serializers.serialize(
        object.soldQuantity,
        specifiedType: const FullType(int),
      );
    }
    if (object.remainingQuantity != null) {
      yield r'remainingQuantity';
      yield serializers.serialize(
        object.remainingQuantity,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder result,
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
        case r'totalQuantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalQuantity = valueDes;
          break;
        case r'soldQuantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.soldQuantity = valueDes;
          break;
        case r'remainingQuantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.remainingQuantity = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInnerBuilder();
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

