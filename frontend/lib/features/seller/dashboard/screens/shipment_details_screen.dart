import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/seller_dashboard_providers.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../core/state/data_sync.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../admin/shipments/providers/shipment_provider.dart';
import '../../../admin/shipments/repository/shipment_repository.dart';
import '../../../admin/shipments/widgets/shipment_detail_widgets.dart';

// ─── Screen ────────────────────────────────────────────────────────────────

class ShipmentDetailsScreen extends ConsumerStatefulWidget {
  final int shipmentId;
  const ShipmentDetailsScreen({super.key, required this.shipmentId});

  @override
  ConsumerState<ShipmentDetailsScreen> createState() =>
      _ShipmentDetailsScreenState();
}

class _ShipmentDetailsScreenState extends ConsumerState<ShipmentDetailsScreen> {
  bool _isAccepting = false;

  Future<void> _acceptShipment() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Accept Shipment?'),
        content: const Text(
          'This will add the products to your inventory. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006B2C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Accept'),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    setState(() => _isAccepting = true);
    try {
      await ref.read(shipmentRepositoryProvider).acceptShipment(widget.shipmentId);
      if (mounted) {
        context.showSuccessSnackBar(
          'Shipment accepted! Products added to inventory.',
        );
        DataSync.afterShipmentMutation(ref, shipmentId: widget.shipmentId);
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar(
          'Failed to accept shipment. Please try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _isAccepting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(
      sellerShipmentDetailProvider(widget.shipmentId),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text(
          'Shipment Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF191C1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E4A3D)),
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go('/seller/received-shipments'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Color(0xFF3E4A3D)),
            onPressed: () =>
                ref.invalidate(sellerShipmentDetailProvider(widget.shipmentId)),
          ),
        ],
      ),
      body: SafeArea(
        child: detailState.when(
          data: (data) => _buildBody(data),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _ErrorView(
            error: e.toString(),
            onRetry: () =>
                ref.invalidate(sellerShipmentDetailProvider(widget.shipmentId)),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ShipmentDetailModel data) {
    final dateFmt = DateFormat('dd MMM yyyy, hh:mm a');
    final status = data.status;
    final shipmentNumber = data.shipmentNumber;
    final createdAt = data.createdAt;
    final acceptedAt = data.acceptedAt;
    final sellerName = data.sellerUserName;
    final shopName = data.sellerShopName;
    final phone = data.sellerPhone;
    final totalProducts = data.totalProducts;
    final totalQuantity = data.totalQuantity;
    final items = data.items;

    return ListView(
      padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
      children: [
        // ── Status Banner ─────────────────────────────────────────────
        _StatusBanner(status: status),
        const SizedBox(height: 20),

        // ── Shipment Info Card ────────────────────────────────────────
        ShipmentSectionCard(
          title: 'Shipment Information',
          icon: Icons.local_shipping_outlined,
          children: [
            ShipmentInfoRow(
              icon: Icons.tag,
              label: 'Shipment Number',
              value: shipmentNumber,
            ),
            const ShipmentRowDivider(),
            ShipmentInfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Received On',
              value: dateFmt.format(createdAt),
            ),
            if (acceptedAt != null) ...[
              const ShipmentRowDivider(),
              ShipmentInfoRow(
                icon: Icons.done_all_rounded,
                label: 'Accepted On',
                value: dateFmt.format(acceptedAt),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),

        // ── Seller Info Card ──────────────────────────────────────────
        ShipmentSectionCard(
          title: 'Sent By',
          icon: Icons.admin_panel_settings_outlined,
          children: [
            ShipmentInfoRow(
              icon: Icons.storefront_outlined,
              label: 'Shop',
              value: shopName.isNotEmpty ? shopName : 'N/A',
            ),
            const ShipmentRowDivider(),
            ShipmentInfoRow(
              icon: Icons.person_outline,
              label: 'Username',
              value: sellerName,
            ),
            if (phone != null && phone.isNotEmpty) ...[
              const ShipmentRowDivider(),
              ShipmentInfoRow(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: phone,
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),

        // ── Summary Card ──────────────────────────────────────────────
        ShipmentSectionCard(
          title: 'Shipment Summary',
          icon: Icons.summarize_outlined,
          children: [
            Row(
              children: [
                Expanded(
                  child: ShipmentStatBox(
                    icon: Icons.category_outlined,
                    iconColor: const Color(0xFF006B2C),
                    bgColor: const Color(0xFFE8F5E9),
                    label: 'Product Types',
                    value: '$totalProducts',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShipmentStatBox(
                    icon: Icons.inventory_2_outlined,
                    iconColor: const Color(0xFF1565C0),
                    bgColor: const Color(0xFFE3F2FD),
                    label: 'Total Units',
                    value: '$totalQuantity',
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // ── Products Section ──────────────────────────────────────────
        const Row(
          children: [
            Icon(
              Icons.battery_charging_full_rounded,
              size: 20,
              color: Color(0xFF006B2C),
            ),
            SizedBox(width: 8),
            Text(
              'Products in this Shipment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF191C1E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ...items.asMap().entries.map(
          (entry) =>
              ShipmentProductCard(item: entry.value, index: entry.key + 1),
        ),

        // ── Accept Button (only if PENDING) ──────────────────────────
        if (status.toUpperCase() == 'PENDING') ...[
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isAccepting ? null : _acceptShipment,
              icon: _isAccepting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.check_circle_outline_rounded),
              label: Text(_isAccepting ? 'Accepting...' : 'Accept Shipment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006B2C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
              ),
            ),
          ),
        ],

        const SizedBox(height: 32),
      ],
    );
  }
}

// ─── Status Banner ─────────────────────────────────────────────────────────

class _StatusBanner extends StatelessWidget {
  final String status;
  const _StatusBanner({required this.status});

  Color get _bg {
    switch (status.toUpperCase()) {
      case 'ACCEPTED':
        return const Color(0xFFE8F5E9);
      case 'PENDING':
        return const Color(0xFFFFF3E0);
      case 'REJECTED':
        return const Color(0xFFFFEBEE);
      default:
        return const Color(0xFFECEEF0);
    }
  }

  Color get _fg {
    switch (status.toUpperCase()) {
      case 'ACCEPTED':
        return const Color(0xFF00873A);
      case 'PENDING':
        return const Color(0xFFC05600);
      case 'REJECTED':
        return const Color(0xFFBA1A1A);
      default:
        return const Color(0xFF586377);
    }
  }

  IconData get _icon {
    switch (status.toUpperCase()) {
      case 'ACCEPTED':
        return Icons.check_circle_rounded;
      case 'PENDING':
        return Icons.schedule_rounded;
      case 'REJECTED':
        return Icons.cancel_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.isSmallPhone(context) ? 12 : 16,
        horizontal: ResponsiveHelper.isSmallPhone(context) ? 16 : 20,
      ),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _fg.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(_icon, color: _fg, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shipment Status',
                  style: TextStyle(fontSize: 12, color: Color(0xFF586377)),
                ),
                const SizedBox(height: 2),
                Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: _fg,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Error View ────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 56, color: Color(0xFFBA1A1A)),
            const SizedBox(height: 16),
            const Text(
              'Failed to load shipment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF191C1E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: const TextStyle(fontSize: 13, color: Color(0xFF586377)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006B2C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
