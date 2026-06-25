import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/session_manager.dart';

enum UserRole { admin, seller, guest }

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
      if (!isLoggedIn) return;

      final sessionData = await SessionManager.getSessionData();
      final authId = sessionData['auth_id'];
      final authKey = sessionData['auth_key'];
      final roleStr = sessionData['role'];
      
      if (authId != null && authKey != null && roleStr != null) {
        final role = roleStr.toLowerCase() == 'admin' ? UserRole.admin : UserRole.seller;
        setAuthenticated(role);
      }
    } catch (e) {
      // If error occurs during restore, stay as guest
    }
  }

  void setAuthenticated(UserRole role) {
    state = state.copyWith(isAuthenticated: true, role: role);
  }

  Future<void> logout() async {
    try {
      await SessionManager.clearSession();
    } catch (_) {}
    state = AuthState(); // Reset to guest
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
