import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/shipment_provider.dart';
import '../repository/shipment_repository.dart';
import '../widgets/shipment_detail_widgets.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../theme/app_theme.dart';

// ─── Screen ────────────────────────────────────────────────────────────────

class AdminShipmentDetailScreen extends ConsumerWidget {
  final int shipmentId;
  const AdminShipmentDetailScreen({super.key, required this.shipmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(shipmentDetailByIdProvider(shipmentId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: Text(
          'Shipment #$shipmentId',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF191C1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E4A3D)),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/admin/shipments'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Color(0xFF3E4A3D)),
            onPressed: () =>
                ref.invalidate(shipmentDetailByIdProvider(shipmentId)),
          ),
        ],
      ),
      body: SafeArea(
        child: detailState.when(
          data: (detail) => _ShipmentDetailBody(detail: detail),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _ErrorView(
            error: e.toString(),
            onRetry: () =>
                ref.invalidate(shipmentDetailByIdProvider(shipmentId)),
          ),
        ),
      ),
    );
  }
}

// ─── Body ─────────────────────────────────────────────────────────────────

class _ShipmentDetailBody extends StatelessWidget {
  final ShipmentDetailModel detail;
  const _ShipmentDetailBody({required this.detail});

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('dd MMM yyyy, hh:mm a');

    return ListView(
      padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
      children: [
        // ── Status Banner ───────────────────────────────────────────────
        _StatusBanner(status: detail.status),
        const SizedBox(height: 20),

        // ── Shipment Info Card ──────────────────────────────────────────
        ShipmentSectionCard(
          title: 'Shipment Information',
          icon: Icons.local_shipping_outlined,
          children: [
            ShipmentInfoRow(
              icon: Icons.tag,
              label: 'Shipment Number',
              value: detail.shipmentNumber,
            ),
            const ShipmentRowDivider(),
            ShipmentInfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Created On',
              value: dateFmt.format(detail.createdAt),
            ),
            if (detail.acceptedAt != null) ...[
              const ShipmentRowDivider(),
              ShipmentInfoRow(
                icon: Icons.done_all_rounded,
                label: 'Accepted On',
                value: dateFmt.format(detail.acceptedAt!),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),

        // ── Seller Info Card ────────────────────────────────────────────
        ShipmentSectionCard(
          title: 'Seller Information',
          icon: Icons.store_outlined,
          children: [
            ShipmentInfoRow(
              icon: Icons.storefront_outlined,
              label: 'Shop Name',
              value: detail.sellerShopName.isNotEmpty
                  ? detail.sellerShopName
                  : 'N/A',
            ),
            const ShipmentRowDivider(),
            ShipmentInfoRow(
              icon: Icons.person_outline,
              label: 'Seller Username',
              value: detail.sellerUserName,
            ),
            if (detail.sellerPhone != null &&
                detail.sellerPhone!.isNotEmpty) ...[
              const ShipmentRowDivider(),
              ShipmentInfoRow(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: detail.sellerPhone!,
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),

        // ── Shipment Summary ────────────────────────────────────────────
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
                    value: '${detail.totalProducts}',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShipmentStatBox(
                    icon: Icons.inventory_2_outlined,
                    iconColor: const Color(0xFF1565C0),
                    bgColor: const Color(0xFFE3F2FD),
                    label: 'Total Units',
                    value: '${detail.totalQuantity}',
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // ── Products Section ────────────────────────────────────────────
        Row(
          children: [
            const Icon(
              Icons.battery_charging_full_rounded,
              size: 20,
              color: Color(0xFF006B2C),
            ),
            const SizedBox(width: 8),
            const Text(
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

        ...detail.items.asMap().entries.map(
          (entry) =>
              ShipmentProductCard(item: entry.value, index: entry.key + 1),
        ),

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
          Icon(_icon, color: _fg, size: 24),
          const SizedBox(width: 12),
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
                    fontSize: 18,
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
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 56, color: AppTheme.error),
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
