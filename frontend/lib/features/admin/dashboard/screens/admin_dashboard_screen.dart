import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../core/storage/session_manager.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/logout_dialog_helper.dart';
import '../../../../theme/app_theme.dart';
import '../providers/admin_stock_provider.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/kpi_grid.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_activity_timeline.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  String _currentTab = 'dashboard';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _stockSearchController = TextEditingController();
  Timer? _stockSearchDebounce;

  @override
  void initState() {
    super.initState();
    // KPI / activity load via ref.watch in child widgets — no forced double-fetch here.
  }

  @override
  void dispose() {
    _stockSearchController.dispose();
    _stockSearchDebounce?.cancel();
    super.dispose();
  }

  void _switchTab(String tabId) {
    setState(() {
      _currentTab = tabId;
    });
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      context.pop(); // Close drawer
    }
    // Do not force-refresh on every tab switch; pull-to-refresh covers intentional reloads.
  }

  void _onStockSearchChanged(String value) {
    if (_stockSearchDebounce?.isActive ?? false) _stockSearchDebounce!.cancel();
    _stockSearchDebounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(adminStockQueryProvider.notifier).update(
            (q) => q.copyWith(page: 1, search: value),
          );
    });
  }

  void _goToStockPage(int page) {
    ref.read(adminStockQueryProvider.notifier).update((q) => q.copyWith(page: page));
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'AD';
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'AD';
    if (parts.length == 1) {
      final word = parts[0];
      return word.length >= 2 ? word.substring(0, 2).toUpperCase() : word.toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  String _getUserNameSafe() {
    final user = SessionManager.user;
    if (user == null) return 'Administrator';
    return (user['userName'] ?? user['username'] ?? 'Administrator').toString();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final username = _getUserNameSafe();
    final isSuperAdmin = ref.watch(authProvider).role == UserRole.superAdmin;

    return PopScope(
      canPop: _currentTab == 'dashboard',
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _switchTab('dashboard');
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF191C1E)),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          'Friends Battery',
          style: TextStyle(
            fontSize: ResponsiveHelper.isSmallPhone(context) ? 20 : 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF006B2C),
          ),
        ),
        actions: [

          IconButton(
            icon: Icon(
              Icons.history,
              color: const Color(0xFF3E4A3D),
              size: ResponsiveHelper.isSmallPhone(context) ? 24 : 28,
            ),
            onPressed: () => context.push('/admin/activity-history'),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: const Color(0xFF3E4A3D), size: ResponsiveHelper.isSmallPhone(context) ? 24 : 28),
            onPressed: () {
              showLogoutConfirmationDialog(context, ref);
            },
          ),
          SizedBox(width: ResponsiveHelper.isSmallPhone(context) ? 4 : 8),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFF7F9FB), // bg-surface
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + (ResponsiveHelper.isSmallPhone(context) ? 16 : 24),
                bottom: ResponsiveHelper.isSmallPhone(context) ? 16 : 24,
                left: ResponsiveHelper.isSmallPhone(context) ? 12 : 16,
                right: ResponsiveHelper.isSmallPhone(context) ? 12 : 16,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFECEEF0), // bg-surface-container
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFFD5E0F8), // bg-secondary-container
                    foregroundColor: const Color(0xFF111C2D), // text-on-secondary-fixed
                    child: Text(
                      _getInitials(username),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: const TextStyle(
                            color: Color(0xFF191C1E), // text-on-surface
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'System Administrator',
                          style: TextStyle(color: Color(0xFF3E4A3D), fontSize: 13), // text-on-surface-variant
                        ),
                        SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 4 : 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E3E5), // bg-surface-container-highest
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'Fleet Manager v1.0.4',
                            style: TextStyle(color: Color(0xFF3E4A3D), fontSize: ResponsiveHelper.isSmallPhone(context) ? 9 : 10, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Navigation List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _buildDrawerItem(
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard,
                    title: 'Dashboard',
                    tabId: 'dashboard',
                  ),
                  _buildDrawerItem(
                    icon: Icons.price_change_outlined,
                    activeIcon: Icons.price_change,
                    title: 'Configure Product',
                    tabId: 'configure_product',
                    onTap: () {
                      context.pop();
                      context.push('/admin/add-product/configure');
                    },
                  ),
                  // Super Admin owns catalog only — no personal inventory screen.
                  if (!isSuperAdmin)
                    _buildDrawerItem(
                      icon: Icons.inventory_2_outlined,
                      activeIcon: Icons.inventory_2,
                      title: 'View Stock',
                      tabId: 'view_stock',
                      onTap: () {
                        context.pop(); // close drawer
                        context.push('/admin/inventory');
                      },
                    ),
                  _buildDrawerItem(
                    icon: Icons.qr_code_scanner_outlined,
                    activeIcon: Icons.qr_code_scanner,
                    title: 'Verify Product',
                    tabId: 'verify_product',
                    onTap: () {
                      context.pop();
                      context.push('/admin/verify-product');
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.people_outline,
                    activeIcon: Icons.people,
                    title: 'Manage Sellers',
                    tabId: 'manage_sellers',
                    onTap: () {
                      context.pop();
                      context.go('/admin/sellers');
                    },
                  ),
                  if (!isSuperAdmin) ...[
                    _buildDrawerItem(
                      icon: Icons.point_of_sale_outlined,
                      activeIcon: Icons.point_of_sale,
                      title: 'Sales',
                      tabId: 'sales',
                      onTap: () {
                        context.pop();
                        context.push('/admin/sales');
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.swap_horiz_outlined,
                      activeIcon: Icons.swap_horiz,
                      title: 'Stock Transfer',
                      tabId: 'stock_transfer',
                      onTap: () {
                        context.pop();
                        context.go('/admin/shipments');
                      },
                    ),
                  ],
                ],
              ),
            ),
            const Divider(height: 1),
            // Drawer Footer
            Padding(
              padding: EdgeInsets.all(ResponsiveHelper.responsiveHorizontalMargin(context)),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Color(0xFFBA1A1A)), // text-error
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Color(0xFFBA1A1A), fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                onTap: () {
                  context.pop(); // close drawer
                  showLogoutConfirmationDialog(context, ref);
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _buildCurrentTabView(isDesktop, isTablet),
      ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required IconData activeIcon,
    required String title,
    required String tabId,
    VoidCallback? onTap,
  }) {
    final isActive = _currentTab == tabId;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListTile(
        leading: Icon(
          isActive ? activeIcon : icon,
          color: isActive ? const Color(0xFF111C2D) : const Color(0xFF3E4A3D),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? const Color(0xFF111C2D) : const Color(0xFF3E4A3D),
            fontSize: 14,
          ),
        ),
        selected: isActive,
        selectedTileColor: const Color(0xFFD5E0F8), // bg-secondary-container
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
        onTap: onTap ?? () => _switchTab(tabId),
      ),
    );
  }

  Widget _buildCurrentTabView(bool isDesktop, bool isTablet) {
    switch (_currentTab) {
      case 'dashboard':
        return _buildDashboardTabView(isDesktop, isTablet);
      case 'view_stock':
        return _buildViewStockTabView();
      case 'manage_sellers':
        // Redirect to the proper dedicated screen to avoid duplication
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) context.go('/admin/sellers');
        });
        return const Center(child: CircularProgressIndicator());
      case 'stock_transfer':
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) context.go('/admin/shipments');
        });
        return const Center(child: CircularProgressIndicator());
      default:
        return _buildPlaceholderTabView(_currentTab);
    }
  }

  // --- Sub-View: Bento Grid Dashboard ---
  Widget _buildDashboardTabView(bool isDesktop, bool isTablet) {
    return RefreshIndicator(
      onRefresh: () => refreshAdminDashboard(ref),
      color: AppTheme.primary,
      backgroundColor: Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFF7F9FB),
              width: double.infinity,
              child: const KpiGrid(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.responsiveHorizontalMargin(context),
              vertical: 16.0,
            ),
            sliver: SliverMainAxisGroup(
              slivers: [
                if (isDesktop)
                        SliverCrossAxisGroup(
                          slivers: [
                            SliverCrossAxisExpanded(
                              flex: 8,
                              sliver: SliverMainAxisGroup(
                                slivers: const [
                                  RecentActivityTimeline(),
                                ],
                              ),
                            ),
                            const SliverCrossAxisExpanded(
                              flex: 1,
                              sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
                            ),
                            SliverCrossAxisExpanded(
                              flex: 4,
                              sliver: SliverMainAxisGroup(
                                slivers: const [
                                  QuickActions(),
                                ],
                              ),
                            ),
                          ],
                        )
                      else if (isTablet)
                        SliverCrossAxisGroup(
                          slivers: [
                            SliverCrossAxisExpanded(
                              flex: 6,
                              sliver: SliverMainAxisGroup(
                                slivers: const [
                                  QuickActions(),
                                ],
                              ),
                            ),
                            const SliverCrossAxisExpanded(
                              flex: 1,
                              sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
                            ),
                            SliverCrossAxisExpanded(
                              flex: 6,
                              sliver: SliverMainAxisGroup(
                                slivers: const [
                                  RecentActivityTimeline(),
                                ],
                              ),
                            ),
                          ],
                        )
                      else
                        SliverMainAxisGroup(
                          slivers: const [
                            QuickActions(),
                            SliverToBoxAdapter(child: SizedBox(height: 24)),
                            RecentActivityTimeline(),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // --- Sub-View: View Stock (Paginated Table via shared provider) ---
  Widget _buildViewStockTabView() {
    final stockAsync = ref.watch(adminStockDetailsProvider);
    final query = ref.watch(adminStockQueryProvider);
    final stockPage = query.page;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(ResponsiveHelper.responsiveHorizontalMargin(context)),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _stockSearchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF3E4A3D)),
                    hintText: 'Search product model...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(999)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onChanged: _onStockSearchChanged,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.refresh, color: Color(0xFF006B2C)),
                onPressed: () => ref.invalidate(adminStockDetailsProvider),
              ),
            ],
          ),
        ),
        Expanded(
          child: stockAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => Center(
              child: TextButton(
                onPressed: () => ref.invalidate(adminStockDetailsProvider),
                child: const Text('Failed to load stock. Retry'),
              ),
            ),
            data: (pageData) {
              if (pageData.items.isEmpty) {
                return const Center(child: Text('No stock matches found.'));
              }
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Subcategory', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Product Model', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Total Qty', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                      DataColumn(label: Text('Sold Qty', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                      DataColumn(label: Text('Remaining Qty', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                    ],
                    rows: pageData.items.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item.category)),
                        DataCell(Text(item.subcategory)),
                        DataCell(Text(item.productName, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF006B2C)))),
                        DataCell(Text(item.total.toString())),
                        DataCell(Text(item.sold.toString())),
                        DataCell(Text(item.remaining.toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ResponsiveHelper.responsiveHorizontalMargin(context)),
          child: stockAsync.maybeWhen(
            data: (pageData) {
              final totalPages = pageData.totalPages;
              if (totalPages <= 1) return const SizedBox.shrink();
              return ResponsiveHelper.isSmallPhone(context)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Page $stockPage of $totalPages',
                        style: const TextStyle(color: Color(0xFF3E4A3D)),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: stockPage <= 1 ? null : () => _goToStockPage(stockPage - 1),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 48),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                          ),
                          child: const Text('Previous'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: stockPage >= totalPages ? null : () => _goToStockPage(stockPage + 1),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 48),
                            backgroundColor: const Color(0xFF006B2C),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                          ),
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Page $stockPage of $totalPages', style: const TextStyle(color: Color(0xFF3E4A3D))),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: stockPage <= 1 ? null : () => _goToStockPage(stockPage - 1),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 48),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                          ),
                          child: const Text('Previous'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: stockPage >= totalPages ? null : () => _goToStockPage(stockPage + 1),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 48),
                            backgroundColor: const Color(0xFF006B2C),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                          ),
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ],
                );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  // --- Sub-View: Placeholder View ---
  Widget _buildPlaceholderTabView(String tabId) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
        padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.construction, color: Color(0xFF006B2C), size: ResponsiveHelper.isSmallPhone(context) ? 48 : 64),
            SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 12 : 16),
            Text(
              '${tabId[0].toUpperCase()}${tabId.substring(1).replaceAll('_', ' ')} Tab',
              style: TextStyle(fontSize: ResponsiveHelper.isSmallPhone(context) ? 16 : 20, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
            ),
            SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 6 : 8),
            Text(
              'This module interface section is being configured. Check back soon for transactional integrations.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF3E4A3D), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
