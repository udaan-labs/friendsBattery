import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/app_formatters.dart';
import '../../../shared/staff/providers/staff_providers.dart';
import '../providers/locations_providers.dart';

/// Shops whose `warehouse_id` is this warehouse, plus each shop's admin.
/// ponytail: one staff GET per shop; dedicated API if a WH has many shops.
class WarehouseShopsSection extends ConsumerWidget {
  const WarehouseShopsSection({super.key, required this.warehouseId});

  final int warehouseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(allLocationsProvider);

    return async.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Column(
        children: [
          Text(friendlyError(e), textAlign: TextAlign.center),
          TextButton(
            onPressed: () => ref.invalidate(allLocationsProvider),
            child: const Text('Retry'),
          ),
        ],
      ),
      data: (rows) {
        final shops = rows
            .where(
              (e) =>
                  e.type == LocationItemTypeEnum.SHOP &&
                  e.warehouseId == warehouseId,
            )
            .toList(growable: false);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                'Shops',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
            if (shops.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.storefront_outlined, size: 40, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      'No shops under this warehouse',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              )
            else
              ...shops.map((shop) => _ShopRow(shop: shop)),
          ],
        );
      },
    );
  }
}

class _ShopRow extends ConsumerWidget {
  const _ShopRow({required this.shop});

  final LocationItem shop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = shop.id;
    final staffAsync =
        id == null ? null : ref.watch(locationStaffProvider(id));
    final admin = staffAsync?.valueOrNull?.admins?.toList();
    final adminName = (admin != null && admin.isNotEmpty)
        ? (admin.first.userName ?? admin.first.userId ?? 'Admin')
        : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: id == null
              ? null
              : () => context.push(
                    Uri(
                      path: '/admin/locations/$id',
                      queryParameters: {
                        if (shop.name != null && shop.name!.isNotEmpty)
                          'name': shop.name!,
                      },
                    ).toString(),
                  ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      const Color(0xFF006B2C).withValues(alpha: 0.12),
                  child: const Icon(
                    Icons.storefront_rounded,
                    color: Color(0xFF006B2C),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shop.name ?? 'Unnamed shop',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        [
                          if (shop.code != null) shop.code!,
                          if (staffAsync?.isLoading == true)
                            'Loading admin…'
                          else if (adminName != null)
                            'Admin: $adminName'
                          else
                            'No admin',
                        ].join(' · '),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
