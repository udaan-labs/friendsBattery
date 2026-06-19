import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void setAuthenticated(UserRole role) {
    state = state.copyWith(isAuthenticated: true, role: role);
  }

  void logout() {
    state = AuthState(); // Reset to guest
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
