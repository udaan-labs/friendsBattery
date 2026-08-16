import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';
import '../repository/accounts_repository.dart';

final accountsRepositoryProvider = Provider<AccountsRepository>((ref) {
  return AccountsRepository(ref.watch(apiClientProvider));
});

final accountsRoleFilterProvider = StateProvider<String>((ref) => 'ADMIN');

final accountsSearchProvider = StateProvider<String>((ref) => '');

final accountsListProvider = FutureProvider<List<AccountUser>>((ref) {
  final role = ref.watch(accountsRoleFilterProvider);
  return ref.watch(accountsRepositoryProvider).list(role: role);
});
