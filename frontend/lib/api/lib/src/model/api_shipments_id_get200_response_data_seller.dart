//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_shipments_id_get200_response_data_seller.g.dart';

/// ApiShipmentsIdGet200ResponseDataSeller
///
/// Properties:
/// * [id] 
/// * [userName] 
/// * [shopName] 
/// * [userNumber] 
@BuiltValue()
abstract class ApiShipmentsIdGet200ResponseDataSeller implements Built<ApiShipmentsIdGet200ResponseDataSeller, ApiShipmentsIdGet200ResponseDataSellerBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'userName')
  String? get userName;

  @BuiltValueField(wireName: r'shopName')
  String? get shopName;

  @BuiltValueField(wireName: r'userNumber')
  String? get userNumber;

  ApiShipmentsIdGet200ResponseDataSeller._();

  factory ApiShipmentsIdGet200ResponseDataSeller([void updates(ApiShipmentsIdGet200ResponseDataSellerBuilder b)]) = _$ApiShipmentsIdGet200ResponseDataSeller;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiShipmentsIdGet200ResponseDataSellerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiShipmentsIdGet200ResponseDataSeller> get serializer => _$ApiShipmentsIdGet200ResponseDataSellerSerializer();
}

class _$ApiShipmentsIdGet200ResponseDataSellerSerializer implements PrimitiveSerializer<ApiShipmentsIdGet200ResponseDataSeller> {
  @override
  final Iterable<Type> types = const [ApiShipmentsIdGet200ResponseDataSeller, _$ApiShipmentsIdGet200ResponseDataSeller];

  @override
  final String wireName = r'ApiShipmentsIdGet200ResponseDataSeller';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiShipmentsIdGet200ResponseDataSeller object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userName != null) {
      yield r'userName';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.shopName != null) {
      yield r'shopName';
      yield serializers.serialize(
        object.shopName,
        specifiedType: const FullType(String),
      );
    }
    if (object.userNumber != null) {
      yield r'userNumber';
      yield serializers.serialize(
        object.userNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiShipmentsIdGet200ResponseDataSeller object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiShipmentsIdGet200ResponseDataSellerBuilder result,
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
        case r'userName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'shopName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shopName = valueDes;
          break;
        case r'userNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiShipmentsIdGet200ResponseDataSeller deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiShipmentsIdGet200ResponseDataSellerBuilder();
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

