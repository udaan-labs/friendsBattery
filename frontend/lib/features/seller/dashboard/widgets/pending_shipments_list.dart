import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/seller_dashboard_providers.dart';
import '../providers/seller_dashboard_controller.dart';
import '../../../../theme/app_theme.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../../shared/widgets/snackbar_helper.dart';

class PendingShipmentsList extends ConsumerStatefulWidget {
  const PendingShipmentsList({super.key});

  @override
  ConsumerState<PendingShipmentsList> createState() => _PendingShipmentsListState();
}

class _PendingShipmentsListState extends ConsumerState<PendingShipmentsList> {
  bool _isAccepting = false;

  String _getTimeAgo(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final dateTime = DateTime.parse(dateStr);
      final diff = DateTime.now().difference(dateTime);
      if (diff.isNegative) {
        return 'just now';
      }
      if (diff.inMinutes < 1) {
        return 'just now';
      } else if (diff.inMinutes < 60) {
        return '${diff.inMinutes}m ago';
      } else if (diff.inHours < 24) {
        return '${diff.inHours}h ago';
      } else {
        return '${diff.inDays}d ago';
      }
    } catch (e) {
      return dateStr;
    }
  }

  Future<void> _handleAccept(int shipmentId, String shipmentNumber) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Accept Shipment'),
          content: Text('Are you sure you have received all items in shipment $shipmentNumber?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF545F73))),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                minimumSize: const Size(80, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    setState(() {
      _isAccepting = true;
    });

    try {
      final api = ref.read(apiClientProvider).getShipmentsApi();
      await api.apiShipmentsShipmentIdAcceptPost(shipmentId: shipmentId);

      if (mounted) {
        context.showSuccessSnackBar('Shipment accepted successfully');
        // Refresh stats, pending shipments list, and main inventory
        await ref.read(sellerDashboardControllerProvider).refreshAllData();
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      if (mounted) {
        setState(() {
          _isAccepting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final shipmentsAsync = ref.watch(sellerPendingShipmentsProvider);

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pending Shipments',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191C1E),
            ),
          ),
          const SizedBox(height: 12),
          shipmentsAsync.when(
            data: (shipments) {
              if (shipments.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
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
                  child: const Column(
                    children: [
                      Icon(Icons.check_circle_outline, color: Color(0xFF16A34A), size: 48),
                      SizedBox(height: 12),
                      Text(
                        'No Pending Shipments',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'All shipments have been accepted.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF545F73)),
                      ),
                    ],
                  ),
                );
              }

              return Container(
                constraints: const BoxConstraints(maxHeight: 250),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Scrollbar(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shrinkWrap: true,
                      itemCount: shipments.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        color: Color(0xFFECEEF0),
                      ),
                      itemBuilder: (context, index) {
                        final shipment = shipments[index];
                        final shipmentId = shipment.shipmentId ?? 0;
                        final shipmentNum = shipment.shipmentNumber ?? '';
                        final totalProducts = shipment.items?.length ?? 0;
                        final totalQuantity = shipment.items?.fold<int>(0, (sum, item) => sum + (item.quantity ?? 0)) ?? 0;
                        final timeAgo = _getTimeAgo(shipment.createdAt);

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Row(
                            children: [
                              // Left Icon
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECEEF0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.local_shipping,
                                  color: Color(0xFF16A34A),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Center Content
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
                                      '$totalProducts Products',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF3E4A3D),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '$totalQuantity Items • $timeAgo',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF545F73),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Right Actions
                              Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      context.push('/seller/shipments/$shipmentId');
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Color(0xFFBDCABA)),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      minimumSize: const Size(60, 36),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'View',
                                      style: TextStyle(
                                        color: Color(0xFF3E4A3D),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: _isAccepting
                                        ? null
                                        : () => _handleAccept(shipmentId, shipmentNum),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF16A34A),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      minimumSize: const Size(70, 36),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Accept',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            loading: () => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e, st) => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
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
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Color(0xFFBA1A1A), size: 48),
                  const SizedBox(height: 12),
                  const Text(
                    'Unable to load shipments',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => ref.read(sellerDashboardControllerProvider).refreshAllData(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      minimumSize: const Size(120, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
