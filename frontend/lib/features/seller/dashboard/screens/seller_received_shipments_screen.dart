import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/seller_dashboard_providers.dart';
import 'seller_shell_screen.dart';

class SellerReceivedShipmentsScreen extends ConsumerWidget {
  const SellerReceivedShipmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentsAsync = ref.watch(sellerAllShipmentsProvider);

    return PopScope(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go('/seller/dashboard');
      },
      child: Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text(
          'Received Shipments',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF3E4A3D)),
          onPressed: () => sellerScaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(sellerAllShipmentsProvider.future),
        child: shipmentsAsync.when(
          data: (shipments) {
            if (shipments.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.local_shipping_outlined, size: 64, color: Color(0xFF545F73)),
                        SizedBox(height: 16),
                        Text(
                          'No shipments yet',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Shipments assigned to you will appear here.',
                          style: TextStyle(fontSize: 14, color: Color(0xFF545F73)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: shipments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final shipment = shipments[index];
                final shipmentNum = shipment.shipmentNumber ?? 'SHP-${shipment.shipmentId}';
                final status = shipment.status ?? 'UNKNOWN';
                final itemCount = shipment.items?.length ?? 0;
                final totalQty = shipment.items?.fold<int>(0, (sum, item) => sum + (item.quantity ?? 0)) ?? 0;

                Color statusColor;
                Color statusBg;
                IconData statusIcon;
                switch (status.toUpperCase()) {
                  case 'RECEIVED':
                    statusColor = const Color(0xFF16A34A);
                    statusBg = const Color(0xFFDCFCE7);
                    statusIcon = Icons.check_circle_rounded;
                    break;
                  case 'PENDING':
                    statusColor = const Color(0xFFD97706);
                    statusBg = const Color(0xFFFEF3C7);
                    statusIcon = Icons.pending_rounded;
                    break;
                  default:
                    statusColor = const Color(0xFF545F73);
                    statusBg = const Color(0xFFECEEF0);
                    statusIcon = Icons.info_outline_rounded;
                }

                return GestureDetector(
                  onTap: () {
                    if (shipment.shipmentId != null) {
                      context.push('/seller/shipments/${shipment.shipmentId}');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(statusIcon, color: statusColor, size: 26),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shipmentNum,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF191C1E),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$itemCount product type${itemCount != 1 ? 's' : ''} • $totalQty unit${totalQty != 1 ? 's' : ''}',
                                style: const TextStyle(fontSize: 13, color: Color(0xFF545F73)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Color(0xFFBA1A1A), size: 48),
                const SizedBox(height: 16),
                const Text(
                  'Failed to load shipments',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => ref.refresh(sellerAllShipmentsProvider.future),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
