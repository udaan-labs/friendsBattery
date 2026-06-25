import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/seller_card.dart';
import '../providers/sellers_provider.dart';

class SellersListScreen extends ConsumerWidget {
  const SellersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellersAsyncValue = ref.watch(sellersProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'All Sellers',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // TODO: Implement filter
            },
          ),
        ],
      ),
      body: sellersAsyncValue.when(
        data: (sellers) {
          if (sellers.isEmpty) {
            return const Center(child: Text('No sellers found.'));
          }
          return RefreshIndicator(
            onRefresh: () => ref.refresh(sellersProvider.future),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: sellers.length,
              itemBuilder: (context, index) {
                final sellerData = sellers[index];
                final seller = sellerData.seller;
                return SellerCard(
                  seller: seller,
                  totalStock: sellerData.totalStock,
                  todaySales: sellerData.todaySales,
                  pendingShipments: sellerData.pendingShipments,
                  onTap: () {
                    context.push('/admin/sellers/${seller.id}');
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error', style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(sellersProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
