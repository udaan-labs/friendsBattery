//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'next_employee_user_id_data.g.dart';

/// NextEmployeeUserIdData
///
/// Properties:
/// * [userId] 
@BuiltValue()
abstract class NextEmployeeUserIdData implements Built<NextEmployeeUserIdData, NextEmployeeUserIdDataBuilder> {
  @BuiltValueField(wireName: r'user_id')
  String? get userId;

  NextEmployeeUserIdData._();

  factory NextEmployeeUserIdData([void updates(NextEmployeeUserIdDataBuilder b)]) = _$NextEmployeeUserIdData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NextEmployeeUserIdDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NextEmployeeUserIdData> get serializer => _$NextEmployeeUserIdDataSerializer();
}

class _$NextEmployeeUserIdDataSerializer implements PrimitiveSerializer<NextEmployeeUserIdData> {
  @override
  final Iterable<Type> types = const [NextEmployeeUserIdData, _$NextEmployeeUserIdData];

  @override
  final String wireName = r'NextEmployeeUserIdData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NextEmployeeUserIdData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'user_id';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NextEmployeeUserIdData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NextEmployeeUserIdDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NextEmployeeUserIdData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NextEmployeeUserIdDataBuilder();
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

