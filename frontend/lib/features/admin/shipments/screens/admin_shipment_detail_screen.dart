import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/shipment_provider.dart';
import '../repository/shipment_repository.dart';
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
            onRetry: () => ref.invalidate(shipmentDetailByIdProvider(shipmentId)),
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
        _SectionCard(
          title: 'Shipment Information',
          icon: Icons.local_shipping_outlined,
          children: [
            _InfoRow(
              icon: Icons.tag,
              label: 'Shipment Number',
              value: detail.shipmentNumber,
            ),
            const _Divider(),
            _InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Created On',
              value: dateFmt.format(detail.createdAt),
            ),
            if (detail.acceptedAt != null) ...[
              const _Divider(),
              _InfoRow(
                icon: Icons.done_all_rounded,
                label: 'Accepted On',
                value: dateFmt.format(detail.acceptedAt!),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),

        // ── Seller Info Card ────────────────────────────────────────────
        _SectionCard(
          title: 'Seller Information',
          icon: Icons.store_outlined,
          children: [
            _InfoRow(
              icon: Icons.storefront_outlined,
              label: 'Shop Name',
              value: detail.sellerShopName.isNotEmpty
                  ? detail.sellerShopName
                  : 'N/A',
            ),
            const _Divider(),
            _InfoRow(
              icon: Icons.person_outline,
              label: 'Seller Username',
              value: detail.sellerUserName,
            ),
            if (detail.sellerPhone != null &&
                detail.sellerPhone!.isNotEmpty) ...[
              const _Divider(),
              _InfoRow(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: detail.sellerPhone!,
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),

        // ── Shipment Summary ────────────────────────────────────────────
        _SectionCard(
          title: 'Shipment Summary',
          icon: Icons.summarize_outlined,
          children: [
            Row(
              children: [
                Expanded(
                  child: _StatBox(
                    icon: Icons.category_outlined,
                    iconColor: const Color(0xFF006B2C),
                    bgColor: const Color(0xFFE8F5E9),
                    label: 'Product Types',
                    value: '${detail.totalProducts}',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatBox(
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
            const Icon(Icons.battery_charging_full_rounded,
                size: 20, color: Color(0xFF006B2C)),
            const SizedBox(width: 8),
            const Text(
              'Products in this Shipment',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C1E)),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ...detail.items.asMap().entries.map(
              (entry) => _ProductCard(item: entry.value, index: entry.key + 1),
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
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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

// ─── Section Card ──────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const _SectionCard(
      {required this.title, required this.icon, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 4))
        ],
      ),
      padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF006B2C)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF191C1E),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

// ─── Info Row ──────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF586377)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF586377))),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF191C1E))),
            ],
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) =>
      const Divider(height: 20, thickness: 1, color: Color(0xFFF0F0F0));
}

// ─── Stat Box ──────────────────────────────────────────────────────────────

class _StatBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String label;
  final String value;
  const _StatBox({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: iconColor),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF586377)),
          ),
        ],
      ),
    );
  }
}

// ─── Product Card ──────────────────────────────────────────────────────────

class _ProductCard extends StatelessWidget {
  final ShipmentItemDetailModel item;
  final int index;
  const _ProductCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFECEEF0)),
        boxShadow: const [
          BoxShadow(
              color: Color(0x06000000), blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Number badge
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF006B2C).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF006B2C),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Model (primary)
                  Text(
                    item.productModel.isNotEmpty ? item.productModel : 'Unknown Model',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Category • Name
                  Text(
                    [
                      if (item.productGroup.isNotEmpty) item.productGroup,
                      if (item.category.isNotEmpty) item.category,
                      if (item.productName.isNotEmpty) item.productName,
                    ].join(' • '),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF586377),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Quantity chip
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _Chip(
                        icon: Icons.inventory_2_outlined,
                        label: '${item.quantity} unit${item.quantity != 1 ? 's' : ''}',
                        color: const Color(0xFF006B2C),
                        bg: const Color(0xFFE8F5E9),
                      ),
                      if (item.serialNumber != null &&
                          item.serialNumber!.isNotEmpty)
                        _Chip(
                          icon: Icons.qr_code_rounded,
                          label: item.serialNumber!,
                          color: const Color(0xFF1565C0),
                          bg: const Color(0xFFE3F2FD),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bg;
  const _Chip(
      {required this.icon,
      required this.label,
      required this.color,
      required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w600, color: color),
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
                  color: Color(0xFF191C1E)),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
