import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/employee/attendance/data/location_service.dart';
import 'package:frontend/features/employee/attendance/domain/device_location.dart';

/// Pure distance / radius checks — no device GPS, no permissions.
/// Manual device check-in still needed later.
void main() {
  const svc = LocationService();

  // Same pins as product docs / backend geo.util.test.js
  const shopLat = 23.0225;
  const shopLng = 72.5714;
  const nearLat = 23.0228;
  const nearLng = 72.5718;
  const farLat = 23.04;
  const farLng = 72.59;

  DeviceLocation device(double lat, double lng) => DeviceLocation(
        latitude: lat,
        longitude: lng,
        accuracy: 10,
        timestamp: DateTime.utc(2026, 1, 1),
      );

  group('distanceMeters', () {
    test('same point is 0', () {
      expect(
        svc.distanceMeters(
          startLatitude: shopLat,
          startLongitude: shopLng,
          endLatitude: shopLat,
          endLongitude: shopLng,
        ),
        0,
      );
    });

    test('near shop is roughly 45m and within 100m', () {
      final m = svc.distanceMeters(
        startLatitude: shopLat,
        startLongitude: shopLng,
        endLatitude: nearLat,
        endLongitude: nearLng,
      );
      expect(m, greaterThan(30));
      expect(m, lessThan(80));
      expect(m, lessThanOrEqualTo(100));
    });

    test('far point is well outside 100m', () {
      final m = svc.distanceMeters(
        startLatitude: shopLat,
        startLongitude: shopLng,
        endLatitude: farLat,
        endLongitude: farLng,
      );
      expect(m, greaterThan(1000));
    });
  });

  group('isWithinRadius', () {
    test('allows employee inside allowedRadius', () {
      expect(
        svc.isWithinRadius(
          device: device(nearLat, nearLng),
          targetLatitude: shopLat,
          targetLongitude: shopLng,
          allowedRadiusMeters: 100,
        ),
        isTrue,
      );
    });

    test('blocks employee outside allowedRadius', () {
      expect(
        svc.isWithinRadius(
          device: device(farLat, farLng),
          targetLatitude: shopLat,
          targetLongitude: shopLng,
          allowedRadiusMeters: 100,
        ),
        isFalse,
      );
    });

    test('boundary: distance == radius counts as inside', () {
      // 0 distance always inside any positive radius
      expect(
        svc.isWithinRadius(
          device: device(shopLat, shopLng),
          targetLatitude: shopLat,
          targetLongitude: shopLng,
          allowedRadiusMeters: 0,
        ),
        isTrue,
      );
    });
  });
}
