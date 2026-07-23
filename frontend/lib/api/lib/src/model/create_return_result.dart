//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_return_result.g.dart';

/// CreateReturnResult
///
/// Properties:
/// * [message] 
/// * [returnRecordId] 
/// * [productUnitId] 
/// * [status] 
@BuiltValue()
abstract class CreateReturnResult implements Built<CreateReturnResult, CreateReturnResultBuilder> {
  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'returnRecordId')
  String? get returnRecordId;

  @BuiltValueField(wireName: r'productUnitId')
  String? get productUnitId;

  @BuiltValueField(wireName: r'status')
  String? get status;

  CreateReturnResult._();

  factory CreateReturnResult([void updates(CreateReturnResultBuilder b)]) = _$CreateReturnResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateReturnResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateReturnResult> get serializer => _$CreateReturnResultSerializer();
}

class _$CreateReturnResultSerializer implements PrimitiveSerializer<CreateReturnResult> {
  @override
  final Iterable<Type> types = const [CreateReturnResult, _$CreateReturnResult];

  @override
  final String wireName = r'CreateReturnResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateReturnResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.returnRecordId != null) {
      yield r'returnRecordId';
      yield serializers.serialize(
        object.returnRecordId,
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
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateReturnResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateReturnResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'returnRecordId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.returnRecordId = valueDes;
          break;
        case r'productUnitId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productUnitId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateReturnResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateReturnResultBuilder();
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

