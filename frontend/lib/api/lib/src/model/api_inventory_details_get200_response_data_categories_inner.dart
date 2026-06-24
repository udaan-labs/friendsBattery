//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response_data_categories_inner_subcategories_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_details_get200_response_data_categories_inner.g.dart';

/// ApiInventoryDetailsGet200ResponseDataCategoriesInner
///
/// Properties:
/// * [categoryId] 
/// * [categoryName] 
/// * [totalProducts] 
/// * [totalInventory] 
/// * [subcategories] 
@BuiltValue()
abstract class ApiInventoryDetailsGet200ResponseDataCategoriesInner implements Built<ApiInventoryDetailsGet200ResponseDataCategoriesInner, ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder> {
  @BuiltValueField(wireName: r'categoryId')
  int? get categoryId;

  @BuiltValueField(wireName: r'categoryName')
  String? get categoryName;

  @BuiltValueField(wireName: r'totalProducts')
  int? get totalProducts;

  @BuiltValueField(wireName: r'totalInventory')
  int? get totalInventory;

  @BuiltValueField(wireName: r'subcategories')
  BuiltList<ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner>? get subcategories;

  ApiInventoryDetailsGet200ResponseDataCategoriesInner._();

  factory ApiInventoryDetailsGet200ResponseDataCategoriesInner([void updates(ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder b)]) = _$ApiInventoryDetailsGet200ResponseDataCategoriesInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryDetailsGet200ResponseDataCategoriesInner> get serializer => _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSerializer();
}

class _$ApiInventoryDetailsGet200ResponseDataCategoriesInnerSerializer implements PrimitiveSerializer<ApiInventoryDetailsGet200ResponseDataCategoriesInner> {
  @override
  final Iterable<Type> types = const [ApiInventoryDetailsGet200ResponseDataCategoriesInner, _$ApiInventoryDetailsGet200ResponseDataCategoriesInner];

  @override
  final String wireName = r'ApiInventoryDetailsGet200ResponseDataCategoriesInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryDetailsGet200ResponseDataCategoriesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.categoryId != null) {
      yield r'categoryId';
      yield serializers.serialize(
        object.categoryId,
        specifiedType: const FullType(int),
      );
    }
    if (object.categoryName != null) {
      yield r'categoryName';
      yield serializers.serialize(
        object.categoryName,
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
    if (object.subcategories != null) {
      yield r'subcategories';
      yield serializers.serialize(
        object.subcategories,
        specifiedType: const FullType(BuiltList, [FullType(ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryDetailsGet200ResponseDataCategoriesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'categoryId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.categoryId = valueDes;
          break;
        case r'categoryName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.categoryName = valueDes;
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
        case r'subcategories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner)]),
          ) as BuiltList<ApiInventoryDetailsGet200ResponseDataCategoriesInnerSubcategoriesInner>;
          result.subcategories.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiInventoryDetailsGet200ResponseDataCategoriesInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryDetailsGet200ResponseDataCategoriesInnerBuilder();
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

