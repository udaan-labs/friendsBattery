//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'seller_shop_summary.g.dart';

/// SellerShopSummary
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [userName] 
/// * [shopName] 
/// * [userNumber] 
/// * [isActive] 
/// * [isVerified] 
/// * [totalStock] 
/// * [todaySales] 
/// * [pendingShipments] 
/// * [hasLowStock] 
@BuiltValue()
abstract class SellerShopSummary implements Built<SellerShopSummary, SellerShopSummaryBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'user_id')
  String? get userId;

  @BuiltValueField(wireName: r'user_name')
  String? get userName;

  @BuiltValueField(wireName: r'shop_name')
  String? get shopName;

  @BuiltValueField(wireName: r'user_number')
  String? get userNumber;

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  @BuiltValueField(wireName: r'is_verified')
  bool? get isVerified;

  @BuiltValueField(wireName: r'totalStock')
  int? get totalStock;

  @BuiltValueField(wireName: r'todaySales')
  int? get todaySales;

  @BuiltValueField(wireName: r'pendingShipments')
  int? get pendingShipments;

  @BuiltValueField(wireName: r'hasLowStock')
  bool? get hasLowStock;

  SellerShopSummary._();

  factory SellerShopSummary([void updates(SellerShopSummaryBuilder b)]) = _$SellerShopSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SellerShopSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SellerShopSummary> get serializer => _$SellerShopSummarySerializer();
}

class _$SellerShopSummarySerializer implements PrimitiveSerializer<SellerShopSummary> {
  @override
  final Iterable<Type> types = const [SellerShopSummary, _$SellerShopSummary];

  @override
  final String wireName = r'SellerShopSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SellerShopSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'user_id';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.userName != null) {
      yield r'user_name';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.shopName != null) {
      yield r'shop_name';
      yield serializers.serialize(
        object.shopName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.userNumber != null) {
      yield r'user_number';
      yield serializers.serialize(
        object.userNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.isActive != null) {
      yield r'is_active';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isVerified != null) {
      yield r'is_verified';
      yield serializers.serialize(
        object.isVerified,
        specifiedType: const FullType(bool),
      );
    }
    if (object.totalStock != null) {
      yield r'totalStock';
      yield serializers.serialize(
        object.totalStock,
        specifiedType: const FullType(int),
      );
    }
    if (object.todaySales != null) {
      yield r'todaySales';
      yield serializers.serialize(
        object.todaySales,
        specifiedType: const FullType(int),
      );
    }
    if (object.pendingShipments != null) {
      yield r'pendingShipments';
      yield serializers.serialize(
        object.pendingShipments,
        specifiedType: const FullType(int),
      );
    }
    if (object.hasLowStock != null) {
      yield r'hasLowStock';
      yield serializers.serialize(
        object.hasLowStock,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SellerShopSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SellerShopSummaryBuilder result,
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
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'user_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'shop_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.shopName = valueDes;
          break;
        case r'user_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userNumber = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'is_verified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isVerified = valueDes;
          break;
        case r'totalStock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalStock = valueDes;
          break;
        case r'todaySales':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todaySales = valueDes;
          break;
        case r'pendingShipments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingShipments = valueDes;
          break;
        case r'hasLowStock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasLowStock = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SellerShopSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SellerShopSummaryBuilder();
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

