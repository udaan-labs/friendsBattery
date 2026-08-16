import 'package:dio/dio.dart';

typedef PlaceHit = ({String displayName, double latitude, double longitude});

/// Fresh Dio — must not reuse the app client (that one attaches JWT).
final _nominatim = Dio(
  BaseOptions(
    baseUrl: 'https://nominatim.openstreetmap.org',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: const {
      'User-Agent': 'FriendsBattery/1.1.3 (com.friends.batteryapp)',
    },
  ),
);

Future<List<PlaceHit>> _lookup(String q) async {
  final res = await _nominatim.get<dynamic>(
    '/search',
    queryParameters: {
      'q': q,
      'format': 'json',
      'limit': 5,
      'countrycodes': 'in',
    },
  );
  final raw = res.data;
  if (raw is! List) return const [];

  final hits = <PlaceHit>[];
  for (final row in raw) {
    if (row is! Map) continue;
    final name = row['display_name']?.toString();
    final lat = double.tryParse(row['lat']?.toString() ?? '');
    final lon = double.tryParse(row['lon']?.toString() ?? '');
    if (name == null || name.isEmpty || lat == null || lon == null) continue;
    hits.add((displayName: name, latitude: lat, longitude: lon));
  }
  return hits;
}

Future<List<PlaceHit>> searchPlaces(String query) async {
  final words = query
      .trim()
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      .toList();
  if (words.isEmpty) {
    throw Exception('Type a place to search');
  }

  try {
    final full = await _lookup(words.join(' '));
    if (full.isNotEmpty) return full;

    final head = words.where((w) => w.length >= 3).firstOrNull;
    if (head != null && head != words.join(' ')) {
      final hits = await _lookup(head);
      if (hits.isNotEmpty) return hits;
    }
    throw Exception('No places found');
  } on DioException {
    throw Exception('Could not search places');
  }
}
