//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StockRequest {
  /// Returns a new [StockRequest] instance.
  StockRequest({
    this.id,
    this.sellerId,
    this.requestTo,
    this.status,
    this.createdAt,
    this.approvedAt,
    this.items = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sellerId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? requestTo;

  StockRequestStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  DateTime? approvedAt;

  List<StockRequestItem> items;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StockRequest &&
    other.id == id &&
    other.sellerId == sellerId &&
    other.requestTo == requestTo &&
    other.status == status &&
    other.createdAt == createdAt &&
    other.approvedAt == approvedAt &&
    _deepEquality.equals(other.items, items);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (sellerId == null ? 0 : sellerId!.hashCode) +
    (requestTo == null ? 0 : requestTo!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (approvedAt == null ? 0 : approvedAt!.hashCode) +
    (items.hashCode);

  @override
  String toString() => 'StockRequest[id=$id, sellerId=$sellerId, requestTo=$requestTo, status=$status, createdAt=$createdAt, approvedAt=$approvedAt, items=$items]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.sellerId != null) {
      json[r'sellerId'] = this.sellerId;
    } else {
      json[r'sellerId'] = null;
    }
    if (this.requestTo != null) {
      json[r'requestTo'] = this.requestTo;
    } else {
      json[r'requestTo'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    if (this.approvedAt != null) {
      json[r'approvedAt'] = this.approvedAt!.toUtc().toIso8601String();
    } else {
      json[r'approvedAt'] = null;
    }
      json[r'items'] = this.items;
    return json;
  }

  /// Returns a new [StockRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StockRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return StockRequest(
        id: mapValueOfType<String>(json, r'id'),
        sellerId: mapValueOfType<String>(json, r'sellerId'),
        requestTo: mapValueOfType<String>(json, r'requestTo'),
        status: StockRequestStatusEnum.fromJson(json[r'status']),
        createdAt: mapDateTime(json, r'createdAt', r''),
        approvedAt: mapDateTime(json, r'approvedAt', r''),
        items: StockRequestItem.listFromJson(json[r'items']),
      );
    }
    return null;
  }

  static List<StockRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StockRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StockRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StockRequest> mapFromJson(dynamic json) {
    final map = <String, StockRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StockRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StockRequest-objects as value to a dart map
  static Map<String, List<StockRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StockRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StockRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class StockRequestStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const StockRequestStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const PENDING = StockRequestStatusEnum._(r'PENDING');
  static const APPROVED = StockRequestStatusEnum._(r'APPROVED');
  static const REJECTED = StockRequestStatusEnum._(r'REJECTED');
  static const SHIPPED = StockRequestStatusEnum._(r'SHIPPED');
  static const DELIVERED = StockRequestStatusEnum._(r'DELIVERED');

  /// List of all possible values in this [enum][StockRequestStatusEnum].
  static const values = <StockRequestStatusEnum>[
    PENDING,
    APPROVED,
    REJECTED,
    SHIPPED,
    DELIVERED,
  ];

  static StockRequestStatusEnum? fromJson(dynamic value) => StockRequestStatusEnumTypeTransformer().decode(value);

  static List<StockRequestStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StockRequestStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StockRequestStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StockRequestStatusEnum] to String,
/// and [decode] dynamic data back to [StockRequestStatusEnum].
class StockRequestStatusEnumTypeTransformer {
  factory StockRequestStatusEnumTypeTransformer() => _instance ??= const StockRequestStatusEnumTypeTransformer._();

  const StockRequestStatusEnumTypeTransformer._();

  String encode(StockRequestStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a StockRequestStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StockRequestStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'PENDING': return StockRequestStatusEnum.PENDING;
        case r'APPROVED': return StockRequestStatusEnum.APPROVED;
        case r'REJECTED': return StockRequestStatusEnum.REJECTED;
        case r'SHIPPED': return StockRequestStatusEnum.SHIPPED;
        case r'DELIVERED': return StockRequestStatusEnum.DELIVERED;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StockRequestStatusEnumTypeTransformer] instance.
  static StockRequestStatusEnumTypeTransformer? _instance;
}


