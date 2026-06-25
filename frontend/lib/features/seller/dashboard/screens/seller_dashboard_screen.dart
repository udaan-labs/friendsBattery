import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/common_pull_to_refresh.dart';
import '../providers/seller_dashboard_controller.dart';
import '../providers/seller_dashboard_providers.dart';
import '../widgets/seller_kpi_grid.dart';
import '../widgets/seller_quick_actions.dart';
import '../widgets/recent_inventory_list.dart';
import '../widgets/pending_shipments_list.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../../shared/widgets/logout_dialog_helper.dart';

class SellerDashboardScreen extends ConsumerWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(sellerProfileProvider);
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
            color: Color(0xFF16A34A), // text-primary
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
              showLogoutConfirmationDialog(context, ref);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CommonPullToRefresh(
        onRefresh: () => ref.read(sellerDashboardControllerProvider).refreshAllData(),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              sliver: SliverMainAxisGroup(
                slivers: [
                  // Welcome Section
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning, ${profile.userName.split(" ").first}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF191C1E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${profile.shopName} • ${profile.role}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF545F73),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  // Search Bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Battery by Serial Number',
                            hintStyle: const TextStyle(color: Color(0xFF545F73)),
                            prefixIcon: const Icon(Icons.search, color: Color(0xFF545F73)),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF16A34A)),
                              onPressed: () {
                                context.showInfoSnackBar('QR Code scanner tapped');
                              },
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // KPI Grid
                  const SellerKpiGrid(),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),

                  if (isDesktop)
                    SliverCrossAxisGroup(
                      slivers: [
                        const SliverCrossAxisExpanded(
                          flex: 8,
                          sliver: SliverMainAxisGroup(
                            slivers: [
                              PendingShipmentsList(),
                              SliverToBoxAdapter(child: SizedBox(height: 32)),
                              RecentInventoryList(),
                            ],
                          ),
                        ),
                        const SliverCrossAxisExpanded(
                          flex: 1,
                          sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
                        ),
                        const SliverCrossAxisExpanded(
                          flex: 4,
                          sliver: SliverMainAxisGroup(
                            slivers: [
                              SellerQuickActions(),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    SliverMainAxisGroup(
                      slivers: const [
                        SellerQuickActions(),
                        SliverToBoxAdapter(child: SizedBox(height: 32)),
                        PendingShipmentsList(),
                        SliverToBoxAdapter(child: SizedBox(height: 32)),
                        RecentInventoryList(),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/seller/create-bill');
        },
        backgroundColor: const Color(0xFF16A34A),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'New Bill',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: !isDesktop
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFECEEF0), // surface-container
              selectedItemColor: const Color(0xFF16A34A), // primary
              unselectedItemColor: const Color(0xFF586377), // on-secondary-container
              showUnselectedLabels: true,
              currentIndex: 0,
              onTap: (index) {
                if (index == 3) {
                  showLogoutConfirmationDialog(context, ref);
                } else if (index == 1) {
                  context.push('/shared/inventory');
                } else if (index == 2) {
                  context.showInfoSnackBar('Sales Screen coming soon');
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2),
                  label: 'Stock',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.auto_graph),
                  label: 'Sales',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.logout),
                  label: 'Logout',
                ),
              ],
            )
          : null,
    );
  }
}
