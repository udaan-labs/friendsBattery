import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../dashboard/screens/employee_shell_screen.dart';
import '../../providers/employee_providers.dart';

class EmployeeAttendanceScreen extends ConsumerStatefulWidget {
  const EmployeeAttendanceScreen({super.key});

  @override
  ConsumerState<EmployeeAttendanceScreen> createState() => _EmployeeAttendanceScreenState();
}

class _EmployeeAttendanceScreenState extends ConsumerState<EmployeeAttendanceScreen> {
  bool _busy = false;
  String? _message;

  Future<void> _checkIn() async {
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      await ref.read(employeeAttendanceRepositoryProvider).checkIn();
      ref.invalidate(employeeAttendanceStatusProvider);
      setState(() => _message = 'Checked in successfully');
    } catch (e) {
      setState(() => _message = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _checkOut() async {
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      await ref.read(employeeAttendanceRepositoryProvider).checkOut();
      ref.invalidate(employeeAttendanceStatusProvider);
      setState(() => _message = 'Checked out successfully');
    } catch (e) {
      setState(() => _message = e.toString().replaceFirst('Exception: ', ''));
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
            final locName = status.location?.name ?? status.attendance?.location?.name ?? 'Your shop';
            final checkInTime = status.attendance?.checkInTime;

            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
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
                        if (inShift && checkInTime != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Since ${checkInTime.toLocal()}',
                            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_message != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        _message!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _message!.toLowerCase().contains('fail') ||
                                  _message!.toLowerCase().contains('already') ||
                                  _message!.toLowerCase().contains('not ')
                              ? AppTheme.error
                              : AppTheme.success,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  if (_busy)
                    const Center(child: CircularProgressIndicator())
                  else if (inShift)
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _checkOut,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.error,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                        ),
                        child: const Text('Check out', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    )
                  else
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _checkIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                        ),
                        child: const Text('Check in', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  const Spacer(),
                  const Text(
                    'GPS is optional for now. Check-in uses your assigned shop location on the server.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load attendance'),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => ref.invalidate(employeeAttendanceStatusProvider),
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
