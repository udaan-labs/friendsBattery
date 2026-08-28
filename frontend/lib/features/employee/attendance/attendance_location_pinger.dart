import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/employee_providers.dart';
import 'device_location.dart';
import 'location_service.dart';

class AttendanceLocationPinger extends ConsumerStatefulWidget {
  const AttendanceLocationPinger({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AttendanceLocationPinger> createState() =>
      _AttendanceLocationPingerState();
}

class _AttendanceLocationPingerState
    extends ConsumerState<AttendanceLocationPinger> {
  StreamSubscription<DeviceLocation>? _sub;
  bool _wantTracking = false;
  bool _listening = false;
  DateTime? _lastPing;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sync(
        ref.read(employeeAttendanceStatusProvider).valueOrNull?.isCheckedIn ==
            true,
      );
    });
  }

  @override
  void dispose() {
    _wantTracking = false;
    _stop();
    super.dispose();
  }

  void _sync(bool checkedIn) {
    _wantTracking = checkedIn;
    if (checkedIn) {
      _start();
    } else {
      _stop();
    }
  }

  void _start() {
    if (!_wantTracking || _listening) return;
    _listening = true;
    _sub = const LocationService().watchShiftLocation().listen(
      (loc) => _send(loc),
      onError: (_) {
        _stop();
        if (!_wantTracking) return;
        Future<void>.delayed(const Duration(seconds: 5), () {
          if (!mounted || !_wantTracking) return;
          _start();
        });
      },
      onDone: () {
        _listening = false;
        _sub = null;
        if (!_wantTracking || !mounted) return;
        Future<void>.delayed(const Duration(seconds: 5), () {
          if (!mounted || !_wantTracking) return;
          _start();
        });
      },
    );
  }

  void _stop() {
    _listening = false;
    _sub?.cancel();
    _sub = null;
  }

  Future<void> _send(DeviceLocation loc) async {
    final now = DateTime.now();
    if (_lastPing != null && now.difference(_lastPing!).inSeconds < 20) {
      return;
    }
    _lastPing = now;
    try {
      await ref.read(employeeAttendanceRepositoryProvider).pingCoords(loc);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(employeeAttendanceStatusProvider, (prev, next) {
      _sync(next.valueOrNull?.isCheckedIn == true);
    });
    return widget.child;
  }
}
