import 'package:friends_battery_api/api.dart'; // From generated OpenAPI package

class AuthResponse {
  final String authId;
  final String authKey;
  final String role; // 'admin' or 'seller'
  
  AuthResponse({required this.authId, required this.authKey, required this.role});
}

class AuthRepository {
  final AuthApi api; // Use the correct API class from your generated package

  AuthRepository({required this.api});

  Future<AuthResponse> login(String username, String password) async {
    // Mock response for now
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'admin') {
      return AuthResponse(authId: '123', authKey: 'abc', role: 'admin');
    } else {
      return AuthResponse(authId: '456', authKey: 'def', role: 'seller');
    }
  }
}
