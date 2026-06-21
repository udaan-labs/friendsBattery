//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/stock_request_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stock_request.g.dart';

/// StockRequest
///
/// Properties:
/// * [id] 
/// * [sellerId] 
/// * [requestTo] 
/// * [status] 
/// * [createdAt] 
/// * [approvedAt] 
/// * [items] 
@BuiltValue()
abstract class StockRequest implements Built<StockRequest, StockRequestBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'sellerId')
  String? get sellerId;

  @BuiltValueField(wireName: r'requestTo')
  String? get requestTo;

  @BuiltValueField(wireName: r'status')
  StockRequestStatusEnum? get status;
  // enum statusEnum {  PENDING,  APPROVED,  REJECTED,  SHIPPED,  DELIVERED,  };

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'approvedAt')
  DateTime? get approvedAt;

  @BuiltValueField(wireName: r'items')
  BuiltList<StockRequestItem>? get items;

  StockRequest._();

  factory StockRequest([void updates(StockRequestBuilder b)]) = _$StockRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StockRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StockRequest> get serializer => _$StockRequestSerializer();
}

class _$StockRequestSerializer implements PrimitiveSerializer<StockRequest> {
  @override
  final Iterable<Type> types = const [StockRequest, _$StockRequest];

  @override
  final String wireName = r'StockRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StockRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.sellerId != null) {
      yield r'sellerId';
      yield serializers.serialize(
        object.sellerId,
        specifiedType: const FullType(String),
      );
    }
    if (object.requestTo != null) {
      yield r'requestTo';
      yield serializers.serialize(
        object.requestTo,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(StockRequestStatusEnum),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.approvedAt != null) {
      yield r'approvedAt';
      yield serializers.serialize(
        object.approvedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(StockRequestItem)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StockRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StockRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'sellerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sellerId = valueDes;
          break;
        case r'requestTo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.requestTo = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StockRequestStatusEnum),
          ) as StockRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'approvedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.approvedAt = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StockRequestItem)]),
          ) as BuiltList<StockRequestItem>;
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
  StockRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StockRequestBuilder();
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

class StockRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const StockRequestStatusEnum PENDING = _$stockRequestStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'APPROVED')
  static const StockRequestStatusEnum APPROVED = _$stockRequestStatusEnum_APPROVED;
  @BuiltValueEnumConst(wireName: r'REJECTED')
  static const StockRequestStatusEnum REJECTED = _$stockRequestStatusEnum_REJECTED;
  @BuiltValueEnumConst(wireName: r'SHIPPED')
  static const StockRequestStatusEnum SHIPPED = _$stockRequestStatusEnum_SHIPPED;
  @BuiltValueEnumConst(wireName: r'DELIVERED')
  static const StockRequestStatusEnum DELIVERED = _$stockRequestStatusEnum_DELIVERED;

  static Serializer<StockRequestStatusEnum> get serializer => _$stockRequestStatusEnumSerializer;

  const StockRequestStatusEnum._(String name): super(name);

  static BuiltSet<StockRequestStatusEnum> get values => _$stockRequestStatusEnumValues;
  static StockRequestStatusEnum valueOf(String name) => _$stockRequestStatusEnumValueOf(name);
}

