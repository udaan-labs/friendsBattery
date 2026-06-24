//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response_data_categories_inner_subcategories_inner_products_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_details_get200_response_data_categories_inner_subcategories_inner.g.dart';

/// ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner
///
/// Properties:
/// * [subcategoryId] 
/// * [subcategoryName] 
/// * [totalProducts] 
/// * [totalInventory] 
/// * [products] 
@BuiltValue()
abstract class ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner implements Built<ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner, ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder> {
  @BuiltValueField(wireName: r'subcategoryId')
  int? get subcategoryId;

  @BuiltValueField(wireName: r'subcategoryName')
  String? get subcategoryName;

  @BuiltValueField(wireName: r'totalProducts')
  int? get totalProducts;

  @BuiltValueField(wireName: r'totalInventory')
  int? get totalInventory;

  @BuiltValueField(wireName: r'products')
  BuiltList<ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner>? get products;

  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner._();

  factory ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner([void updates(ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder b)]) = _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner> get serializer => _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerSerializer();
}

class _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerSerializer implements PrimitiveSerializer<ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner> {
  @override
  final Iterable<Type> types = const [ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner, _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner];

  @override
  final String wireName = r'ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.subcategoryId != null) {
      yield r'subcategoryId';
      yield serializers.serialize(
        object.subcategoryId,
        specifiedType: const FullType(int),
      );
    }
    if (object.subcategoryName != null) {
      yield r'subcategoryName';
      yield serializers.serialize(
        object.subcategoryName,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalProducts != null) {
      yield r'totalProducts';
      yield serializers.serialize(
        object.totalProducts,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalInventory != null) {
      yield r'totalInventory';
      yield serializers.serialize(
        object.totalInventory,
        specifiedType: const FullType(int),
      );
    }
    if (object.products != null) {
      yield r'products';
      yield serializers.serialize(
        object.products,
        specifiedType: const FullType(BuiltList, [FullType(ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'subcategoryId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.subcategoryId = valueDes;
          break;
        case r'subcategoryName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subcategoryName = valueDes;
          break;
        case r'totalProducts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalProducts = valueDes;
          break;
        case r'totalInventory':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalInventory = valueDes;
          break;
        case r'products':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner)]),
          ) as BuiltList<ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerProductsInner>;
          result.products.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInnerBuilder();
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

