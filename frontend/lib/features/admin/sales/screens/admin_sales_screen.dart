import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/common_pull_to_refresh.dart';

// ─── Provider ──────────────────────────────────────────────────────────────

class AdminSale {
  final int id;
  final String sellerName;
  final String shopName;
  final String productModel;
  final String category;
  final double sellPrice;
  final String? customerName;
  final String? vehicleNumber;
  final DateTime soldAt;

  AdminSale({
    required this.id,
    required this.sellerName,
    required this.shopName,
    required this.productModel,
    required this.category,
    required this.sellPrice,
    this.customerName,
    this.vehicleNumber,
    required this.soldAt,
  });

  factory AdminSale.fromJson(Map<String, dynamic> json) {
    return AdminSale(
      id: json['id'] ?? 0,
      sellerName: json['seller']?['user_name'] ?? 'Unknown',
      shopName: json['seller']?['shop_name'] ?? 'Unknown',
      productModel: json['product']?['product_model'] ?? 'Unknown',
      category: json['product']?['category'] ?? 'Unknown',
      sellPrice: (json['sell_price'] ?? 0).toDouble(),
      customerName: json['customer']?['name'],
      vehicleNumber: json['vehicle_number'],
      soldAt: DateTime.tryParse(json['sold_at'] ?? '') ?? DateTime.now(),
    );
  }
}

final adminSalesProvider = FutureProvider<List<AdminSale>>((ref) async {
  final dio = ref.watch(apiClientProvider).dio;
  final response = await dio.get('/api/sales');
  final body = response.data;
  final List<dynamic> rawList =
      (body is Map && body['data'] is List) ? body['data'] : (body is List ? body : []);
  return rawList.whereType<Map<String, dynamic>>().map(AdminSale.fromJson).toList();
});

// ─── Screen ────────────────────────────────────────────────────────────────

class AdminSalesScreen extends ConsumerWidget {
  const AdminSalesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesState = ref.watch(adminSalesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Sales History'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF191C1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E4A3D)),
          onPressed: () {
            if (context.canPop()) context.pop();
            else context.go('/admin/dashboard');
          },
        ),
      ),
      body: CommonPullToRefresh(
        onRefresh: () async => ref.invalidate(adminSalesProvider),
        child: salesState.when(
          data: (sales) {
            if (sales.isEmpty) {
              return ListView(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.point_of_sale_outlined, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('No sales recorded yet.',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ]);
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sales.length,
              itemBuilder: (context, index) {
                final sale = sales[index];
                return _SaleCard(sale: sale);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppTheme.error),
                const SizedBox(height: 16),
                Text('Failed to load sales: $e'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(adminSalesProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SaleCard extends StatelessWidget {
  final AdminSale sale;
  const _SaleCard({required this.sale});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(sale.soldAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: sale ID + amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sale #${sale.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF191C1E)),
                ),
                Text(
                  '₹${sale.sellPrice.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF006B2C)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Product
            Row(children: [
              const Icon(Icons.battery_charging_full, size: 16, color: Color(0xFF586377)),
              const SizedBox(width: 6),
              Expanded(child: Text('${sale.category} • ${sale.productModel}',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF191C1E)))),
            ]),
            const SizedBox(height: 6),
            // Seller
            Row(children: [
              const Icon(Icons.store_outlined, size: 16, color: Color(0xFF586377)),
              const SizedBox(width: 6),
              Expanded(child: Text('${sale.shopName} (${sale.sellerName})',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF586377)))),
            ]),
            if (sale.customerName != null) ...[
              const SizedBox(height: 6),
              Row(children: [
                const Icon(Icons.person_outline, size: 16, color: Color(0xFF586377)),
                const SizedBox(width: 6),
                Text(sale.customerName!, style: const TextStyle(fontSize: 13, color: Color(0xFF586377))),
              ]),
            ],
            if (sale.vehicleNumber != null && sale.vehicleNumber!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Row(children: [
                const Icon(Icons.directions_car_outlined, size: 16, color: Color(0xFF586377)),
                const SizedBox(width: 6),
                Text(sale.vehicleNumber!, style: const TextStyle(fontSize: 13, color: Color(0xFF586377))),
              ]),
            ],
            const Divider(height: 20, thickness: 1),
            Row(children: [
              const Icon(Icons.calendar_today, size: 14, color: Color(0xFF586377)),
              const SizedBox(width: 6),
              Text(formattedDate, style: const TextStyle(fontSize: 12, color: Color(0xFF586377))),
            ]),
          ],
        ),
      ),
    );
  }
}
