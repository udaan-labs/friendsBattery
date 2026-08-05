import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../providers/locations_providers.dart';

/// Admin list of shops (`SHOP`) or warehouses (`WAREHOUSE`).
class LocationsListScreen extends ConsumerWidget {
  const LocationsListScreen({super.key, required this.type});

  /// `SHOP` or `WAREHOUSE`
  final String type;

  bool get _isShop => type == 'SHOP';

  String get _title => _isShop ? 'Shops' : 'Warehouses';

  String get _addRoute =>
      _isShop ? '/admin/shops/add' : '/admin/warehouses/add';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(locationsByTypeProvider(type));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/admin/dashboard');
            }
          },
        ),
        title: Text(
          _title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await context.push<bool>(_addRoute);
          if (created == true) {
            ref.invalidate(locationsByTypeProvider(type));
          }
        },
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(_isShop ? 'Add shop' : 'Add warehouse'),
      ),
      body: async.when(
        data: (rows) {
          if (rows.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isShop
                          ? Icons.storefront_outlined
                          : Icons.warehouse_outlined,
                      size: 56,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _isShop ? 'No shops yet' : 'No warehouses yet',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isShop
                          ? 'Create a shop, then assign sellers to it.'
                          : 'Create a warehouse for inventory storage.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref.refresh(locationsByTypeProvider(type).future),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              itemCount: rows.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) => _LocationCard(item: rows[i]),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  e.toString().replaceFirst('Exception: ', ''),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () =>
                      ref.invalidate(locationsByTypeProvider(type)),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.item});

  final LocationItem item;

  @override
  Widget build(BuildContext context) {
    final isShop = item.type == LocationItemTypeEnum.SHOP;
    final accent =
        isShop ? const Color(0xFF006B2C) : const Color(0xFF2563EB);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: accent.withValues(alpha: 0.12),
            child: Icon(
              isShop ? Icons.storefront_rounded : Icons.warehouse_rounded,
              color: accent,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? 'Unnamed',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  [
                    if (item.code != null) item.code!,
                    if (item.address != null && item.address!.isNotEmpty)
                      item.address!,
                    if (item.phone != null && item.phone!.isNotEmpty)
                      item.phone!,
                  ].join(' · '),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (item.isActive != false)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Active',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
