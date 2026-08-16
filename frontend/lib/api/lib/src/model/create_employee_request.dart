//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_employee_request.g.dart';

/// CreateEmployeeRequest
///
/// Properties:
/// * [userId] - Optional login ID. Omit to auto-generate EMP001, EMP002, …
/// * [username] 
/// * [userNumber] - 10-digit mobile
/// * [password] 
/// * [employeeRoleId] - Optional job title id from GET /api/shops/employee-roles
/// * [locationId] - Required for admin (warehouse or shop). Ignored for seller.
@BuiltValue()
abstract class CreateEmployeeRequest implements Built<CreateEmployeeRequest, CreateEmployeeRequestBuilder> {
  /// Optional login ID. Omit to auto-generate EMP001, EMP002, …
  @BuiltValueField(wireName: r'user_id')
  String? get userId;

  @BuiltValueField(wireName: r'username')
  String get username;

  /// 10-digit mobile
  @BuiltValueField(wireName: r'user_number')
  String get userNumber;

  @BuiltValueField(wireName: r'password')
  String get password;

  /// Optional job title id from GET /api/shops/employee-roles
  @BuiltValueField(wireName: r'employee_role_id')
  int? get employeeRoleId;

  /// Required for admin (warehouse or shop). Ignored for seller.
  @BuiltValueField(wireName: r'location_id')
  int? get locationId;

  CreateEmployeeRequest._();

  factory CreateEmployeeRequest([void updates(CreateEmployeeRequestBuilder b)]) = _$CreateEmployeeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateEmployeeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateEmployeeRequest> get serializer => _$CreateEmployeeRequestSerializer();
}

class _$CreateEmployeeRequestSerializer implements PrimitiveSerializer<CreateEmployeeRequest> {
  @override
  final Iterable<Type> types = const [CreateEmployeeRequest, _$CreateEmployeeRequest];

  @override
  final String wireName = r'CreateEmployeeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateEmployeeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'user_id';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    yield r'username';
    yield serializers.serialize(
      object.username,
      specifiedType: const FullType(String),
    );
    yield r'user_number';
    yield serializers.serialize(
      object.userNumber,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    if (object.employeeRoleId != null) {
      yield r'employee_role_id';
      yield serializers.serialize(
        object.employeeRoleId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.locationId != null) {
      yield r'location_id';
      yield serializers.serialize(
        object.locationId,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateEmployeeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateEmployeeRequestBuilder result,
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
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        case r'user_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userNumber = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'employee_role_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.employeeRoleId = valueDes;
          break;
        case r'location_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.locationId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateEmployeeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateEmployeeRequestBuilder();
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

