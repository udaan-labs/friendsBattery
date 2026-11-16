import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/auth_token_cache.dart';
import '../../core/storage/session_manager.dart';

enum UserRole { superAdmin, admin, seller, employee, guest }

/// Map API/session role string (case-insensitive) to [UserRole].
UserRole parseUserRole(String? roleStr) {
  switch (roleStr?.toLowerCase()) {
    case 'super_admin':
    case 'superadmin':
      return UserRole.superAdmin;
    case 'admin':
      return UserRole.admin;
    case 'employee':
      return UserRole.employee;
    case 'seller':
      return UserRole.seller;
    default:
      // Never invent rights for unknown/missing role
      return UserRole.guest;
  }
}

/// Home path for an authenticated role (used by router redirects).
/// Super Admin uses the existing admin shell until §1 dedicated SA UI.
String homePathForRole(UserRole role) {
  switch (role) {
    case UserRole.superAdmin:
    case UserRole.admin:
      return '/admin/dashboard';
    case UserRole.seller:
      return '/seller/dashboard';
    case UserRole.employee:
      return '/employee/home';
    case UserRole.guest:
      return '/login';
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
      await _restoreSession().timeout(const Duration(seconds: 8));
    } catch (e) {
      // Timeout or storage error → stay guest; user can log in.
    }
  }

  Future<void> _restoreSession() async {
    final isLoggedIn = await SessionManager.isLoggedIn();
    if (!isLoggedIn) {
      AuthTokenCache.clear();
      return;
    }

    // Load Hive session into the memory cache Dio reads.
    final sessionData = await SessionManager.getSessionData();
    final authId = sessionData['auth_id'];
    final authKey = sessionData['auth_key'];
    final roleStr = sessionData['role'];

    if (authId != null && authKey != null && roleStr != null) {
      AuthTokenCache.set(authId: authId, authKey: authKey, role: roleStr);
      setAuthenticated(parseUserRole(roleStr));
    }
  }

  void setAuthenticated(UserRole role) {
    state = state.copyWith(isAuthenticated: true, role: role);
  }

  /// Local session kill. Wipes Hive and restarts the provider tree.
  /// Call API logout first when online.
  Future<void> logout() async {
    final restarting = SessionManager.restartTick.value;
    try {
      await SessionManager.clearSession();
    } catch (_) {}
    // A running app listens to [SessionManager.restartTick] and drops this notifier.
    if (SessionManager.restartTick.value != restarting) return;
    AuthTokenCache.clear();
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
