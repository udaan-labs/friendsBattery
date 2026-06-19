//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InventoryTransaction {
  /// Returns a new [InventoryTransaction] instance.
  InventoryTransaction({
    this.id,
    this.productUnitId,
    this.fromUserId,
    this.toUserId,
    this.action,
    this.timestamp,
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
  String? productUnitId;

  String? fromUserId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? toUserId;

  InventoryTransactionActionEnum? action;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? timestamp;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InventoryTransaction &&
    other.id == id &&
    other.productUnitId == productUnitId &&
    other.fromUserId == fromUserId &&
    other.toUserId == toUserId &&
    other.action == action &&
    other.timestamp == timestamp;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (productUnitId == null ? 0 : productUnitId!.hashCode) +
    (fromUserId == null ? 0 : fromUserId!.hashCode) +
    (toUserId == null ? 0 : toUserId!.hashCode) +
    (action == null ? 0 : action!.hashCode) +
    (timestamp == null ? 0 : timestamp!.hashCode);

  @override
  String toString() => 'InventoryTransaction[id=$id, productUnitId=$productUnitId, fromUserId=$fromUserId, toUserId=$toUserId, action=$action, timestamp=$timestamp]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.productUnitId != null) {
      json[r'productUnitId'] = this.productUnitId;
    } else {
      json[r'productUnitId'] = null;
    }
    if (this.fromUserId != null) {
      json[r'fromUserId'] = this.fromUserId;
    } else {
      json[r'fromUserId'] = null;
    }
    if (this.toUserId != null) {
      json[r'toUserId'] = this.toUserId;
    } else {
      json[r'toUserId'] = null;
    }
    if (this.action != null) {
      json[r'action'] = this.action;
    } else {
      json[r'action'] = null;
    }
    if (this.timestamp != null) {
      json[r'timestamp'] = this.timestamp!.toUtc().toIso8601String();
    } else {
      json[r'timestamp'] = null;
    }
    return json;
  }

  /// Returns a new [InventoryTransaction] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InventoryTransaction? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return InventoryTransaction(
        id: mapValueOfType<String>(json, r'id'),
        productUnitId: mapValueOfType<String>(json, r'productUnitId'),
        fromUserId: mapValueOfType<String>(json, r'fromUserId'),
        toUserId: mapValueOfType<String>(json, r'toUserId'),
        action: InventoryTransactionActionEnum.fromJson(json[r'action']),
        timestamp: mapDateTime(json, r'timestamp', r''),
      );
    }
    return null;
  }

  static List<InventoryTransaction> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InventoryTransaction>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InventoryTransaction.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InventoryTransaction> mapFromJson(dynamic json) {
    final map = <String, InventoryTransaction>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InventoryTransaction.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InventoryTransaction-objects as value to a dart map
  static Map<String, List<InventoryTransaction>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<InventoryTransaction>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InventoryTransaction.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class InventoryTransactionActionEnum {
  /// Instantiate a new enum with the provided [value].
  const InventoryTransactionActionEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const RECEIVED = InventoryTransactionActionEnum._(r'RECEIVED');
  static const SHIPPED = InventoryTransactionActionEnum._(r'SHIPPED');
  static const SOLD = InventoryTransactionActionEnum._(r'SOLD');
  static const RETURNED = InventoryTransactionActionEnum._(r'RETURNED');
  static const TRANSFERRED = InventoryTransactionActionEnum._(r'TRANSFERRED');

  /// List of all possible values in this [enum][InventoryTransactionActionEnum].
  static const values = <InventoryTransactionActionEnum>[
    RECEIVED,
    SHIPPED,
    SOLD,
    RETURNED,
    TRANSFERRED,
  ];

  static InventoryTransactionActionEnum? fromJson(dynamic value) => InventoryTransactionActionEnumTypeTransformer().decode(value);

  static List<InventoryTransactionActionEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InventoryTransactionActionEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InventoryTransactionActionEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [InventoryTransactionActionEnum] to String,
/// and [decode] dynamic data back to [InventoryTransactionActionEnum].
class InventoryTransactionActionEnumTypeTransformer {
  factory InventoryTransactionActionEnumTypeTransformer() => _instance ??= const InventoryTransactionActionEnumTypeTransformer._();

  const InventoryTransactionActionEnumTypeTransformer._();

  String encode(InventoryTransactionActionEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a InventoryTransactionActionEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  InventoryTransactionActionEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'RECEIVED': return InventoryTransactionActionEnum.RECEIVED;
        case r'SHIPPED': return InventoryTransactionActionEnum.SHIPPED;
        case r'SOLD': return InventoryTransactionActionEnum.SOLD;
        case r'RETURNED': return InventoryTransactionActionEnum.RETURNED;
        case r'TRANSFERRED': return InventoryTransactionActionEnum.TRANSFERRED;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [InventoryTransactionActionEnumTypeTransformer] instance.
  static InventoryTransactionActionEnumTypeTransformer? _instance;
}


