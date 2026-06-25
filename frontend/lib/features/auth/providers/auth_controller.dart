import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../repository/auth_repository.dart';
import '../../../core/storage/session_manager.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../core/network/api_client_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(api: ref.watch(apiClientProvider).getAuthApi());
});

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController(
    repository: ref.read(authRepositoryProvider),
    ref: ref,
  );
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository repository;
  final Ref ref;

  AuthController({required this.repository, required this.ref}) : super(const AsyncValue.data(null));

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final response = await repository.login(username, password);
      
      await SessionManager.saveSession(
        authId: response.authId,
        authKey: response.authKey,
        role: response.role,
        user: response.user,
      );
      
      final role = response.role.toLowerCase() == 'admin' ? UserRole.admin : UserRole.seller;
      ref.read(authProvider.notifier).setAuthenticated(role);
      
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> register({
    required String userId,
    required String username,
    required String userNumber,
    required String shopName,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      await repository.register(
        userId: userId,
        username: username,
        userNumber: userNumber,
        shopName: shopName,
        password: password,
      );
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }
}
