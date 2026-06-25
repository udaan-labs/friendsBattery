import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/common_pull_to_refresh.dart';
import '../providers/shipment_provider.dart';

class ShipmentListScreen extends ConsumerWidget {
  const ShipmentListScreen({super.key});

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'DELIVERED':
        return const Color(0xFF00873A); // Green
      case 'PENDING':
        return const Color(0xFFC05600); // Amber/Orange
      case 'CANCELLED':
      case 'REJECTED':
        return const Color(0xFFBA1A1A); // Red
      default:
        return const Color(0xFF586377); // Grey
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status.toUpperCase()) {
      case 'DELIVERED':
        return const Color(0xFFE8F5E9);
      case 'PENDING':
        return const Color(0xFFFFF3E0);
      case 'CANCELLED':
      case 'REJECTED':
        return const Color(0xFFFFEBEE);
      default:
        return const Color(0xFFECEEF0);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentsState = ref.watch(shipmentsListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Shipments & Transfers'),
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
      body: CommonPullToRefresh(
        onRefresh: () async {
          ref.invalidate(shipmentsListProvider);
        },
        child: shipmentsState.when(
          data: (shipments) {
            if (shipments.isEmpty) {
              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_shipping_outlined, size: 64, color: Colors.grey[400]),
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
                            'Tap the + button to transfer stock.',
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
              padding: const EdgeInsets.all(16.0),
              itemCount: shipments.length,
              itemBuilder: (context, index) {
                final shipment = shipments[index];
                final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(shipment.createdAt);

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.background,
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
                      // Navigate to details if needed, but not specified in prompt
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shipment #${shipment.shipmentId}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF191C1E),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusBgColor(shipment.status),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  shipment.status.toUpperCase(),
                                  style: TextStyle(
                                    color: _getStatusColor(shipment.status),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.store, size: 18, color: Color(0xFF586377)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${shipment.shopName} (${shipment.sellerName})',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF191C1E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16, color: Color(0xFF586377)),
                              const SizedBox(width: 8),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total Items',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF586377),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${shipment.totalProducts} pcs',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF191C1E),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Shipment Value',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF586377),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '₹${shipment.totalAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF006B2C),
                                    ),
                                  ),
                                ],
                              ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppTheme.error),
                const SizedBox(height: 16),
                Text('Failed to load shipments: $err'),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/admin/shipments/create');
        },
        backgroundColor: const Color(0xFF006B2C),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Transfer Stock'),
      ),
    );
  }
}
