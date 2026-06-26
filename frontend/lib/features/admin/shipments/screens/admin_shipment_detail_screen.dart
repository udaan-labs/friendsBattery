import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/snackbar_helper.dart';

// ─── Model ─────────────────────────────────────────────────────────────────

class ShipmentItem {
  final int productId;
  final String category;
  final String productName;
  final String productModel;
  final int quantity;
  final double pricePerPiece;
  final double lineTotal;

  ShipmentItem({
    required this.productId,
    required this.category,
    required this.productName,
    required this.productModel,
    required this.quantity,
    required this.pricePerPiece,
    required this.lineTotal,
  });

  factory ShipmentItem.fromJson(Map<String, dynamic> json) {
    return ShipmentItem(
      productId: json['product_id'] ?? 0,
      category: json['category'] ?? '',
      productName: json['product_name'] ?? '',
      productModel: json['product_model'] ?? '',
      quantity: json['quantity'] ?? 0,
      pricePerPiece: (json['price_per_piece'] ?? 0).toDouble(),
      lineTotal: (json['line_total'] ?? 0).toDouble(),
    );
  }
}

class ShipmentDetail {
  final int shipmentId;
  final String status;
  final DateTime createdAt;
  final DateTime? deliveredOn;
  final String senderName;
  final String receiverName;
  final String receiverShop;
  final int totalProducts;
  final double totalAmount;
  final List<ShipmentItem> items;

  ShipmentDetail({
    required this.shipmentId,
    required this.status,
    required this.createdAt,
    this.deliveredOn,
    required this.senderName,
    required this.receiverName,
    required this.receiverShop,
    required this.totalProducts,
    required this.totalAmount,
    required this.items,
  });

  factory ShipmentDetail.fromJson(Map<String, dynamic> json) {
    final sender = json['sender'] as Map<String, dynamic>? ?? {};
    final receiver = json['receiver'] as Map<String, dynamic>? ?? {};
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return ShipmentDetail(
      shipmentId: json['shipment_id'] ?? 0,
      status: json['status'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      deliveredOn: json['delivered_on'] != null ? DateTime.tryParse(json['delivered_on']) : null,
      senderName: sender['user_name'] ?? 'Admin',
      receiverName: receiver['user_name'] ?? '',
      receiverShop: receiver['shop_name'] ?? '',
      totalProducts: json['total_products'] ?? 0,
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      items: rawItems.whereType<Map<String, dynamic>>().map(ShipmentItem.fromJson).toList(),
    );
  }
}

// ─── Provider ──────────────────────────────────────────────────────────────

final shipmentDetailProvider = FutureProvider.family<ShipmentDetail, int>((ref, id) async {
  final dio = ref.watch(apiClientProvider).dio;
  final response = await dio.get('/api/transfers/$id');
  final body = response.data;
  final data = (body is Map && body['data'] != null) ? body['data'] : body;
  return ShipmentDetail.fromJson(data as Map<String, dynamic>);
});

// ─── Screen ────────────────────────────────────────────────────────────────

class AdminShipmentDetailScreen extends ConsumerStatefulWidget {
  final int shipmentId;
  const AdminShipmentDetailScreen({super.key, required this.shipmentId});

  @override
  ConsumerState<AdminShipmentDetailScreen> createState() => _AdminShipmentDetailScreenState();
}

class _AdminShipmentDetailScreenState extends ConsumerState<AdminShipmentDetailScreen> {
  bool _isCancelling = false;

  Color _statusColor(String status) {
    switch (status.toUpperCase()) {
      case 'DELIVERED': return const Color(0xFF00873A);
      case 'PENDING': return const Color(0xFFC05600);
      case 'CANCELLED':
      case 'REJECTED': return const Color(0xFFBA1A1A);
      default: return const Color(0xFF586377);
    }
  }

  Color _statusBgColor(String status) {
    switch (status.toUpperCase()) {
      case 'DELIVERED': return const Color(0xFFE8F5E9);
      case 'PENDING': return const Color(0xFFFFF3E0);
      case 'CANCELLED':
      case 'REJECTED': return const Color(0xFFFFEBEE);
      default: return const Color(0xFFECEEF0);
    }
  }

