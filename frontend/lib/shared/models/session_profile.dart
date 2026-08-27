import '../../core/storage/session_manager.dart';

/// Display profile from the session user map (seller / employee dashboards).
class SessionProfile {
  const SessionProfile({
    required this.userName,
    required this.shopName,
    required this.role,
  });

  final String userName;
  final String shopName;
  final String role;

  factory SessionProfile.fromSession({
    required String fallbackName,
    required String fallbackRole,
  }) {
    final user = SessionManager.user;
    if (user == null) {
      return SessionProfile(
        userName: fallbackName,
        shopName: '',
        role: fallbackRole,
      );
    }
    return SessionProfile(
      userName: (user['username'] ?? user['userName'] ?? fallbackName).toString(),
      shopName: (user['shop_name'] ?? user['shopName'] ?? '').toString(),
      role: (user['role'] ?? fallbackRole).toString(),
    );
  }
}
