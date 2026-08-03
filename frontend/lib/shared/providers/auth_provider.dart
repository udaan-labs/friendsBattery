import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/auth_token_cache.dart';
import '../../core/storage/session_manager.dart';

enum UserRole { admin, seller, employee, guest }

/// Map API/session role string (case-insensitive) to [UserRole].
UserRole parseUserRole(String? roleStr) {
  switch (roleStr?.toLowerCase()) {
    case 'admin':
      return UserRole.admin;
    case 'employee':
      return UserRole.employee;
    case 'seller':
      return UserRole.seller;
    default:
      // Never invent seller rights for unknown/missing role
      return UserRole.guest;
  }
}

class AuthState {
  final bool isAuthenticated;
  final UserRole role;

  AuthState({
    this.isAuthenticated = false,
    this.role = UserRole.guest,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    UserRole? role,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      role: role ?? this.role,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> initSession() async {
    try {
      final isLoggedIn = await SessionManager.isLoggedIn();
      if (!isLoggedIn) {
        AuthTokenCache.clear();
        return;
      }

      // Parallel secure reads + populate memory cache for Dio.
      final sessionData = await SessionManager.getSessionData();
      final authId = sessionData['auth_id'];
      final authKey = sessionData['auth_key'];
      final roleStr = sessionData['role'];

      if (authId != null && authKey != null && roleStr != null) {
        AuthTokenCache.set(authId: authId, authKey: authKey, role: roleStr);
        setAuthenticated(parseUserRole(roleStr));
      }
    } catch (e) {
      // If error occurs during restore, stay as guest
    }
  }

  void setAuthenticated(UserRole role) {
    state = state.copyWith(isAuthenticated: true, role: role);
  }

  /// Local session kill only (tokens + state). Call API logout first when online.
  Future<void> logout() async {
    try {
      await SessionManager.clearSession();
    } catch (_) {}
    AuthTokenCache.clear();
    state = AuthState(); // Reset to guest
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
