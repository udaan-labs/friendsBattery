import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/common_pull_to_refresh.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../providers/seller_dashboard_controller.dart';
import '../providers/seller_dashboard_providers.dart';
import '../widgets/seller_kpi_grid.dart';
import '../widgets/seller_quick_actions.dart';
import '../widgets/recent_inventory_list.dart';
import '../widgets/pending_shipments_list.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import 'seller_shell_screen.dart';

class SellerDashboardScreen extends ConsumerWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(sellerProfileProvider);
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB), // bg-background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FB), // bg-surface
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF3E4A3D)),
          onPressed: () => sellerScaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(
          'Friends Battery',
          style: TextStyle(
            fontSize: ResponsiveHelper.isSmallPhone(context) ? 22 : 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF16A34A),
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: const Color(0xFF3E4A3D), size: ResponsiveHelper.isSmallPhone(context) ? 22 : 28),
                onPressed: () {},
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFBA1A1A),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: ResponsiveHelper.isSmallPhone(context) ? 4 : 8),
        ],
      ),
      body: SafeArea(
        child: CommonPullToRefresh(
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
                          style: TextStyle(
                            fontSize: ResponsiveHelper.isSmallPhone(context) ? 22 : 28,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF191C1E),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${profile.shopName} • ${profile.role}',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.isSmallPhone(context) ? 13 : 16,
                            color: const Color(0xFF545F73),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  // Search Bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          readOnly: true,
                          onTap: () => context.push('/seller/verify-product'),
                          decoration: InputDecoration(
                            hintText: 'Verify / Lookup Product by Serial Number',
                            hintStyle: const TextStyle(color: Color(0xFF545F73)),
                            prefixIcon: const Icon(Icons.search, color: Color(0xFF545F73)),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF16A34A)),
                              onPressed: () {
                                context.push('/seller/verify-product');
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
                  else if (isTablet)
                    SliverCrossAxisGroup(
                      slivers: [
                        const SliverCrossAxisExpanded(
                          flex: 6,
                          sliver: SliverMainAxisGroup(
                            slivers: [
                              SellerQuickActions(),
                            ],
                          ),
                        ),
                        const SliverCrossAxisExpanded(
                          flex: 1,
                          sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
                        ),
                        const SliverCrossAxisExpanded(
                          flex: 6,
                          sliver: SliverMainAxisGroup(
                            slivers: [
                              PendingShipmentsList(),
                              SliverToBoxAdapter(child: SizedBox(height: 32)),
                              RecentInventoryList(),
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
    );
  }
}
