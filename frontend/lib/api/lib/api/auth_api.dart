//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AuthApi {
  AuthApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Activate and verify a user account
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ApiAuthActivatePutRequest] apiAuthActivatePutRequest (required):
  Future<Response> apiAuthActivatePutWithHttpInfo(ApiAuthActivatePutRequest apiAuthActivatePutRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/activate';

    // ignore: prefer_final_locals
    Object? postBody = apiAuthActivatePutRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Activate and verify a user account
  ///
  /// Parameters:
  ///
  /// * [ApiAuthActivatePutRequest] apiAuthActivatePutRequest (required):
  Future<void> apiAuthActivatePut(ApiAuthActivatePutRequest apiAuthActivatePutRequest, { Future<void>? abortTrigger, }) async {
    final response = await apiAuthActivatePutWithHttpInfo(apiAuthActivatePutRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Authenticate user and return token
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ApiAuthLoginPostRequest] apiAuthLoginPostRequest (required):
  Future<Response> apiAuthLoginPostWithHttpInfo(ApiAuthLoginPostRequest apiAuthLoginPostRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/login';

    // ignore: prefer_final_locals
    Object? postBody = apiAuthLoginPostRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Authenticate user and return token
  ///
  /// Parameters:
  ///
  /// * [ApiAuthLoginPostRequest] apiAuthLoginPostRequest (required):
  Future<void> apiAuthLoginPost(ApiAuthLoginPostRequest apiAuthLoginPostRequest, { Future<void>? abortTrigger, }) async {
    final response = await apiAuthLoginPostWithHttpInfo(apiAuthLoginPostRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Register a new user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ApiAuthRegisterPostRequest] apiAuthRegisterPostRequest (required):
  Future<Response> apiAuthRegisterPostWithHttpInfo(ApiAuthRegisterPostRequest apiAuthRegisterPostRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/auth/register';

    // ignore: prefer_final_locals
    Object? postBody = apiAuthRegisterPostRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Register a new user
  ///
  /// Parameters:
  ///
  /// * [ApiAuthRegisterPostRequest] apiAuthRegisterPostRequest (required):
  Future<void> apiAuthRegisterPost(ApiAuthRegisterPostRequest apiAuthRegisterPostRequest, { Future<void>? abortTrigger, }) async {
    final response = await apiAuthRegisterPostWithHttpInfo(apiAuthRegisterPostRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
