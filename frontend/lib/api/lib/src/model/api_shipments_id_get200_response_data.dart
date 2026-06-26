//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/api_shipments_id_get200_response_data_items_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/api_shipments_id_get200_response_data_seller.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_shipments_id_get200_response_data.g.dart';

/// ApiShipmentsIdGet200ResponseData
///
/// Properties:
/// * [shipmentId] 
/// * [shipmentNumber] 
/// * [status] 
/// * [createdAt] 
/// * [acceptedAt] 
/// * [seller] 
/// * [totalProducts] 
/// * [totalQuantity] 
/// * [items] 
@BuiltValue()
abstract class ApiShipmentsIdGet200ResponseData implements Built<ApiShipmentsIdGet200ResponseData, ApiShipmentsIdGet200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'shipmentId')
  int? get shipmentId;

  @BuiltValueField(wireName: r'shipmentNumber')
  String? get shipmentNumber;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'createdAt')
  String? get createdAt;

  @BuiltValueField(wireName: r'acceptedAt')
  String? get acceptedAt;

  @BuiltValueField(wireName: r'seller')
  ApiShipmentsIdGet200ResponseDataSeller? get seller;

  @BuiltValueField(wireName: r'totalProducts')
  int? get totalProducts;

  @BuiltValueField(wireName: r'totalQuantity')
  int? get totalQuantity;

  @BuiltValueField(wireName: r'items')
  BuiltList<ApiShipmentsIdGet200ResponseDataItemsInner>? get items;

  ApiShipmentsIdGet200ResponseData._();

  factory ApiShipmentsIdGet200ResponseData([void updates(ApiShipmentsIdGet200ResponseDataBuilder b)]) = _$ApiShipmentsIdGet200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiShipmentsIdGet200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiShipmentsIdGet200ResponseData> get serializer => _$ApiShipmentsIdGet200ResponseDataSerializer();
}

class _$ApiShipmentsIdGet200ResponseDataSerializer implements PrimitiveSerializer<ApiShipmentsIdGet200ResponseData> {
  @override
  final Iterable<Type> types = const [ApiShipmentsIdGet200ResponseData, _$ApiShipmentsIdGet200ResponseData];

  @override
  final String wireName = r'ApiShipmentsIdGet200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiShipmentsIdGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.shipmentId != null) {
      yield r'shipmentId';
      yield serializers.serialize(
        object.shipmentId,
        specifiedType: const FullType(int),
      );
    }
    if (object.shipmentNumber != null) {
      yield r'shipmentNumber';
      yield serializers.serialize(
        object.shipmentNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(String),
      );
    }
    if (object.acceptedAt != null) {
      yield r'acceptedAt';
      yield serializers.serialize(
        object.acceptedAt,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.seller != null) {
      yield r'seller';
      yield serializers.serialize(
        object.seller,
        specifiedType: const FullType(ApiShipmentsIdGet200ResponseDataSeller),
      );
    }
    if (object.totalProducts != null) {
      yield r'totalProducts';
      yield serializers.serialize(
        object.totalProducts,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalQuantity != null) {
      yield r'totalQuantity';
      yield serializers.serialize(
        object.totalQuantity,
        specifiedType: const FullType(int),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(ApiShipmentsIdGet200ResponseDataItemsInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiShipmentsIdGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiShipmentsIdGet200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'shipmentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.shipmentId = valueDes;
          break;
        case r'shipmentNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shipmentNumber = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdAt = valueDes;
          break;
        case r'acceptedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.acceptedAt = valueDes;
          break;
        case r'seller':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ApiShipmentsIdGet200ResponseDataSeller),
          ) as ApiShipmentsIdGet200ResponseDataSeller;
          result.seller.replace(valueDes);
          break;
        case r'totalProducts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalProducts = valueDes;
          break;
        case r'totalQuantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalQuantity = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ApiShipmentsIdGet200ResponseDataItemsInner)]),
          ) as BuiltList<ApiShipmentsIdGet200ResponseDataItemsInner>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiShipmentsIdGet200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiShipmentsIdGet200ResponseDataBuilder();
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

