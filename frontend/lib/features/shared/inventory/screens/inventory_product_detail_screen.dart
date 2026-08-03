import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/inventory_provider.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../shared/providers/auth_provider.dart';

class InventoryProductDetailScreen extends ConsumerWidget {
  final int productId;

  const InventoryProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(sharedInventoryProductDetailProvider(productId));
    // Employees: stock only — no money fields (MVP: no sales for employees).
    final showPrice = ref.watch(authProvider).role != UserRole.employee;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF3E4A3D)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: productState.when(
        data: (product) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(ResponsiveHelper.responsiveHorizontalMargin(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productModel,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF191C1E),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.productName,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF545F73),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatItem(
                                  icon: Icons.inventory_2_rounded,
                                  iconColor: product.isLowStock ? Colors.orange : Colors.green,
                                  iconBg: product.isLowStock ? Colors.orange.shade50 : Colors.green.shade50,
                                  label: 'In Stock',
                                  value: '${product.quantity} Units',
                                ),
                              ),
                              if (showPrice)
                                Expanded(
                                  child: _buildStatItem(
                                    icon: Icons.currency_rupee_rounded,
                                    iconColor: Colors.blue.shade700,
                                    iconBg: Colors.blue.shade50,
                                    label: 'Min Price',
                                    value: '₹${product.minPrice.toStringAsFixed(0)}',
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Serials Section
                    const Text(
                      'Available Serial Numbers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF191C1E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    product.serialNumbers.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Text(
                                'No serial numbers available.',
                                style: TextStyle(color: Color(0xFF545F73), fontSize: 16),
                              ),
                            ),
                          )
                        : Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: product.serialNumbers.map((serial) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade200),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x05000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.qr_code, size: 16, color: Color(0xFF545F73)),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        serial,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF191C1E),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text('Failed to load product details.'),
              TextButton(
                onPressed: () => ref.invalidate(sharedInventoryProductDetailProvider(productId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF545F73),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF191C1E),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
