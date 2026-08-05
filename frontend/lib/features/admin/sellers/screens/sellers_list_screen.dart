import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/sellers_provider.dart';

class SellersListScreen extends ConsumerWidget {
  const SellersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellersAsyncValue = ref.watch(sellersProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
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
        title: const Text(
          'All Sellers',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Shops',
            icon: const Icon(Icons.storefront_outlined, color: Color(0xFF006B2C)),
            onPressed: () => context.push('/admin/shops'),
          ),
          IconButton(
            tooltip: 'Warehouses',
            icon: const Icon(Icons.warehouse_outlined, color: Color(0xFF006B2C)),
            onPressed: () => context.push('/admin/warehouses'),
          ),
          IconButton(
            tooltip: 'Add employee',
            icon: const Icon(Icons.badge_outlined, color: Color(0xFF006B2C)),
            onPressed: () => context.push('/admin/add-employee'),
          ),
          IconButton(
            tooltip: 'Add seller',
            icon: const Icon(Icons.person_add_alt_1, color: Color(0xFF006B2C)),
            onPressed: () => context.push('/admin/add-seller'),
          ),
        ],
      ),
      body: SafeArea(
        child: sellersAsyncValue.when(
          data: (sellers) {
            if (sellers.isEmpty) {
              return const Center(child: Text('No sellers found.'));
            }
            return RefreshIndicator(
              onRefresh: () => ref.refresh(sellersProvider.future),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: sellers.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final sellerData = sellers[index];
                  final seller = sellerData.seller;
                  final isVerified = seller.isVerified ?? false;
                  
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          context.push('/admin/sellers/${seller.id}');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.storefront_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            seller.shopName ?? seller.userName ?? 'Unknown Store',
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (isVerified) ...[
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.green.withValues(alpha: 0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.verified, color: Colors.green, size: 14),
                                          ),
                                        ],
                                        if (sellerData.hasLowStock == true) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.red.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: const Text('Low Stock', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${seller.userName ?? 'Unknown'} • ${seller.userNumber ?? 'No Phone'}',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        _MiniStat(icon: Icons.inventory_2_outlined, value: sellerData.totalStock.toString(), color: Colors.blue),
                                        const SizedBox(width: 16),
                                        _MiniStat(icon: Icons.payments_outlined, value: sellerData.todaySales.toString(), color: Colors.green),
                                        const SizedBox(width: 16),
                                        _MiniStat(icon: Icons.local_shipping_outlined, value: sellerData.pendingShipments.toString(), color: Colors.orange),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.grey.shade400,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.refresh(sellersProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _MiniStat({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
