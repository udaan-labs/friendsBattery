//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/shop_staff_member.dart';
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/seller_detail_location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'shop_staff_data.g.dart';

/// ShopStaffData
///
/// Properties:
/// * [location] 
/// * [admins] 
/// * [sellers] 
/// * [employees] 
@BuiltValue()
abstract class ShopStaffData implements Built<ShopStaffData, ShopStaffDataBuilder> {
  @BuiltValueField(wireName: r'location')
  SellerDetailLocation? get location;

  @BuiltValueField(wireName: r'admins')
  BuiltList<ShopStaffMember>? get admins;

  @BuiltValueField(wireName: r'sellers')
  BuiltList<ShopStaffMember>? get sellers;

  @BuiltValueField(wireName: r'employees')
  BuiltList<ShopStaffMember>? get employees;

  ShopStaffData._();

  factory ShopStaffData([void updates(ShopStaffDataBuilder b)]) = _$ShopStaffData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ShopStaffDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ShopStaffData> get serializer => _$ShopStaffDataSerializer();
}

class _$ShopStaffDataSerializer implements PrimitiveSerializer<ShopStaffData> {
  @override
  final Iterable<Type> types = const [ShopStaffData, _$ShopStaffData];

  @override
  final String wireName = r'ShopStaffData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ShopStaffData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType.nullable(SellerDetailLocation),
      );
    }
    if (object.admins != null) {
      yield r'admins';
      yield serializers.serialize(
        object.admins,
        specifiedType: const FullType(BuiltList, [FullType(ShopStaffMember)]),
      );
    }
    if (object.sellers != null) {
      yield r'sellers';
      yield serializers.serialize(
        object.sellers,
        specifiedType: const FullType(BuiltList, [FullType(ShopStaffMember)]),
      );
    }
    if (object.employees != null) {
      yield r'employees';
      yield serializers.serialize(
        object.employees,
        specifiedType: const FullType(BuiltList, [FullType(ShopStaffMember)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ShopStaffData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ShopStaffDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SellerDetailLocation),
          ) as SellerDetailLocation?;
          if (valueDes == null) continue;
          result.location.replace(valueDes);
          break;
        case r'admins':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ShopStaffMember)]),
          ) as BuiltList<ShopStaffMember>;
          result.admins.replace(valueDes);
          break;
        case r'sellers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ShopStaffMember)]),
          ) as BuiltList<ShopStaffMember>;
          result.sellers.replace(valueDes);
          break;
        case r'employees':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ShopStaffMember)]),
          ) as BuiltList<ShopStaffMember>;
          result.employees.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ShopStaffData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ShopStaffDataBuilder();
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