  Future<void> _cancelShipment() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Shipment?'),
        content: const Text('This action cannot be undone. The shipment will be marked as CANCELLED.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBA1A1A), foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Cancel Shipment'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isCancelling = true);
    try {
      final dio = ref.read(apiClientProvider).dio;
      await dio.patch('/api/transfers/${widget.shipmentId}/cancel');
      if (mounted) {
        context.showSuccessSnackBar('Shipment cancelled successfully');
        ref.invalidate(shipmentDetailProvider(widget.shipmentId));
      }
    } catch (e) {
      if (mounted) context.showErrorSnackBar('Failed to cancel shipment');
    } finally {
      if (mounted) setState(() => _isCancelling = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(shipmentDetailProvider(widget.shipmentId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: Text('Shipment #${widget.shipmentId}'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF191C1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E4A3D)),
          onPressed: () => context.canPop() ? context.pop() : context.go('/admin/shipments'),
        ),
      ),
      body: detailState.when(
        data: (detail) => _buildBody(detail),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppTheme.error),
              const SizedBox(height: 16),
              Text('Failed to load: $e'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(shipmentDetailProvider(widget.shipmentId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ShipmentDetail detail) {
    final fmt = DateFormat('dd MMM yyyy, hh:mm a');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── Status Banner ────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
            color: _statusBgColor(detail.status),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                detail.status.toUpperCase() == 'DELIVERED'
                    ? Icons.check_circle_outline
                    : detail.status.toUpperCase() == 'PENDING'
                        ? Icons.schedule
                        : Icons.cancel_outlined,
                color: _statusColor(detail.status),
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                detail.status.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: _statusColor(detail.status),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Summary Card ─────────────────────────────────────────
        _InfoCard(children: [
          _InfoRow(Icons.local_shipping_outlined, 'Sender', detail.senderName),
          const Divider(height: 20),
          _InfoRow(Icons.store_outlined, 'Receiver', '${detail.receiverShop} (${detail.receiverName})'),
          const Divider(height: 20),
          _InfoRow(Icons.calendar_today, 'Created', fmt.format(detail.createdAt)),
          if (detail.deliveredOn != null) ...[
            const Divider(height: 20),
            _InfoRow(Icons.done_all, 'Delivered', fmt.format(detail.deliveredOn!)),
          ],
          const Divider(height: 20),
          _InfoRow(Icons.inventory_2_outlined, 'Total Items', '${detail.totalProducts} pcs'),
          const Divider(height: 20),
          _InfoRow(Icons.currency_rupee, 'Shipment Value', '₹${detail.totalAmount.toStringAsFixed(2)}'),
        ]),
        const SizedBox(height: 20),

        // ── Items ─────────────────────────────────────────────────
        const Text('Items in this Shipment',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF191C1E))),
        const SizedBox(height: 12),
        ...detail.items.map((item) => _ShipmentItemCard(item: item)),

        // ── Cancel Button ────────────────────────────────────────
        if (detail.status.toUpperCase() == 'PENDING') ...[
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isCancelling ? null : _cancelShipment,
              icon: _isCancelling
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.cancel_outlined),
              label: Text(_isCancelling ? 'Cancelling...' : 'Cancel Shipment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBA1A1A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}

// ─── Sub-widgets ───────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 4))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF586377)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF586377))),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShipmentItemCard extends StatelessWidget {
  final ShipmentItem item;
  const _ShipmentItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFECEEF0)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.battery_charging_full, color: Color(0xFF006B2C), size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productModel,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF191C1E))),
                const SizedBox(height: 2),
                Text('${item.category} • ${item.productName}',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF586377))),
                const SizedBox(height: 4),
                Text('${item.quantity} pcs × ₹${item.pricePerPiece.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF3E4A3D))),
              ],
            ),
          ),
          Text(
            '₹${item.lineTotal.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF006B2C)),
          ),
        ],
      ),
    );
  }
}
