//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_shipment_result.g.dart';

/// CreateShipmentResult
///
/// Properties:
/// * [shipmentId] 
/// * [shipmentNumber] 
/// * [status] 
/// * [transferredUnits] 
/// * [sellerId] 
@BuiltValue()
abstract class CreateShipmentResult implements Built<CreateShipmentResult, CreateShipmentResultBuilder> {
  @BuiltValueField(wireName: r'shipmentId')
  int? get shipmentId;

  @BuiltValueField(wireName: r'shipmentNumber')
  String? get shipmentNumber;

  @BuiltValueField(wireName: r'status')
  CreateShipmentResultStatusEnum? get status;
  // enum statusEnum {  PENDING,  ACCEPTED,  REJECTED,  };

  @BuiltValueField(wireName: r'transferredUnits')
  int? get transferredUnits;

  @BuiltValueField(wireName: r'sellerId')
  int? get sellerId;

  CreateShipmentResult._();

  factory CreateShipmentResult([void updates(CreateShipmentResultBuilder b)]) = _$CreateShipmentResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateShipmentResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateShipmentResult> get serializer => _$CreateShipmentResultSerializer();
}

class _$CreateShipmentResultSerializer implements PrimitiveSerializer<CreateShipmentResult> {
  @override
  final Iterable<Type> types = const [CreateShipmentResult, _$CreateShipmentResult];

  @override
  final String wireName = r'CreateShipmentResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateShipmentResult object, {
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
        specifiedType: const FullType(CreateShipmentResultStatusEnum),
      );
    }
    if (object.transferredUnits != null) {
      yield r'transferredUnits';
      yield serializers.serialize(
        object.transferredUnits,
        specifiedType: const FullType(int),
      );
    }
    if (object.sellerId != null) {
      yield r'sellerId';
      yield serializers.serialize(
        object.sellerId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateShipmentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateShipmentResultBuilder result,
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
            specifiedType: const FullType(CreateShipmentResultStatusEnum),
          ) as CreateShipmentResultStatusEnum;
          result.status = valueDes;
          break;
        case r'transferredUnits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.transferredUnits = valueDes;
          break;
        case r'sellerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sellerId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateShipmentResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateShipmentResultBuilder();
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

class CreateShipmentResultStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const CreateShipmentResultStatusEnum PENDING = _$createShipmentResultStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'ACCEPTED')
  static const CreateShipmentResultStatusEnum ACCEPTED = _$createShipmentResultStatusEnum_ACCEPTED;
  @BuiltValueEnumConst(wireName: r'REJECTED')
  static const CreateShipmentResultStatusEnum REJECTED = _$createShipmentResultStatusEnum_REJECTED;

  static Serializer<CreateShipmentResultStatusEnum> get serializer => _$createShipmentResultStatusEnumSerializer;

  const CreateShipmentResultStatusEnum._(String name): super(name);

  static BuiltSet<CreateShipmentResultStatusEnum> get values => _$createShipmentResultStatusEnumValues;
  static CreateShipmentResultStatusEnum valueOf(String name) => _$createShipmentResultStatusEnumValueOf(name);
}

