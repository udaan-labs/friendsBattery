import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';
import '../repository/locations_repository.dart';

final locationsRepositoryProvider = Provider<LocationsRepository>((ref) {
  return LocationsRepository(ref.watch(apiClientProvider));
});

/// All active shops + warehouses (API returns `type` on each item).
final allLocationsProvider = FutureProvider<List<LocationItem>>((ref) async {
  return ref.watch(locationsRepositoryProvider).list();
});

/// Family key: `SHOP` or `WAREHOUSE` (e.g. register shop picker).
final locationsByTypeProvider =
    FutureProvider.family<List<LocationItem>, String>((ref, type) async {
  return ref.watch(locationsRepositoryProvider).list(type: type);
});
