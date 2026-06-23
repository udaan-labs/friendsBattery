import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/common_pull_to_refresh.dart';
import '../providers/dashboard_controller.dart';
import '../widgets/kpi_grid.dart';
import '../widgets/low_stock_alerts.dart';
import '../widgets/quick_actions.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB), // bg-background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FB), // bg-surface
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF3E4A3D)), // text-on-surface-variant
          onPressed: () {},
        ),
        title: const Text(
          'BatteryPro',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006B2C), // text-primary
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF3E4A3D)),
            onPressed: () {},
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Color(0xFF3E4A3D)),
                onPressed: () {},
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFBA1A1A), // text-error
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF3E4A3D)),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CommonPullToRefresh(
        onRefresh: () => ref.read(dashboardControllerProvider).refreshAllData(),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              sliver: SliverMainAxisGroup(
                slivers: [
                  const KpiGrid(),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  if (isDesktop)
                    SliverCrossAxisGroup(
                      slivers: [
                        SliverCrossAxisExpanded(
                          flex: 8,
                          sliver: SliverMainAxisGroup(
                            slivers: const [
                              LowStockAlerts(),
                            ],
                          ),
                        ),
                        const SliverCrossAxisExpanded(
                          flex: 1, // Space between columns
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
                  else
                    SliverMainAxisGroup(
                      slivers: const [
                        LowStockAlerts(),
                        SliverToBoxAdapter(child: SizedBox(height: 32)),
                        QuickActions(),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/admin/add-seller');
        },
        backgroundColor: const Color(0xFF006B2C),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, size: 32),
      ),
      bottomNavigationBar: !isDesktop
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFECEEF0), // surface-container
              selectedItemColor: const Color(0xFF00873A), // primary-container
              unselectedItemColor: const Color(0xFF586377), // on-secondary-container
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_search),
                  label: 'Sellers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.battery_charging_full),
                  label: 'Stock',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.warning),
                  label: 'Alerts',
                ),
              ],
            )
          : null,
    );
  }
}
