//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_account_active_request.g.dart';

/// SetAccountActiveRequest
///
/// Properties:
/// * [isActive] 
@BuiltValue()
abstract class SetAccountActiveRequest implements Built<SetAccountActiveRequest, SetAccountActiveRequestBuilder> {
  @BuiltValueField(wireName: r'is_active')
  bool get isActive;

  SetAccountActiveRequest._();

  factory SetAccountActiveRequest([void updates(SetAccountActiveRequestBuilder b)]) = _$SetAccountActiveRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetAccountActiveRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetAccountActiveRequest> get serializer => _$SetAccountActiveRequestSerializer();
}

class _$SetAccountActiveRequestSerializer implements PrimitiveSerializer<SetAccountActiveRequest> {
  @override
  final Iterable<Type> types = const [SetAccountActiveRequest, _$SetAccountActiveRequest];

  @override
  final String wireName = r'SetAccountActiveRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetAccountActiveRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'is_active';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SetAccountActiveRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SetAccountActiveRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SetAccountActiveRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetAccountActiveRequestBuilder();
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

