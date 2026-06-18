import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/api.dart';
import '../repository/auth_repository.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../core/network/api_client_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(api: AuthApi(ref.watch(apiClientProvider)));
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
      
      await SecureStorage.saveAuthData(response.authId, response.authKey);
      
      final role = response.role == 'admin' ? UserRole.admin : UserRole.seller;
      ref.read(authProvider.notifier).setAuthenticated(role);
      
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
