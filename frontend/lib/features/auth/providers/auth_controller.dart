import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/auth_repository.dart';
import '../../../core/storage/session_manager.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../core/network/api_client_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(api: ref.watch(apiClientProvider).getAuthApi());
});

/// null = password step; non-null = waiting for OTP.
final loginOtpChallengeProvider = StateProvider<LoginOtpChallenge?>((ref) => null);

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

  /// Step 1: password → OTP challenge.
  Future<void> login(String username, String password) async {
    if (state.isLoading) return;

    state = const AsyncValue.loading();
    try {
      final challenge = await repository.login(username.trim(), password);
      ref.read(loginOtpChallengeProvider.notifier).state = challenge;

      // OTP Bypass flag (for development/testing - set to true to auto-verify)
      const bool bypassOtp = true;
      if (bypassOtp && challenge.otp != null && challenge.otp!.isNotEmpty) {
        await verifyLoginOtp(challenge.otp!);
        return;
      }

      state = const AsyncValue.data(null);
    } catch (e, stack) {
      ref.read(loginOtpChallengeProvider.notifier).state = null;
      state = AsyncValue.error(e, stack);
    }
  }


  /// Step 2: OTP → session.
  Future<void> verifyLoginOtp(String otp) async {
    if (state.isLoading) return;
    final challenge = ref.read(loginOtpChallengeProvider);
    if (challenge == null) {
      state = AsyncValue.error(Exception('Login again'), StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final response = await repository.verifyLoginOtp(
        challengeId: challenge.challengeId,
        otp: otp.trim(),
      );

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

      ref.read(loginOtpChallengeProvider.notifier).state = null;
      ref.read(authProvider.notifier).setAuthenticated(role);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void cancelOtp() {
    ref.read(loginOtpChallengeProvider.notifier).state = null;
    state = const AsyncValue.data(null);
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
