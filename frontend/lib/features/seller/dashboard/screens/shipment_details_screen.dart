import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/seller_dashboard_providers.dart';

class ShipmentDetailsScreen extends ConsumerWidget {
  final int shipmentId;
  const ShipmentDetailsScreen({super.key, required this.shipmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentsAsync = ref.watch(sellerPendingShipmentsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Shipment Details'),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E4A3D)),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/seller/dashboard');
            }
          },
        ),
      ),
      body: shipmentsAsync.when(
        data: (shipments) {
          final shipment = shipments.firstWhere(
            (s) => s.shipmentId == shipmentId,
            orElse: () => shipments.first, // Fallback if not found
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shipment.shipmentNumber ?? '',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Status: ${shipment.status}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF16A34A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Created On: ${shipment.createdAt ?? ""}',
                        style: const TextStyle(fontSize: 13, color: Color(0xFF545F73)),
                      ),
                      const Divider(height: 32, color: Color(0xFFECEEF0)),
                      const Text(
                        'Products in Shipment',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                      ),
                      const SizedBox(height: 12),
                      ...?shipment.items?.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.productModel ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF191C1E),
                                ),
                              ),
                              Text(
                                '${item.quantity} units',
                                style: const TextStyle(fontSize: 14, color: Color(0xFF545F73)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
