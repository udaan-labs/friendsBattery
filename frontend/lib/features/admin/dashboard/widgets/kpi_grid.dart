import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_providers.dart';

class KpiGrid extends ConsumerWidget {
  const KpiGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;
    final kpiData = ref.watch(kpiProvider);

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

    Widget buildCard(String title, String value, String subtitle, IconData icon) {
      return _KpiCard(
        title: title,
        value: formatNumber(value),
        subtitle: subtitle,
        icon: icon,
        color: const Color(0xFF006B2C),
      );
    }

    Widget buildGrid(String totalStock, String todaySales, String totalSellers) {
      if (isDesktop) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildCard('TOTAL STOCK', totalStock, 'Units', Icons.inventory_2_outlined),
              buildCard('TOTAL SALES', todaySales, 'Units', Icons.trending_up_outlined),
              buildCard('TOTAL SELLERS', totalSellers, 'Active', Icons.group_outlined),
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(child: buildCard('TOTAL STOCK', totalStock, 'Units', Icons.inventory_2_outlined)),
              const SizedBox(width: 8),
              Expanded(child: buildCard('TOTAL SALES', todaySales, 'Units', Icons.trending_up_outlined)),
              const SizedBox(width: 8),
              Expanded(child: buildCard('TOTAL SELLERS', totalSellers, 'Active', Icons.group_outlined)),
            ],
          ),
        );
      }
    }

    return kpiData.when(
      data: (stats) => buildGrid(
        stats.totalStock.toString(),
        stats.todaySales.toString(),
        stats.totalSellers.toString(),
      ),
      loading: () => buildGrid('--', '--', '--'),
      error: (e, st) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECEEF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 16,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF586377),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF191C1E),
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
    );
  }
}
