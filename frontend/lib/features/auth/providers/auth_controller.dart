import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/auth_repository.dart';
import '../../../core/storage/session_manager.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../core/network/api_client_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(api: ref.watch(apiClientProvider).getAuthApi());
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController(
    repository: ref.read(authRepositoryProvider),
    ref: ref,
  );
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository repository;
  final Ref ref;

  AuthController({required this.repository, required this.ref})
      : super(const AsyncValue.data(null));

  Future<void> login(String username, String password) async {
    if (state.isLoading) return;

    state = const AsyncValue.loading();
    try {
      final response = await repository.login(username.trim(), password);

      final role = parseUserRole(response.role);
      if (role == UserRole.guest) {
        throw Exception('Unsupported account role: ${response.role}');
      }

      await SessionManager.saveSession(
        authId: response.authId,
        authKey: response.authKey,
        role: response.role,
        user: response.user,
      );

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
    int? locationId,
  }) async {
    state = const AsyncValue.loading();
    try {
      await repository.register(
        userId: userId,
        username: username,
        userNumber: userNumber,
        shopName: shopName,
        password: password,
        locationId: locationId,
      );
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> registerAdmin({
    required String userId,
    required String username,
    required String userNumber,
    required String shopName,
    required String password,
    int? locationId,
  }) async {
    state = const AsyncValue.loading();
    try {
      await repository.registerAdmin(
        userId: userId,
        username: username,
        userNumber: userNumber,
        shopName: shopName,
        password: password,
        locationId: locationId,
      );
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }
}
