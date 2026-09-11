import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import 'device_location.dart';
import 'location_exceptions.dart';

/// GPS only — UI must not call Geolocator / permission_handler.
class LocationService {
  const LocationService();

  Future<void> ensureReady() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationException(
        'Location services are turned off. Please enable GPS and try again.',
      );
    }

    var status = await ph.Permission.locationWhenInUse.status;
    if (status.isDenied) {
      status = await ph.Permission.locationWhenInUse.request();
    }

    if (status.isGranted || status.isLimited) return;

    if (status.isPermanentlyDenied || status.isRestricted) {
      throw const LocationException(
        'Location permission is permanently denied. Open app settings and enable location.',
        openSettings: true,
      );
    }

    throw const LocationException(
      'Location permission was denied. Please allow location access to check in.',
    );
  }

  /// After when-in-use: request Always + notification so Android FGS / iOS background work.
  Future<void> requestShiftTracking() async {
    await ensureReady();
    await ph.Permission.notification.request();
    var always = await ph.Permission.locationAlways.status;
    if (always.isGranted) return;
    await ph.Permission.locationAlways.request();
  }

  Future<DeviceLocation> getCurrentLocation() async {
    await ensureReady();
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );
      return DeviceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        timestamp: position.timestamp,
      );
    } on LocationException {
      rethrow;
    } catch (_) {
      throw const LocationException(
        'Could not read your GPS position. Move outdoors and try again.',
      );
    }
  }

  double distanceMeters({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  bool isWithinRadius({
    required DeviceLocation device,
    required double targetLatitude,
    required double targetLongitude,
    required num allowedRadiusMeters,
  }) {
    return distanceMeters(
          startLatitude: device.latitude,
          startLongitude: device.longitude,
          endLatitude: targetLatitude,
          endLongitude: targetLongitude,
        ) <=
        allowedRadiusMeters;
  }

  /// Live updates while checked in only — caller must cancel on checkout (C8).
  Stream<DeviceLocation> watchShiftLocation() {
    return Geolocator.getPositionStream(locationSettings: _shiftSettings).map(
      (position) => DeviceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        timestamp: position.timestamp,
      ),
    );
  }

  static LocationSettings get _shiftSettings {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 15,
        intervalDuration: const Duration(seconds: 30),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationTitle: 'Checked in',
          notificationText:
              'Sharing live location with your shop while you are on shift',
          notificationChannelName: 'Shift location',
          enableWakeLock: true,
          setOngoing: true,
        ),
      );
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.otherNavigation,
        distanceFilter: 15,
        pauseLocationUpdatesAutomatically: false,
        showBackgroundLocationIndicator: true,
        allowBackgroundLocationUpdates: true,
      );
    }
    return const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 15,
    );
  }

  Future<bool> openAppSettings() => ph.openAppSettings();
}
