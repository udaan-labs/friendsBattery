//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sales_transaction.g.dart';

/// SalesTransaction
///
/// Properties:
/// * [id] 
/// * [productId] 
/// * [productUnitId] 
/// * [customerId] 
/// * [sellerId] 
/// * [sellPrice] 
/// * [serialNumber] 
/// * [vehicleNumber] 
/// * [productReplacedId] 
/// * [soldAt] 
@BuiltValue()
abstract class SalesTransaction implements Built<SalesTransaction, SalesTransactionBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'productId')
  String? get productId;

  @BuiltValueField(wireName: r'productUnitId')
  String? get productUnitId;

  @BuiltValueField(wireName: r'customerId')
  String? get customerId;

  @BuiltValueField(wireName: r'sellerId')
  String? get sellerId;

  @BuiltValueField(wireName: r'sellPrice')
  double? get sellPrice;

  @BuiltValueField(wireName: r'serialNumber')
  String? get serialNumber;

  @BuiltValueField(wireName: r'vehicleNumber')
  String? get vehicleNumber;

  @BuiltValueField(wireName: r'productReplacedId')
  String? get productReplacedId;

  @BuiltValueField(wireName: r'soldAt')
  DateTime? get soldAt;

  SalesTransaction._();

  factory SalesTransaction([void updates(SalesTransactionBuilder b)]) = _$SalesTransaction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SalesTransactionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SalesTransaction> get serializer => _$SalesTransactionSerializer();
}

class _$SalesTransactionSerializer implements PrimitiveSerializer<SalesTransaction> {
  @override
  final Iterable<Type> types = const [SalesTransaction, _$SalesTransaction];

  @override
  final String wireName = r'SalesTransaction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SalesTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.productId != null) {
      yield r'productId';
      yield serializers.serialize(
        object.productId,
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
    if (object.customerId != null) {
      yield r'customerId';
      yield serializers.serialize(
        object.customerId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.sellerId != null) {
      yield r'sellerId';
      yield serializers.serialize(
        object.sellerId,
        specifiedType: const FullType(String),
      );
    }
    if (object.sellPrice != null) {
      yield r'sellPrice';
      yield serializers.serialize(
        object.sellPrice,
        specifiedType: const FullType(double),
      );
    }
    if (object.serialNumber != null) {
      yield r'serialNumber';
      yield serializers.serialize(
        object.serialNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.vehicleNumber != null) {
      yield r'vehicleNumber';
      yield serializers.serialize(
        object.vehicleNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.productReplacedId != null) {
      yield r'productReplacedId';
      yield serializers.serialize(
        object.productReplacedId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.soldAt != null) {
      yield r'soldAt';
      yield serializers.serialize(
        object.soldAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SalesTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SalesTransactionBuilder result,
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
        case r'productId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'productUnitId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productUnitId = valueDes;
          break;
        case r'customerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.customerId = valueDes;
          break;
        case r'sellerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sellerId = valueDes;
          break;
        case r'sellPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.sellPrice = valueDes;
          break;
        case r'serialNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.serialNumber = valueDes;
          break;
        case r'vehicleNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.vehicleNumber = valueDes;
          break;
        case r'productReplacedId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.productReplacedId = valueDes;
          break;
        case r'soldAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.soldAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SalesTransaction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SalesTransactionBuilder();
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

