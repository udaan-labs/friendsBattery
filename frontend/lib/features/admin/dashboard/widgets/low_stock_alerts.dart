import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_providers.dart';

class LowStockAlerts extends ConsumerWidget {
  const LowStockAlerts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsState = ref.watch(lowStockAlertsProvider);

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Low Stock Alerts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C1E),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006B2C),
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFF006B2C),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          alertsState.when(
            data: (alerts) {
              if (alerts.isEmpty) {
                return const Text('All stocks look good!');
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: alerts.length,
                itemBuilder: (context, index) {
                  final alert = alerts[index];
                  return _AlertCard(
                    itemName: alert['product'] ?? '',
                    sku: alert['sku'] ?? 'N/A',
                    stockLeft: '${alert['stock']} units left',
                    progress: (alert['stock'] ?? 0) / (alert['threshold'] ?? 10),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Text('Error: $e'),
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final String itemName;
  final String sku;
  final String stockLeft;
  final double progress;

  const _AlertCard({
    required this.itemName,
    required this.sku,
    required this.stockLeft,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFFFDAD6), // light red
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFBA1A1A), // red warning
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        itemName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF191C1E),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      stockLeft,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBA1A1A), // error red
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'SKU: $sku',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF586377),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: const Color(0xFFECEEF0),
                        color: const Color(0xFFBA1A1A),
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 24),
                    InkWell(
                      onTap: () {},
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Restock',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF006B2C),
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xFF006B2C),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
