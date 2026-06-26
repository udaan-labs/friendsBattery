import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/seller_details_provider.dart';
import '../widgets/seller_info_card.dart';
import '../widgets/statistic_card.dart';
import '../widgets/inventory_product_card.dart';

class SellerDetailsScreen extends ConsumerStatefulWidget {
  final int sellerId;

  const SellerDetailsScreen({super.key, required this.sellerId});

  @override
  ConsumerState<SellerDetailsScreen> createState() => _SellerDetailsScreenState();
}

class _SellerDetailsScreenState extends ConsumerState<SellerDetailsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(sellerDetailsProvider(widget.sellerId));

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/admin/dashboard');
            }
          },
        ),
        title: const Text(
          'Seller Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(sellerDetailsProvider(widget.sellerId));
          },
          child: asyncData.when(
            data: (data) => _buildContent(data),
            loading: () => _buildLoadingState(),
            error: (err, stack) => _buildErrorState(err),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(SellerDetailsData data) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SellerInfoCard(
            shopName: data.shopName,
            userName: data.userName,
            userNumber: data.userNumber,
            isActive: data.isActive,
            isVerified: data.isVerified,
          ),
          const SizedBox(height: 24),
          
          LayoutBuilder(
            builder: (context, constraints) {
              final double ratio = constraints.maxWidth < 360 ? 0.95 : 1.15;
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: ratio,
                children: [
                  StatisticCard(
                    label: 'Stock',
                    value: data.stock.toString(),
                    icon: Icons.inventory_2_rounded,
                    color: Colors.blue,
                  ),
                  StatisticCard(
                    label: 'Products',
                    value: data.products.toString(),
                    icon: Icons.category_rounded,
                    color: Colors.purple,
                  ),
                  StatisticCard(
                    label: 'Sales',
                    value: data.sales.toString(),
                    icon: Icons.payments_rounded,
                    color: Colors.green,
                  ),
                  StatisticCard(
                    label: 'Returns',
                    value: data.returns.toString(),
                    icon: Icons.keyboard_return_rounded,
                    color: Colors.orange,
                  ),
                ],
              );
            },
          ),
          
          const SizedBox(height: 32),
          const Text(
            'Current Inventory',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          if (data.inventory.isEmpty)
            _buildEmptyInventoryState()
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.inventory.length,
              itemBuilder: (context, index) {
                return InventoryProductCard(
                  inventoryItem: data.inventory[index],
                  onTap: () {
                    // Navigate to product details if needed
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyInventoryState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('📦', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          const Text(
            'No Inventory Available',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'This seller currently has no products in stock.',
            style: TextStyle(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 1.0).animate(_pulseController),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSkeleton(height: 200),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final double ratio = constraints.maxWidth < 360 ? 0.95 : 1.15;
                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: ratio,
                  children: [
                    _buildSkeleton(),
                    _buildSkeleton(),
                    _buildSkeleton(),
                    _buildSkeleton(),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            _buildSkeleton(height: 24, width: 150),
            const SizedBox(height: 16),
            _buildSkeleton(height: 150),
            const SizedBox(height: 12),
            _buildSkeleton(height: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeleton({double? width, double? height}) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildErrorState(Object err) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Failed to load details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              err.toString(),
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(sellerDetailsProvider(widget.sellerId)),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
