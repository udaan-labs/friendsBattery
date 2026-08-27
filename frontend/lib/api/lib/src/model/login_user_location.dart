//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_user_location.g.dart';

/// LoginUserLocation
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [name] 
/// * [type] 
@BuiltValue()
abstract class LoginUserLocation implements Built<LoginUserLocation, LoginUserLocationBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'type')
  LoginUserLocationTypeEnum? get type;
  // enum typeEnum {  WAREHOUSE,  SHOP,  };

  LoginUserLocation._();

  factory LoginUserLocation([void updates(LoginUserLocationBuilder b)]) = _$LoginUserLocation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginUserLocationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginUserLocation> get serializer => _$LoginUserLocationSerializer();
}

class _$LoginUserLocationSerializer implements PrimitiveSerializer<LoginUserLocation> {
  @override
  final Iterable<Type> types = const [LoginUserLocation, _$LoginUserLocation];

  @override
  final String wireName = r'LoginUserLocation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginUserLocation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(LoginUserLocationTypeEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginUserLocation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginUserLocationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LoginUserLocationTypeEnum),
          ) as LoginUserLocationTypeEnum;
          result.type = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginUserLocation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginUserLocationBuilder();
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

class LoginUserLocationTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'WAREHOUSE')
  static const LoginUserLocationTypeEnum WAREHOUSE = _$loginUserLocationTypeEnum_WAREHOUSE;
  @BuiltValueEnumConst(wireName: r'SHOP')
  static const LoginUserLocationTypeEnum SHOP = _$loginUserLocationTypeEnum_SHOP;

  static Serializer<LoginUserLocationTypeEnum> get serializer => _$loginUserLocationTypeEnumSerializer;

  const LoginUserLocationTypeEnum._(String name): super(name);

  static BuiltSet<LoginUserLocationTypeEnum> get values => _$loginUserLocationTypeEnumValues;
  static LoginUserLocationTypeEnum valueOf(String name) => _$loginUserLocationTypeEnumValueOf(name);
}

