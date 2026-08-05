import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';
import '../repository/locations_repository.dart';

final locationsRepositoryProvider = Provider<LocationsRepository>((ref) {
  return LocationsRepository(ref.watch(apiClientProvider));
});

/// Family key: `SHOP` or `WAREHOUSE`.
final locationsByTypeProvider =
    FutureProvider.family<List<LocationItem>, String>((ref, type) async {
  return ref.watch(locationsRepositoryProvider).list(type: type);
});
