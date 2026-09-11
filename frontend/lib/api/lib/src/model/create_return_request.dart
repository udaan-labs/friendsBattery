//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_return_request.g.dart';

/// CreateReturnRequest
///
/// Properties:
/// * [serialNumber] 
/// * [reason] 
/// * [restockAs] - Restock status after return. Default AVAILABLE (sellable).
@BuiltValue()
abstract class CreateReturnRequest implements Built<CreateReturnRequest, CreateReturnRequestBuilder> {
  @BuiltValueField(wireName: r'serial_number')
  String get serialNumber;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  /// Restock status after return. Default AVAILABLE (sellable).
  @BuiltValueField(wireName: r'restock_as')
  CreateReturnRequestRestockAsEnum? get restockAs;
  // enum restockAsEnum {  AVAILABLE,  DEFECTIVE,  };

  CreateReturnRequest._();

  factory CreateReturnRequest([void updates(CreateReturnRequestBuilder b)]) = _$CreateReturnRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateReturnRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateReturnRequest> get serializer => _$CreateReturnRequestSerializer();
}

class _$CreateReturnRequestSerializer implements PrimitiveSerializer<CreateReturnRequest> {
  @override
  final Iterable<Type> types = const [CreateReturnRequest, _$CreateReturnRequest];

  @override
  final String wireName = r'CreateReturnRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateReturnRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'serial_number';
    yield serializers.serialize(
      object.serialNumber,
      specifiedType: const FullType(String),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    if (object.restockAs != null) {
      yield r'restock_as';
      yield serializers.serialize(
        object.restockAs,
        specifiedType: const FullType(CreateReturnRequestRestockAsEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateReturnRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateReturnRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'serial_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.serialNumber = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'restock_as':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateReturnRequestRestockAsEnum),
          ) as CreateReturnRequestRestockAsEnum;
          result.restockAs = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateReturnRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateReturnRequestBuilder();
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

class CreateReturnRequestRestockAsEnum extends EnumClass {

  /// Restock status after return. Default AVAILABLE (sellable).
  @BuiltValueEnumConst(wireName: r'AVAILABLE')
  static const CreateReturnRequestRestockAsEnum AVAILABLE = _$createReturnRequestRestockAsEnum_AVAILABLE;
  /// Restock status after return. Default AVAILABLE (sellable).
  @BuiltValueEnumConst(wireName: r'DEFECTIVE')
  static const CreateReturnRequestRestockAsEnum DEFECTIVE = _$createReturnRequestRestockAsEnum_DEFECTIVE;

  static Serializer<CreateReturnRequestRestockAsEnum> get serializer => _$createReturnRequestRestockAsEnumSerializer;

  const CreateReturnRequestRestockAsEnum._(String name): super(name);

  static BuiltSet<CreateReturnRequestRestockAsEnum> get values => _$createReturnRequestRestockAsEnumValues;
  static CreateReturnRequestRestockAsEnum valueOf(String name) => _$createReturnRequestRestockAsEnumValueOf(name);
}

