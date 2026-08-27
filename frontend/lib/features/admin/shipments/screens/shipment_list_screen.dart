import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/shared/common.dart';
import '../../../../theme/app_theme.dart';
import '../providers/shipment_provider.dart';

class ShipmentListScreen extends ConsumerWidget {
  const ShipmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentsState = ref.watch(shipmentsListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text(
          'Shipments',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E4A3D)),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/admin/dashboard');
            }
          },
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(shipmentsListProvider);
        },
        color: AppTheme.primary,
        backgroundColor: Colors.white,
        child: shipmentsState.when(
          data: (shipments) {
            if (shipments.isEmpty) {
              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (ResponsiveHelper.isSmallPhone(context) ? 0.5 : 0.6),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_shipping_outlined,
                              size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No shipments created yet.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap the + button to create a shipment.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

              return ListView.builder(
              padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
              itemCount: shipments.length,
              itemBuilder: (context, index) {
                final shipment = shipments[index];
                final formattedDate =
                    formatAppDateTime(shipment.createdAt);

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      context.push('/admin/shipments/${shipment.shipmentId}');
                    },
                    child: Padding(
                      padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shipment.shipmentNumber,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF191C1E),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '#${shipment.shipmentId}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF586377),
                                    ),
                                  ),
                                ],
                              ),
                              ShipmentStatusChip(status: shipment.status),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Seller Row
                          Row(
                            children: [
                              const Icon(Icons.store_outlined,
                                  size: 16, color: Color(0xFF586377)),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  shipment.shopName.isNotEmpty
                                      ? '${shipment.shopName} (${shipment.sellerName})'
                                      : shipment.sellerName,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF191C1E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Date Row
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 14, color: Color(0xFF586377)),
                              const SizedBox(width: 6),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF586377),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24, thickness: 1),

                          // Summary Row
                          Row(
                            children: [
                              Expanded(
                                child: _SummaryChip(
                                  icon: Icons.category_outlined,
                                  label: '${shipment.totalProducts} product type${shipment.totalProducts != 1 ? 's' : ''}',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _SummaryChip(
                                  icon: Icons.inventory_2_outlined,
                                  label: '${shipment.totalQuantity} unit${shipment.totalQuantity != 1 ? 's' : ''}',
                                ),
                              ),
                              const Icon(Icons.chevron_right,
                                  color: Color(0xFF586377)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: AppTheme.error),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load shipments: $err',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(shipmentsListProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/admin/shipments/create');
        },
        backgroundColor: const Color(0xFF006B2C),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Create Shipment'),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SummaryChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF586377)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF586377)),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
