//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response_data_pagination.dart';
import 'package:friends_battery_api/src/model/api_inventory_details_get200_response_data_categories_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_details_get200_response_data.g.dart';

/// ApiInventoryDetailsGet200ResponseData
///
/// Properties:
/// * [categories] 
/// * [pagination] 
@BuiltValue()
abstract class ApiInventoryDetailsGet200ResponseData implements Built<ApiInventoryDetailsGet200ResponseData, ApiInventoryDetailsGet200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'categories')
  BuiltList<ApiInventoryDetailsGet200ResponseDataCategoriesInner>? get categories;

  @BuiltValueField(wireName: r'pagination')
  ApiInventoryDetailsGet200ResponseDataPagination? get pagination;

  ApiInventoryDetailsGet200ResponseData._();

  factory ApiInventoryDetailsGet200ResponseData([void updates(ApiInventoryDetailsGet200ResponseDataBuilder b)]) = _$ApiInventoryDetailsGet200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryDetailsGet200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryDetailsGet200ResponseData> get serializer => _$ApiInventoryDetailsGet200ResponseDataSerializer();
}

class _$ApiInventoryDetailsGet200ResponseDataSerializer implements PrimitiveSerializer<ApiInventoryDetailsGet200ResponseData> {
  @override
  final Iterable<Type> types = const [ApiInventoryDetailsGet200ResponseData, _$ApiInventoryDetailsGet200ResponseData];

  @override
  final String wireName = r'ApiInventoryDetailsGet200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryDetailsGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.categories != null) {
      yield r'categories';
      yield serializers.serialize(
        object.categories,
        specifiedType: const FullType(BuiltList, [FullType(ApiInventoryDetailsGet200ResponseDataCategoriesInner)]),
      );
    }
    if (object.pagination != null) {
      yield r'pagination';
      yield serializers.serialize(
        object.pagination,
        specifiedType: const FullType(ApiInventoryDetailsGet200ResponseDataPagination),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryDetailsGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryDetailsGet200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'categories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ApiInventoryDetailsGet200ResponseDataCategoriesInner)]),
          ) as BuiltList<ApiInventoryDetailsGet200ResponseDataCategoriesInner>;
          result.categories.replace(valueDes);
          break;
        case r'pagination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ApiInventoryDetailsGet200ResponseDataPagination),
          ) as ApiInventoryDetailsGet200ResponseDataPagination;
          result.pagination.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiInventoryDetailsGet200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryDetailsGet200ResponseDataBuilder();
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

