import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/seller_dashboard_providers.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../../shared/widgets/snackbar_helper.dart';

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
      final dio = ref.read(apiClientProvider).dio;
      await dio.post('/api/shipments/${widget.shipmentId}/accept');
      if (mounted) {
        context.showSuccessSnackBar(
          'Shipment accepted! Products added to inventory.',
        );
        // Refresh providers
        ref.invalidate(sellerShipmentDetailProvider(widget.shipmentId));
        ref.invalidate(sellerAllShipmentsProvider);
        ref.invalidate(sellerPendingShipmentsProvider);
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

  Widget _buildBody(Map<String, dynamic> data) {
    final dateFmt = DateFormat('dd MMM yyyy, hh:mm a');
    final status = data['status'] as String? ?? '';
    final shipmentNumber = data['shipmentNumber'] as String? ?? '';
    final createdAt =
        DateTime.tryParse(data['createdAt'] as String? ?? '') ?? DateTime.now();
    final acceptedAt = data['acceptedAt'] != null
        ? DateTime.tryParse(data['acceptedAt'] as String)
        : null;
    final seller = data['seller'] as Map<String, dynamic>? ?? {};
    final sellerName = seller['userName'] as String? ?? '';
    final shopName = seller['shopName'] as String? ?? '';
    final phone = seller['userNumber'] as String?;
    final totalProducts = _parseInt(data['totalProducts']);
    final totalQuantity = _parseInt(data['totalQuantity']);
    final items = (data['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList();

    return ListView(
      padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
      children: [
        // ── Status Banner ─────────────────────────────────────────────
        _StatusBanner(status: status),
        const SizedBox(height: 20),

        // ── Shipment Info Card ────────────────────────────────────────
        _SectionCard(
          title: 'Shipment Information',
          icon: Icons.local_shipping_outlined,
          children: [
            _InfoRow(
              icon: Icons.tag,
              label: 'Shipment Number',
              value: shipmentNumber,
            ),
            const _RowDivider(),
            _InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Received On',
              value: dateFmt.format(createdAt),
            ),
            if (acceptedAt != null) ...[
              const _RowDivider(),
              _InfoRow(
                icon: Icons.done_all_rounded,
                label: 'Accepted On',
                value: dateFmt.format(acceptedAt),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),

        // ── Seller Info Card ──────────────────────────────────────────
        _SectionCard(
          title: 'Sent By',
          icon: Icons.admin_panel_settings_outlined,
          children: [
            _InfoRow(
              icon: Icons.storefront_outlined,
              label: 'Shop',
              value: shopName.isNotEmpty ? shopName : 'N/A',
            ),
            const _RowDivider(),
            _InfoRow(
              icon: Icons.person_outline,
              label: 'Username',
              value: sellerName,
            ),
            if (phone != null && phone.isNotEmpty) ...[
              const _RowDivider(),
              _InfoRow(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: phone,
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),

        // ── Summary Card ──────────────────────────────────────────────
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
                    value: '$totalProducts',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatBox(
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
          (entry) => _ProductCard(item: entry.value, index: entry.key + 1),
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

  static int _parseInt(dynamic v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    if (v is double) return v.toInt();
    return 0;
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

// ─── Section Card ──────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

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
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF586377)),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();
  @override
  Widget build(BuildContext context) =>
      const Divider(height: 20, thickness: 1, color: Color(0xFFF0F0F0));
}

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
          Icon(
            icon,
            size: ResponsiveHelper.iconSize(context, 22),
            color: iconColor,
          ),
          SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 6 : 8),
          Text(
            value,
            style: TextStyle(
              fontSize: ResponsiveHelper.fontSize(context, 24),
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
          SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 1 : 2),
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
  final Map<String, dynamic> item;
  final int index;
  const _ProductCard({required this.item, required this.index});

  static int _parseInt(dynamic v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    if (v is double) return v.toInt();
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final category = item['category'] as String? ?? '';
    final productGroup = item['productGroup'] as String? ?? '';
    final productName = item['productName'] as String? ?? '';
    final productModel = item['productModel'] as String? ?? '';
    final quantity = _parseInt(item['quantity']);
    final serialNumber = item['serialNumber'] as String?;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFECEEF0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Index badge
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
                  // Model
                  Text(
                    productModel.isNotEmpty ? productModel : 'Unknown Model',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Breadcrumb
                  Text(
                    [
                      if (productGroup.isNotEmpty) productGroup,
                      if (category.isNotEmpty) category,
                      if (productName.isNotEmpty) productName,
                    ].join(' • '),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF586377),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _Chip(
                        icon: Icons.inventory_2_outlined,
                        label: '$quantity unit${quantity != 1 ? 's' : ''}',
                        color: const Color(0xFF006B2C),
                        bg: const Color(0xFFE8F5E9),
                      ),
                      if (serialNumber != null && serialNumber.isNotEmpty)
                        _Chip(
                          icon: Icons.qr_code_rounded,
                          label: serialNumber,
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
  const _Chip({
    required this.icon,
    required this.label,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
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
