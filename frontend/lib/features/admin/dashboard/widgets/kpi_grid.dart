import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../providers/dashboard_providers.dart';

class KpiGrid extends ConsumerWidget {
  const KpiGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpiData = ref.watch(kpiProvider);
    final padding = ResponsiveHelper.responsiveHorizontalMargin(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isSmall = ResponsiveHelper.isSmallPhone(context);

    String formatNumber(String val) {
      if (val == '--') return '--';
      final parsed = int.tryParse(val.replaceAll(RegExp(r'[^0-9]'), ''));
      if (parsed == null) return val;
      final str = parsed.toString();
      if (str.length > 3) {
        return '${str.substring(0, str.length - 3)},${str.substring(str.length - 3)}';
      }
      return str;
    }

    Widget buildCard(String title, String value, String subtitle, IconData icon, {VoidCallback? onTap}) {
      return _KpiCard(
        title: title,
        value: formatNumber(value),
        subtitle: subtitle,
        icon: icon,
        color: const Color(0xFF006B2C),
        onTap: onTap,
        isSmall: isSmall,
      );
    }

    Widget buildGrid(String totalStock, String todaySales, String totalSellers, String pendingShipments) {
      if (isDesktop) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8.0),
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildCard('TOTAL STOCK', totalStock, 'Units', Icons.inventory_2_outlined, onTap: () {
                context.push('/shared/inventory');
              }),
              buildCard('TOTAL SALES', todaySales, 'Transactions', Icons.trending_up_outlined, onTap: () {
                context.push('/admin/sales');
              }),
              buildCard('TOTAL SELLERS', totalSellers, 'Active', Icons.group_outlined, onTap: () {
                context.push('/admin/sellers');
              }),
              buildCard('PENDING SHIPMENTS', pendingShipments, 'In transit', Icons.local_shipping_outlined, onTap: () {
                context.push('/admin/shipments');
              }),
            ],
          ),
        );
      } else {
        final spacing = isSmall ? 6.0 : 8.0;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: buildCard('TOTAL STOCK', totalStock, 'Units', Icons.inventory_2_outlined, onTap: () {
                    context.push('/shared/inventory');
                  })),
                  SizedBox(width: spacing),
                  Expanded(child: buildCard('TODAY\'S SALES', todaySales, 'Transactions', Icons.trending_up_outlined, onTap: () {
                    context.push('/admin/sales');
                  })),
                ],
              ),
              SizedBox(height: spacing),
              Row(
                children: [
                  Expanded(child: buildCard('TOTAL SELLERS', totalSellers, 'Active', Icons.group_outlined, onTap: () {
                    context.push('/admin/sellers');
                  })),
                  SizedBox(width: spacing),
                  Expanded(child: buildCard('PENDING SHIPMENTS', pendingShipments, 'In transit', Icons.local_shipping_outlined, onTap: () {
                    context.push('/admin/shipments');
                  })),
                ],
              ),
            ],
          ),
        );
      }
    }

    return kpiData.when(
      data: (stats) => buildGrid(
        (stats.totalStock ?? 0).toString(),
        (stats.todaySales ?? 0).toString(),
        (stats.totalSellers ?? 0).toString(),
        (stats.pendingShipments ?? 0).toString(),
      ),
      loading: () => buildGrid('--', '--', '--', '--'),
      error: (e, st) => const SizedBox.shrink(),
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
            child: Icon(
              icon,
              color: color,
              size: iconSize,
            ),
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
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF586377),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
