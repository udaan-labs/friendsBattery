import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../../shared/staff/providers/staff_providers.dart';
import '../../../shared/staff/widgets/staff_member_group.dart';
import '../../dashboard/screens/seller_shell_screen.dart';

/// Seller: employees at own shop + add employee.
class SellerStaffScreen extends ConsumerWidget {
  const SellerStaffScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(sellerMyStaffProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF3E4A3D)),
          onPressed: () => sellerScaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text(
          'My Team',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/seller/add-employee'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add employee'),
      ),
      body: staffAsync.when(
        data: (data) => RefreshIndicator(
          onRefresh: () => ref.refresh(sellerMyStaffProvider.future),
          child: _EmployeeList(data: data),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  e.toString().replaceFirst('Exception: ', ''),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => ref.invalidate(sellerMyStaffProvider),
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

class _EmployeeList extends StatelessWidget {
  const _EmployeeList({required this.data});

  final ShopStaffData data;

  @override
  Widget build(BuildContext context) {
    final location = data.location;
    final employees = data.employees?.toList() ?? [];

    if (location == null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: const [
          SizedBox(height: 80),
          Icon(Icons.store_mall_directory_outlined, size: 56, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No shop location assigned',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Contact admin to assign your account to a shop before adding employees.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF64748B)),
          ),
        ],
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        Text(
          '${location.name ?? 'Shop'}${location.code != null ? ' · ${location.code}' : ''}',
          style: const TextStyle(fontSize: 13, color: Color(0xFF545F73)),
        ),
        const SizedBox(height: 16),
        StaffMemberGroup(
          title: 'Employees',
          color: const Color(0xFF2563EB),
          icon: Icons.badge_rounded,
          members: employees,
          emptyLabel: 'No employees yet. Tap Add employee.',
        ),
      ],
    );
  }
}
