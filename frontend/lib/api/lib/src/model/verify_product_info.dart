//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_product_info.g.dart';

/// VerifyProductInfo
///
/// Properties:
/// * [name] 
/// * [group] 
/// * [subgroup] 
/// * [model] 
@BuiltValue()
abstract class VerifyProductInfo implements Built<VerifyProductInfo, VerifyProductInfoBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'group')
  String? get group;

  @BuiltValueField(wireName: r'subgroup')
  String? get subgroup;

  @BuiltValueField(wireName: r'model')
  String? get model;

  VerifyProductInfo._();

  factory VerifyProductInfo([void updates(VerifyProductInfoBuilder b)]) = _$VerifyProductInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VerifyProductInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VerifyProductInfo> get serializer => _$VerifyProductInfoSerializer();
}

class _$VerifyProductInfoSerializer implements PrimitiveSerializer<VerifyProductInfo> {
  @override
  final Iterable<Type> types = const [VerifyProductInfo, _$VerifyProductInfo];

  @override
  final String wireName = r'VerifyProductInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VerifyProductInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.group != null) {
      yield r'group';
      yield serializers.serialize(
        object.group,
        specifiedType: const FullType(String),
      );
    }
    if (object.subgroup != null) {
      yield r'subgroup';
      yield serializers.serialize(
        object.subgroup,
        specifiedType: const FullType(String),
      );
    }
    if (object.model != null) {
      yield r'model';
      yield serializers.serialize(
        object.model,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    VerifyProductInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VerifyProductInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'group':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.group = valueDes;
          break;
        case r'subgroup':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subgroup = valueDes;
          break;
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.model = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VerifyProductInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerifyProductInfoBuilder();
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

