import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/state/data_sync.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../accounts/providers/accounts_providers.dart';
import '../../locations/widgets/location_staff_actions.dart';
import '../providers/sellers_provider.dart';
import '../widgets/change_password_dialog.dart';

class SellersListScreen extends ConsumerStatefulWidget {
  const SellersListScreen({super.key});

  @override
  ConsumerState<SellersListScreen> createState() => _SellersListScreenState();
}

class _SellersListScreenState extends ConsumerState<SellersListScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              if (_isSearching) {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                  _query = '';
                });
                return;
              }
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/admin/dashboard');
              }
            },
          ),
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  onChanged: (val) => setState(() => _query = val),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Search staff by name, phone, shop, or ID…',
                    hintStyle: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                  ),
                )
              : const Text(
                  'Staff',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          actions: [
            IconButton(
              icon: const Icon(Icons.location_on_outlined, color: Color(0xFF006B2C)),
              tooltip: 'Checked-in Staff Map',
              onPressed: () => context.push('/admin/checked-in'),
            ),
            IconButton(
              icon: Icon(
                _isSearching ? Icons.close : Icons.search,
                color: Colors.black,
              ),
              tooltip: _isSearching ? 'Close search' : 'Search staff',
              onPressed: () {
                setState(() {
                  if (_isSearching) {
                    _isSearching = false;
                    _searchController.clear();
                    _query = '';
                  } else {
                    _isSearching = true;
                  }
                });
              },
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.person_add_alt_1, color: Color(0xFF006B2C)),
              tooltip: 'Add Staff',
              onSelected: (value) {
                if (value == 'seller') {
                  context.push('/admin/add-seller');
                } else if (value == 'employee') {
                  context.push('/admin/add-employee');
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'seller',
                  child: Row(
                    children: [
                      Icon(Icons.storefront_rounded, color: Color(0xFF006B2C), size: 20),
                      SizedBox(width: 12),
                      Text('Add Seller'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'employee',
                  child: Row(
                    children: [
                      Icon(Icons.badge_rounded, color: Color(0xFF2563EB), size: 20),
                      SizedBox(width: 12),
                      Text('Add Employee'),
                    ],
                  ),
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            labelColor: Color(0xFF006B2C),
            unselectedLabelColor: Color(0xFF64748B),
            indicatorColor: Color(0xFF006B2C),
            indicatorWeight: 3,
            tabs: [
              Tab(
                icon: Icon(Icons.storefront_rounded, size: 20),
                text: 'Sellers',
              ),
              Tab(
                icon: Icon(Icons.badge_rounded, size: 20),
                text: 'Employees',
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _SellersTabView(searchQuery: _query),
              _EmployeesTabView(searchQuery: _query),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _toggleStaffActive(
  BuildContext context,
  WidgetRef ref, {
  required int id,
  required String name,
  required bool nextActive,
}) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(nextActive ? 'Activate Account?' : 'Deactivate Account?'),
      content: Text(
        nextActive
            ? 'Are you sure you want to activate $name? They will be able to log in and access the system.'
            : 'Are you sure you want to deactivate $name? They will not be able to log in until reactivated.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: nextActive ? const Color(0xFF006B2C) : Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(nextActive ? 'Activate' : 'Deactivate'),
        ),
      ],
    ),
  );
  if (confirm != true || !context.mounted) return;

  try {
    await ref.read(accountsRepositoryProvider).setActive(
          id: id,
          isActive: nextActive,
        );
    DataSync.afterStaffMutation(ref);
    if (!context.mounted) return;
    context.showSuccessSnackBar(
      nextActive ? '$name account activated' : '$name account deactivated',
    );
  } catch (e) {
    if (!context.mounted) return;
    context.showFriendlyError(e);
  }
}

class _SellersTabView extends ConsumerWidget {
  const _SellersTabView({required this.searchQuery});

  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellersAsyncValue = ref.watch(sellersProvider);

    return sellersAsyncValue.when(
      data: (allSellers) {
        final q = searchQuery.trim().toLowerCase();
        final sellers = q.isEmpty
            ? allSellers
            : allSellers.where((s) {
                final text = [
                  s.seller.userName,
                  s.seller.shopName,
                  s.seller.userNumber,
                  s.seller.id,
                ].whereType<String>().join(' ').toLowerCase();
                return text.contains(q);
              }).toList();

        if (sellers.isEmpty) {
          return Center(
            child: Text(
              q.isEmpty ? 'No sellers found.' : 'No sellers matching "$searchQuery"',
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => ref.refresh(sellersProvider.future),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: sellers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final sellerData = sellers[index];
              final seller = sellerData.seller;
              final sellerId = int.tryParse(seller.id ?? '');
              final isVerified = seller.isVerified ?? false;
              final isActive = seller.isActive ?? true;

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: sellerId != null ? () => context.push('/admin/seller/$sellerId') : null,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.storefront_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        seller.userName ?? seller.shopName ?? 'Unknown Seller',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (isVerified) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.verified, color: Colors.green, size: 14),
                                      ),
                                    ],
                                    if (sellerData.hasLowStock == true) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Text('Low Stock', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF64748B)),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        '${seller.shopName ?? 'No Shop Location'} • ${seller.userNumber ?? 'No Phone'}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      const SizedBox(width: 8),
                      if (sellerId != null)
                        _StaffRowActions(
                          id: sellerId,
                          name: seller.userName ?? seller.shopName ?? 'Seller',
                          roleName: 'Seller',
                          isActive: isActive,
                          color: const Color(0xFF006B2C),
                          member: ShopStaffMember(
                            (b) => b
                              ..id = sellerId
                              ..userName = seller.userName ?? seller.shopName ?? 'Seller'
                              ..role = ShopStaffMemberRoleEnum.SELLER,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(sellersProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmployeesTabView extends ConsumerWidget {
  const _EmployeesTabView({required this.searchQuery});

  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsyncValue = ref.watch(allEmployeesProvider);

    return employeesAsyncValue.when(
      data: (allEmployees) {
        final q = searchQuery.trim().toLowerCase();
        final employees = q.isEmpty
            ? allEmployees
            : allEmployees.where((emp) {
                final m = emp.member;
                final text = [
                  m.userName,
                  m.userId,
                  m.userNumber,
                  m.shopName,
                  m.employeeRole?.name,
                  emp.location?.name,
                ].whereType<String>().join(' ').toLowerCase();
                return text.contains(q);
              }).toList();

        if (employees.isEmpty) {
          return Center(
            child: Text(
              q.isEmpty ? 'No employees found under your shops.' : 'No employees matching "$searchQuery"',
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => ref.refresh(allEmployeesProvider.future),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: employees.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final empData = employees[index];
              final member = empData.member;
              final location = empData.location;
              final roleName = member.employeeRole?.name ?? 'Employee';
              final isActive = member.isActive ?? true;
              final empId = member.id;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.badge_rounded,
                          color: Color(0xFF2563EB),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member.userName ?? 'Unnamed Employee',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF64748B)),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    '${location?.name ?? member.shopName ?? 'No Shop Location'} • ${member.userNumber ?? 'No Phone'}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2563EB).withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    roleName,
                                    style: const TextStyle(
                                      color: Color(0xFF2563EB),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (member.userId != null && member.userId!.isNotEmpty)
                                  Text(
                                    'ID: ${member.userId}',
                                    style: const TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (empId != null)
                        _StaffRowActions(
                          id: empId,
                          name: member.userName ?? 'Employee',
                          roleName: roleName,
                          isActive: isActive,
                          color: const Color(0xFF2563EB),
                          member: member,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(allEmployeesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StaffRowActions extends ConsumerWidget {
  const _StaffRowActions({
    required this.id,
    required this.name,
    required this.roleName,
    required this.isActive,
    required this.color,
    required this.member,
  });

  final int id;
  final String name;
  final String roleName;
  final bool isActive;
  final Color color;
  final ShopStaffMember member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSuperAdmin = ref.watch(authProvider).role == UserRole.superAdmin;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSuperAdmin)
          IconButton(
            icon: Icon(Icons.swap_horiz_rounded, color: color, size: 20),
            tooltip: 'Move Location',
            onPressed: () => moveLocationEmployee(
              context,
              ref,
              locationId: 0,
              member: member,
            ),
          ),
        IconButton(
          icon: Icon(Icons.key_rounded, color: color, size: 20),
          tooltip: 'Change Password',
          onPressed: () => ChangePasswordDialog.show(
            context,
            userId: id,
            userName: name,
            role: roleName,
          ),
        ),
        Column(
          children: [
            Switch(
              value: isActive,
              activeThumbColor: const Color(0xFF006B2C),
              onChanged: (val) => _toggleStaffActive(
                context,
                ref,
                id: id,
                name: name,
                nextActive: val,
              ),
            ),
            Text(
              isActive ? 'Active' : 'Inactive',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isActive ? const Color(0xFF006B2C) : Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

