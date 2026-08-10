import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../theme/app_theme.dart';
import '../../providers/employee_providers.dart';
import 'employee_shell_screen.dart';

class EmployeeHomeScreen extends ConsumerWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(employeeProfileProvider);
    final attendanceAsync = ref.watch(employeeAttendanceStatusProvider);
    final stockAsync = ref.watch(employeeStockCountProvider);
    final shipmentsAsync = ref.watch(employeeShipmentsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF3E4A3D)),
          onPressed: () => employeeScaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(
          'Friends Battery',
          style: TextStyle(
            fontSize: ResponsiveHelper.isSmallPhone(context) ? 22 : 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF16A34A),
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => refreshEmployeeDashboard(ref),
          color: AppTheme.primary,
          backgroundColor: Colors.white,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: [
              Text(
                'Hello, ${profile.userName.split(' ').first}',
                style: TextStyle(
                  fontSize: ResponsiveHelper.isSmallPhone(context) ? 22 : 28,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF191C1E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                [
                  if (profile.shopName.isNotEmpty) profile.shopName,
                  'Employee',
                ].join(' · '),
                style: TextStyle(
                  fontSize: ResponsiveHelper.isSmallPhone(context) ? 13 : 16,
                  color: const Color(0xFF545F73),
                ),
              ),
              const SizedBox(height: 24),

              // Attendance status card
              attendanceAsync.when(
                data: (status) {
                  final inShift = status.isCheckedIn == true;
                  return _StatusCard(
                    title: inShift ? 'Checked in' : 'Not checked in',
                    subtitle: inShift
                        ? (status.attendance?.checkInTime != null
                            ? status.attendance!.checkInTime!.toLocal().toString()
                            : 'On shift')
                        : 'Tap Check-in when you arrive at the shop',
                    color: inShift ? const Color(0xFF16A34A) : const Color(0xFFD97706),
                    bg: inShift ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                    icon: inShift ? Icons.how_to_reg_rounded : Icons.schedule_rounded,
                    actionLabel: inShift ? 'Check out' : 'Check in',
                    onAction: () => context.go('/employee/attendance'),
                  );
                },
                loading: () => const _LoadingCard(),
                error: (_, __) => _StatusCard(
                  title: 'Attendance',
                  subtitle: 'Could not load status',
                  color: const Color(0xFFBA1A1A),
                  bg: const Color(0xFFFEE2E2),
                  icon: Icons.error_outline,
                  actionLabel: 'Retry',
                  onAction: () => ref.invalidate(employeeAttendanceStatusProvider),
                ),
              ),
              const SizedBox(height: 16),

              // KPI row
              Row(
                children: [
                  Expanded(
                    child: stockAsync.when(
                      data: (n) => _KpiTile(
                        label: 'Shop stock',
                        value: '$n',
                        icon: Icons.inventory_2_rounded,
                        onTap: () => context.go('/employee/inventory'),
                      ),
                      loading: () => const _KpiTile(label: 'Shop stock', value: '…', icon: Icons.inventory_2_rounded),
                      error: (_, __) => _KpiTile(
                        label: 'Shop stock',
                        value: '—',
                        icon: Icons.inventory_2_rounded,
                        onTap: () => context.go('/employee/inventory'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: shipmentsAsync.when(
                      data: (list) => _KpiTile(
                        label: 'Shipments',
                        value: '${list.length}',
                        icon: Icons.local_shipping_rounded,
                        onTap: () => context.go('/employee/shipments'),
                      ),
                      loading: () =>
                          const _KpiTile(label: 'Shipments', value: '…', icon: Icons.local_shipping_rounded),
                      error: (_, __) => _KpiTile(
                        label: 'Shipments',
                        value: '—',
                        icon: Icons.local_shipping_rounded,
                        onTap: () => context.go('/employee/shipments'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text(
                'Quick actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
              ),
              const SizedBox(height: 12),
              _ActionTile(
                icon: Icons.receipt_long_rounded,
                title: 'Create bill',
                subtitle: 'Sell a battery from shop stock',
                onTap: () => context.push('/employee/create-bill'),
              ),
              const SizedBox(height: 10),
              _ActionTile(
                icon: Icons.inventory_2_outlined,
                title: 'View stock',
                subtitle: 'Batteries at your shop location',
                onTap: () => context.go('/employee/inventory'),
              ),
              const SizedBox(height: 10),
              _ActionTile(
                icon: Icons.local_shipping_outlined,
                title: 'View shipments',
                subtitle: 'Deliveries to your shop (read-only)',
                onTap: () => context.go('/employee/shipments'),
              ),
              const SizedBox(height: 10),
              _ActionTile(
                icon: Icons.fingerprint,
                title: 'Check-in / Check-out',
                subtitle: 'Mark when you start and end your shift',
                onTap: () => context.go('/employee/attendance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final Color bg;
  final IconData icon;
  final String actionLabel;
  final VoidCallback onAction;

  const _StatusCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.bg,
    required this.icon,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF545F73)), maxLines: 2),
              ],
            ),
          ),
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(foregroundColor: const Color(0xFF006B2C)),
            child: Text(actionLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }
}

class _KpiTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  const _KpiTile({
    required this.label,
    required this.value,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF16A34A), size: 22),
              const SizedBox(height: 10),
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF191C1E))),
              const SizedBox(height: 2),
              Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF545F73))),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF16A34A)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF545F73))),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF64748B)),
            ],
          ),
        ),
      ),
    );
  }
}
