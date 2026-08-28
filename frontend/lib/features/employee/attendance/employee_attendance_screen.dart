import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/shared/common.dart';

import '../../../theme/app_theme.dart';
import '../dashboard/screens/employee_shell_screen.dart';
import '../providers/employee_providers.dart';
import 'location_exceptions.dart';

class EmployeeAttendanceScreen extends ConsumerStatefulWidget {
  const EmployeeAttendanceScreen({super.key});

  @override
  ConsumerState<EmployeeAttendanceScreen> createState() =>
      _EmployeeAttendanceScreenState();
}

class _EmployeeAttendanceScreenState
    extends ConsumerState<EmployeeAttendanceScreen> {
  bool _busy = false;
  bool _offerSettings = false;

  Future<void> _submit({required bool checkOut}) async {
    final status = ref.read(employeeAttendanceStatusProvider).valueOrNull;
    final loc = status?.location ?? status?.attendance?.location;
    final repo = ref.read(employeeAttendanceRepositoryProvider);

    setState(() {
      _busy = true;
      _offerSettings = false;
    });
    try {
      if (checkOut) {
        await repo.checkOut(loc);
      } else {
        await repo.checkIn(loc);
      }
      ref.invalidate(employeeAttendanceStatusProvider);
      if (!mounted) return;
      context.showSuccessSnackBar(
        checkOut ? 'Checked out successfully' : 'Checked in successfully',
      );
    } on LocationException catch (e) {
      if (!mounted) return;
      setState(() => _offerSettings = e.openSettings);
      context.showErrorSnackBar(e.message);
    } catch (e) {
      if (!mounted) return;
      context.showFriendlyError(e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(employeeAttendanceStatusProvider);

    return PopScope(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go('/employee/home');
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FB),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF7F9FB),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF3E4A3D)),
            onPressed: () => employeeScaffoldKey.currentState?.openDrawer(),
          ),
          title: const Text(
            'Check-in / Check-out',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: statusAsync.when(
          data: (status) {
            final inShift = status.isCheckedIn == true;
            final loc = status.location ?? status.attendance?.location;
            final locName = loc?.name ?? 'Your shop';
            final radius = loc?.allowedRadius;
            final checkInTime = status.attendance?.checkInTime;

            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _StatusCard(
                    inShift: inShift,
                    locName: locName,
                    radius: radius,
                    checkInTime: checkInTime,
                  ),
                  const SizedBox(height: 24),
                  if (_offerSettings)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextButton(
                        onPressed: () => ref
                            .read(employeeAttendanceRepositoryProvider)
                            .openAppSettings(),
                        child: const Text('Open app settings'),
                      ),
                    ),
                  if (_busy)
                    const Center(child: CircularProgressIndicator())
                  else
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => _submit(checkOut: inShift),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              inShift ? AppTheme.error : AppTheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                        child: Text(
                          inShift ? 'Check out' : 'Check in',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  const Text(
                    'Check-in requires GPS at your assigned shop. While checked in, a notification stays on so the map can update even if you leave the app. Check-out stops sharing.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load attendance'),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () =>
                      ref.invalidate(employeeAttendanceStatusProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.inShift,
    required this.locName,
    required this.radius,
    required this.checkInTime,
  });

  final bool inShift;
  final String locName;
  final int? radius;
  final DateTime? checkInTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            inShift ? Icons.how_to_reg_rounded : Icons.login_rounded,
            size: 56,
            color: inShift ? AppTheme.success : AppTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            inShift ? 'You are checked in' : 'You are checked out',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191C1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            locName,
            style: const TextStyle(fontSize: 14, color: Color(0xFF545F73)),
            textAlign: TextAlign.center,
          ),
          if (radius != null) ...[
            const SizedBox(height: 4),
            Text(
              'Must be within ${radius}m of this location',
              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          ],
          if (inShift && checkInTime != null) ...[
            const SizedBox(height: 8),
            Text(
              'Since ${checkInTime!.toLocal()}',
              style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
          ],
        ],
      ),
    );
  }
}
