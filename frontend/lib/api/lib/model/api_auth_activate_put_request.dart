//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiAuthActivatePutRequest {
  /// Returns a new [ApiAuthActivatePutRequest] instance.
  ApiAuthActivatePutRequest({
    required this.userId,
    required this.isActive,
    required this.isVerified,
  });

  String userId;

  bool isActive;

  bool isVerified;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiAuthActivatePutRequest &&
    other.userId == userId &&
    other.isActive == isActive &&
    other.isVerified == isVerified;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (userId.hashCode) +
    (isActive.hashCode) +
    (isVerified.hashCode);

  @override
  String toString() => 'ApiAuthActivatePutRequest[userId=$userId, isActive=$isActive, isVerified=$isVerified]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'user_id'] = this.userId;
      json[r'is_active'] = this.isActive;
      json[r'is_verified'] = this.isVerified;
    return json;
  }

  /// Returns a new [ApiAuthActivatePutRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiAuthActivatePutRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'user_id'), 'Required key "ApiAuthActivatePutRequest[user_id]" is missing from JSON.');
        assert(json[r'user_id'] != null, 'Required key "ApiAuthActivatePutRequest[user_id]" has a null value in JSON.');
        assert(json.containsKey(r'is_active'), 'Required key "ApiAuthActivatePutRequest[is_active]" is missing from JSON.');
        assert(json[r'is_active'] != null, 'Required key "ApiAuthActivatePutRequest[is_active]" has a null value in JSON.');
        assert(json.containsKey(r'is_verified'), 'Required key "ApiAuthActivatePutRequest[is_verified]" is missing from JSON.');
        assert(json[r'is_verified'] != null, 'Required key "ApiAuthActivatePutRequest[is_verified]" has a null value in JSON.');
        return true;
      }());

      return ApiAuthActivatePutRequest(
        userId: mapValueOfType<String>(json, r'user_id')!,
        isActive: mapValueOfType<bool>(json, r'is_active')!,
        isVerified: mapValueOfType<bool>(json, r'is_verified')!,
      );
    }
    return null;
  }

  static List<ApiAuthActivatePutRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiAuthActivatePutRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiAuthActivatePutRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiAuthActivatePutRequest> mapFromJson(dynamic json) {
    final map = <String, ApiAuthActivatePutRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiAuthActivatePutRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiAuthActivatePutRequest-objects as value to a dart map
  static Map<String, List<ApiAuthActivatePutRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiAuthActivatePutRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiAuthActivatePutRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'user_id',
    'is_active',
    'is_verified',
  };
}

