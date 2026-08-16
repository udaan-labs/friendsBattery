import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/app_formatters.dart';
import '../../../shared/inventory/providers/inventory_provider.dart';
import '../../../shared/inventory/widgets/inventory_product_card.dart';

/// Available serial units physically at this location.
class LocationStockSection extends ConsumerWidget {
  const LocationStockSection({super.key, required this.locationId});

  final int locationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(locationInventoryProvider(locationId));

    return async.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Text(friendlyError(e), textAlign: TextAlign.center),
            TextButton(
              onPressed: () =>
                  ref.invalidate(locationInventoryProvider(locationId)),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (page) {
        if (page.items.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(Icons.inventory_2_outlined, size: 40, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  'No stock at this location',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 4),
                Text(
                  'Add stock to this location from inventory.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 4),
              child: Text(
                'Stock',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
            ...page.items.asMap().entries.map((e) {
              final item = e.value;
              return InventoryProductCard(
                item: item,
                index: e.key + 1,
                onTap: () =>
                    context.push('/shared/inventory/${item.productId}'),
              );
            }),
          ],
        );
      },
    );
  }
}
