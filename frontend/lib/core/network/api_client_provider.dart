import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/api.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient(basePath: 'http://localhost:3000');
  
  // Optionally async load headers here, or attach them in the repository.
  return client;
});
