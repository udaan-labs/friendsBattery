//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'inventory_transaction.g.dart';

/// InventoryTransaction
///
/// Properties:
/// * [id] 
/// * [productUnitId] 
/// * [fromUserId] 
/// * [toUserId] 
/// * [action] 
/// * [timestamp] 
@BuiltValue()
abstract class InventoryTransaction implements Built<InventoryTransaction, InventoryTransactionBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'productUnitId')
  String? get productUnitId;

  @BuiltValueField(wireName: r'fromUserId')
  String? get fromUserId;

  @BuiltValueField(wireName: r'toUserId')
  String? get toUserId;

  @BuiltValueField(wireName: r'action')
  InventoryTransactionActionEnum? get action;
  // enum actionEnum {  RECEIVED,  SHIPPED,  SOLD,  RETURNED,  TRANSFERRED,  RENTED,  RENT_RETURNED,  ADJUSTED,  };

  @BuiltValueField(wireName: r'timestamp')
  DateTime? get timestamp;

  InventoryTransaction._();

  factory InventoryTransaction([void updates(InventoryTransactionBuilder b)]) = _$InventoryTransaction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InventoryTransactionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InventoryTransaction> get serializer => _$InventoryTransactionSerializer();
}

class _$InventoryTransactionSerializer implements PrimitiveSerializer<InventoryTransaction> {
  @override
  final Iterable<Type> types = const [InventoryTransaction, _$InventoryTransaction];

  @override
  final String wireName = r'InventoryTransaction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InventoryTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.productUnitId != null) {
      yield r'productUnitId';
      yield serializers.serialize(
        object.productUnitId,
        specifiedType: const FullType(String),
      );
    }
    if (object.fromUserId != null) {
      yield r'fromUserId';
      yield serializers.serialize(
        object.fromUserId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.toUserId != null) {
      yield r'toUserId';
      yield serializers.serialize(
        object.toUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.action != null) {
      yield r'action';
      yield serializers.serialize(
        object.action,
        specifiedType: const FullType(InventoryTransactionActionEnum),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InventoryTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InventoryTransactionBuilder result,
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
        case r'productUnitId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productUnitId = valueDes;
          break;
        case r'fromUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fromUserId = valueDes;
          break;
        case r'toUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.toUserId = valueDes;
          break;
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(InventoryTransactionActionEnum),
          ) as InventoryTransactionActionEnum;
          result.action = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InventoryTransaction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InventoryTransactionBuilder();
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

class InventoryTransactionActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RECEIVED')
  static const InventoryTransactionActionEnum RECEIVED = _$inventoryTransactionActionEnum_RECEIVED;
  @BuiltValueEnumConst(wireName: r'SHIPPED')
  static const InventoryTransactionActionEnum SHIPPED = _$inventoryTransactionActionEnum_SHIPPED;
  @BuiltValueEnumConst(wireName: r'SOLD')
  static const InventoryTransactionActionEnum SOLD = _$inventoryTransactionActionEnum_SOLD;
  @BuiltValueEnumConst(wireName: r'RETURNED')
  static const InventoryTransactionActionEnum RETURNED = _$inventoryTransactionActionEnum_RETURNED;
  @BuiltValueEnumConst(wireName: r'TRANSFERRED')
  static const InventoryTransactionActionEnum TRANSFERRED = _$inventoryTransactionActionEnum_TRANSFERRED;
  @BuiltValueEnumConst(wireName: r'RENTED')
  static const InventoryTransactionActionEnum RENTED = _$inventoryTransactionActionEnum_RENTED;
  @BuiltValueEnumConst(wireName: r'RENT_RETURNED')
  static const InventoryTransactionActionEnum RENT_RETURNED = _$inventoryTransactionActionEnum_RENT_RETURNED;
  @BuiltValueEnumConst(wireName: r'ADJUSTED')
  static const InventoryTransactionActionEnum ADJUSTED = _$inventoryTransactionActionEnum_ADJUSTED;

  static Serializer<InventoryTransactionActionEnum> get serializer => _$inventoryTransactionActionEnumSerializer;

  const InventoryTransactionActionEnum._(String name): super(name);

  static BuiltSet<InventoryTransactionActionEnum> get values => _$inventoryTransactionActionEnumValues;
  static InventoryTransactionActionEnum valueOf(String name) => _$inventoryTransactionActionEnumValueOf(name);
}

