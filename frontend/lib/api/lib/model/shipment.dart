//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Shipment {
  /// Returns a new [Shipment] instance.
  Shipment({
    this.id,
    this.fromUserId,
    this.toUserId,
    this.totalProductsShipped,
    this.shipmentPrice,
    this.status,
    this.shippedOn,
    this.deliveredOn,
    this.createdAt,
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
  String? fromUserId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? toUserId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? totalProductsShipped;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? shipmentPrice;

  ShipmentStatusEnum? status;

  DateTime? shippedOn;

  DateTime? deliveredOn;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  List<ShipmentItem> items;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Shipment &&
    other.id == id &&
    other.fromUserId == fromUserId &&
    other.toUserId == toUserId &&
    other.totalProductsShipped == totalProductsShipped &&
    other.shipmentPrice == shipmentPrice &&
    other.status == status &&
    other.shippedOn == shippedOn &&
    other.deliveredOn == deliveredOn &&
    other.createdAt == createdAt &&
    _deepEquality.equals(other.items, items);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (fromUserId == null ? 0 : fromUserId!.hashCode) +
    (toUserId == null ? 0 : toUserId!.hashCode) +
    (totalProductsShipped == null ? 0 : totalProductsShipped!.hashCode) +
    (shipmentPrice == null ? 0 : shipmentPrice!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (shippedOn == null ? 0 : shippedOn!.hashCode) +
    (deliveredOn == null ? 0 : deliveredOn!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (items.hashCode);

  @override
  String toString() => 'Shipment[id=$id, fromUserId=$fromUserId, toUserId=$toUserId, totalProductsShipped=$totalProductsShipped, shipmentPrice=$shipmentPrice, status=$status, shippedOn=$shippedOn, deliveredOn=$deliveredOn, createdAt=$createdAt, items=$items]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
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
    if (this.totalProductsShipped != null) {
      json[r'totalProductsShipped'] = this.totalProductsShipped;
    } else {
      json[r'totalProductsShipped'] = null;
    }
    if (this.shipmentPrice != null) {
      json[r'shipmentPrice'] = this.shipmentPrice;
    } else {
      json[r'shipmentPrice'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.shippedOn != null) {
      json[r'shippedOn'] = this.shippedOn!.toUtc().toIso8601String();
    } else {
      json[r'shippedOn'] = null;
    }
    if (this.deliveredOn != null) {
      json[r'deliveredOn'] = this.deliveredOn!.toUtc().toIso8601String();
    } else {
      json[r'deliveredOn'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
      json[r'items'] = this.items;
    return json;
  }

  /// Returns a new [Shipment] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Shipment? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return Shipment(
        id: mapValueOfType<String>(json, r'id'),
        fromUserId: mapValueOfType<String>(json, r'fromUserId'),
        toUserId: mapValueOfType<String>(json, r'toUserId'),
        totalProductsShipped: mapValueOfType<int>(json, r'totalProductsShipped'),
        shipmentPrice: mapValueOfType<double>(json, r'shipmentPrice'),
        status: ShipmentStatusEnum.fromJson(json[r'status']),
        shippedOn: mapDateTime(json, r'shippedOn', r''),
        deliveredOn: mapDateTime(json, r'deliveredOn', r''),
        createdAt: mapDateTime(json, r'createdAt', r''),
        items: ShipmentItem.listFromJson(json[r'items']),
      );
    }
    return null;
  }

  static List<Shipment> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Shipment>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Shipment.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Shipment> mapFromJson(dynamic json) {
    final map = <String, Shipment>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Shipment.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Shipment-objects as value to a dart map
  static Map<String, List<Shipment>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Shipment>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Shipment.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class ShipmentStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const ShipmentStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const PENDING = ShipmentStatusEnum._(r'PENDING');
  static const APPROVED = ShipmentStatusEnum._(r'APPROVED');
  static const REJECTED = ShipmentStatusEnum._(r'REJECTED');
  static const SHIPPED = ShipmentStatusEnum._(r'SHIPPED');
  static const DELIVERED = ShipmentStatusEnum._(r'DELIVERED');

  /// List of all possible values in this [enum][ShipmentStatusEnum].
  static const values = <ShipmentStatusEnum>[
    PENDING,
    APPROVED,
    REJECTED,
    SHIPPED,
    DELIVERED,
  ];

  static ShipmentStatusEnum? fromJson(dynamic value) => ShipmentStatusEnumTypeTransformer().decode(value);

  static List<ShipmentStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ShipmentStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ShipmentStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ShipmentStatusEnum] to String,
/// and [decode] dynamic data back to [ShipmentStatusEnum].
class ShipmentStatusEnumTypeTransformer {
  factory ShipmentStatusEnumTypeTransformer() => _instance ??= const ShipmentStatusEnumTypeTransformer._();

  const ShipmentStatusEnumTypeTransformer._();

  String encode(ShipmentStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ShipmentStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ShipmentStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'PENDING': return ShipmentStatusEnum.PENDING;
        case r'APPROVED': return ShipmentStatusEnum.APPROVED;
        case r'REJECTED': return ShipmentStatusEnum.REJECTED;
        case r'SHIPPED': return ShipmentStatusEnum.SHIPPED;
        case r'DELIVERED': return ShipmentStatusEnum.DELIVERED;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ShipmentStatusEnumTypeTransformer] instance.
  static ShipmentStatusEnumTypeTransformer? _instance;
}


