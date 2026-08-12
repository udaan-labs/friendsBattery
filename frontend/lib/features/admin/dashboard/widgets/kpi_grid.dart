import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../shared/products/providers/product_catalog_providers.dart';
import '../providers/dashboard_providers.dart';

class KpiGrid extends ConsumerWidget {
  const KpiGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpiData = ref.watch(kpiProvider);
    final padding = ResponsiveHelper.responsiveHorizontalMargin(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isSmall = ResponsiveHelper.isSmallPhone(context);
    final isSuperAdmin = ref.watch(authProvider).role == UserRole.superAdmin;

    // Catalog product-name count (DataSync.afterProductMutation invalidates this).
    final productCount = isSuperAdmin
        ? ref.watch(productNamesProvider).when(
              data: (n) => '${n.length}',
              loading: () => '--',
              error: (_, __) => '--',
            )
        : '--';

    Widget card(
      String title,
      String value,
      String subtitle,
      IconData icon, {
      VoidCallback? onTap,
    }) {
      return _KpiCard(
        title: title,
        value: value,
        subtitle: subtitle,
        icon: icon,
        color: const Color(0xFF006B2C),
        onTap: onTap,
        isSmall: isSmall,
      );
    }

    List<Widget> cards({
      required String stock,
      required String sales,
      required String sellers,
      required String shipments,
      required String locations,
      required String admins,
    }) {
      if (isSuperAdmin) {
        return [
          card('PRODUCTS', productCount, 'In catalog', Icons.inventory_2_outlined,
              onTap: () => context.push('/admin/add-product/configure')),
          card('LOCATIONS', locations, 'Shops & warehouses', Icons.location_city_outlined,
              onTap: () => context.push('/admin/locations')),
        ];
      }
      return [
        card('TOTAL STOCK', stock, 'Units', Icons.inventory_2_outlined,
            onTap: () => context.push('/shared/inventory')),
        card(isDesktop ? 'TOTAL SALES' : 'TODAY\'S SALES', sales, 'Transactions',
            Icons.trending_up_outlined,
            onTap: () => context.push('/admin/sales')),
        card('TOTAL SELLERS', sellers, 'Active', Icons.group_outlined,
            onTap: () => context.push('/admin/sellers')),
        card('PENDING SHIPMENTS', shipments, 'In transit', Icons.local_shipping_outlined,
            onTap: () => context.push('/admin/shipments')),
      ];
    }


    Widget layout(List<Widget> items) {
      if (isDesktop) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8),
          child: GridView.count(
            crossAxisCount: items.length.clamp(1, 4),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: items,
          ),
        );
      }
      final gap = isSmall ? 6.0 : 8.0;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8),
        child: Column(
          children: [
            Row(children: [
              Expanded(child: items[0]),
              SizedBox(width: gap),
              Expanded(child: items[1]),
            ]),
            if (items.length >= 4) ...[
              SizedBox(height: gap),
              Row(children: [
                Expanded(child: items[2]),
                SizedBox(width: gap),
                Expanded(child: items[3]),
              ]),
            ],
          ],
        ),
      );

    }

    return kpiData.when(
      data: (s) => layout(cards(
        stock: '${s.totalStock ?? 0}',
        sales: '${s.todaySales ?? 0}',
        sellers: '${s.totalSellers ?? 0}',
        shipments: '${s.pendingShipments ?? 0}',
        locations: '${s.totalLocations ?? 0}',
        admins: '${s.totalAdmins ?? 0}',
      )),
      loading: () => layout(cards(
        stock: '--',
        sales: '--',
        sellers: '--',
        shipments: '--',
        locations: '--',
        admins: '--',
      )),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool isSmall;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = isSmall ? 14.0 : 16.0;
    final valueSize = isSmall ? 16.0 : 18.0;
    final titleSize = isSmall ? 8.0 : 9.0;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFECEEF0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(isSmall ? 6 : 8),
        child: Row(
          children: [
            Container(
              width: isSmall ? 28 : 32,
              height: isSmall ? 28 : 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: iconSize),
            ),
            SizedBox(width: isSmall ? 4 : 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF586377),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: valueSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF191C1E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 9, color: Color(0xFF586377)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
