import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/shared/common.dart';
import '../../../seller/dashboard/providers/seller_dashboard_providers.dart';

/// Read-only shipment detail for employees (no accept action).
class EmployeeShipmentDetailScreen extends ConsumerWidget {
  final int shipmentId;

  const EmployeeShipmentDetailScreen({super.key, required this.shipmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(sellerShipmentDetailProvider(shipmentId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Shipment Details', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E4A3D)),
          onPressed: () => context.canPop() ? context.pop() : context.go('/employee/shipments'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(sellerShipmentDetailProvider(shipmentId)),
          ),
        ],
      ),
      body: detailState.when(
        data: (data) => ListView(
          padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
          children: [
            ShipmentStatusBanner(status: data.status),
            const SizedBox(height: 16),
            Text(
              data.shipmentNumber,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
            ),
            const SizedBox(height: 8),
            Text(
              'Created: ${formatAppDateTime(data.createdAt)}',
              style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
            if (data.sellerShopName.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text('Shop: ${data.sellerShopName}', style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
            ],
            const SizedBox(height: 16),
            Text(
              '${data.totalProducts} products · ${data.totalQuantity} units',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ...data.items.map(
              (item) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.productName} · ${item.productModel}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          if (item.serialNumber != null && item.serialNumber!.isNotEmpty)
                            Text(
                              item.serialNumber!,
                              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                            ),
                        ],
                      ),
                    ),
                    Text('×${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'View only — employees cannot accept shipments.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(friendlyError(e), textAlign: TextAlign.center),
              TextButton(
                onPressed: () => ref.invalidate(sellerShipmentDetailProvider(shipmentId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
