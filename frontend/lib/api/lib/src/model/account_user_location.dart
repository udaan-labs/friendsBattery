//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_user_location.g.dart';

/// AccountUserLocation
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [type] 
@BuiltValue()
abstract class AccountUserLocation implements Built<AccountUserLocation, AccountUserLocationBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'type')
  AccountUserLocationTypeEnum? get type;
  // enum typeEnum {  WAREHOUSE,  SHOP,  };

  AccountUserLocation._();

  factory AccountUserLocation([void updates(AccountUserLocationBuilder b)]) = _$AccountUserLocation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountUserLocationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountUserLocation> get serializer => _$AccountUserLocationSerializer();
}

class _$AccountUserLocationSerializer implements PrimitiveSerializer<AccountUserLocation> {
  @override
  final Iterable<Type> types = const [AccountUserLocation, _$AccountUserLocation];

  @override
  final String wireName = r'AccountUserLocation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountUserLocation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
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
        specifiedType: const FullType(AccountUserLocationTypeEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountUserLocation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountUserLocationBuilder result,
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
            specifiedType: const FullType(AccountUserLocationTypeEnum),
          ) as AccountUserLocationTypeEnum;
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
  AccountUserLocation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountUserLocationBuilder();
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

class AccountUserLocationTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'WAREHOUSE')
  static const AccountUserLocationTypeEnum WAREHOUSE = _$accountUserLocationTypeEnum_WAREHOUSE;
  @BuiltValueEnumConst(wireName: r'SHOP')
  static const AccountUserLocationTypeEnum SHOP = _$accountUserLocationTypeEnum_SHOP;

  static Serializer<AccountUserLocationTypeEnum> get serializer => _$accountUserLocationTypeEnumSerializer;

  const AccountUserLocationTypeEnum._(String name): super(name);

  static BuiltSet<AccountUserLocationTypeEnum> get values => _$accountUserLocationTypeEnumValues;
  static AccountUserLocationTypeEnum valueOf(String name) => _$accountUserLocationTypeEnumValueOf(name);
}

