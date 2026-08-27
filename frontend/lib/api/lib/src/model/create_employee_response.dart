//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/created_employee.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_employee_response.g.dart';

/// CreateEmployeeResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class CreateEmployeeResponse implements Built<CreateEmployeeResponse, CreateEmployeeResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  CreatedEmployee? get data;

  CreateEmployeeResponse._();

  factory CreateEmployeeResponse([void updates(CreateEmployeeResponseBuilder b)]) = _$CreateEmployeeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateEmployeeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateEmployeeResponse> get serializer => _$CreateEmployeeResponseSerializer();
}

class _$CreateEmployeeResponseSerializer implements PrimitiveSerializer<CreateEmployeeResponse> {
  @override
  final Iterable<Type> types = const [CreateEmployeeResponse, _$CreateEmployeeResponse];

  @override
  final String wireName = r'CreateEmployeeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateEmployeeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(CreatedEmployee),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateEmployeeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateEmployeeResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreatedEmployee),
          ) as CreatedEmployee;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateEmployeeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateEmployeeResponseBuilder();
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

