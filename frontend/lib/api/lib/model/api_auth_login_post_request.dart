//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiAuthLoginPostRequest {
  /// Returns a new [ApiAuthLoginPostRequest] instance.
  ApiAuthLoginPostRequest({
    required this.userId,
    required this.password,
  });

  String userId;

  String password;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiAuthLoginPostRequest &&
    other.userId == userId &&
    other.password == password;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (userId.hashCode) +
    (password.hashCode);

  @override
  String toString() => 'ApiAuthLoginPostRequest[userId=$userId, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'user_id'] = this.userId;
      json[r'password'] = this.password;
    return json;
  }

  /// Returns a new [ApiAuthLoginPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiAuthLoginPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'user_id'), 'Required key "ApiAuthLoginPostRequest[user_id]" is missing from JSON.');
        assert(json[r'user_id'] != null, 'Required key "ApiAuthLoginPostRequest[user_id]" has a null value in JSON.');
        assert(json.containsKey(r'password'), 'Required key "ApiAuthLoginPostRequest[password]" is missing from JSON.');
        assert(json[r'password'] != null, 'Required key "ApiAuthLoginPostRequest[password]" has a null value in JSON.');
        return true;
      }());

      return ApiAuthLoginPostRequest(
        userId: mapValueOfType<String>(json, r'user_id')!,
        password: mapValueOfType<String>(json, r'password')!,
      );
    }
    return null;
  }

  static List<ApiAuthLoginPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiAuthLoginPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiAuthLoginPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiAuthLoginPostRequest> mapFromJson(dynamic json) {
    final map = <String, ApiAuthLoginPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiAuthLoginPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiAuthLoginPostRequest-objects as value to a dart map
  static Map<String, List<ApiAuthLoginPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiAuthLoginPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiAuthLoginPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'user_id',
    'password',
  };
}

