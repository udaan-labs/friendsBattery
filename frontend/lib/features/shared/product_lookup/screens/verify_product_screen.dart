import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'product_details_screen.dart';
import '../providers/product_lookup_provider.dart';
import '../../../../core/theme/app_colors.dart';

class VerifyProductScreen extends ConsumerStatefulWidget {
  const VerifyProductScreen({super.key});

  @override
  ConsumerState<VerifyProductScreen> createState() => _VerifyProductScreenState();
}

class _VerifyProductScreenState extends ConsumerState<VerifyProductScreen> {
  final _searchController = TextEditingController();
  bool _isScanning = false;
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchProduct(String identifier) {
    if (identifier.trim().isEmpty) return;
    
    ref.read(productLookupProvider.notifier).lookupProduct(identifier.trim());
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(productLookupProvider);

    ref.listen<AsyncValue<Map<String, dynamic>?>>(productLookupProvider, (previous, next) {
      next.when(
        data: (data) {
          if (data != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(productData: data),
              ),
            ).then((_) {
              // Clear search when going back if needed
              ref.read(productLookupProvider.notifier).clearResult();
            });
          }
        },
        error: (err, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err.toString()),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.fixed,
            ),
          );
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Product'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: _isScanning 
        ? _buildScanner() 
        : _buildManualEntry(searchState.isLoading),
    );
  }

  Widget _buildScanner() {
    return Stack(
      children: [
        MobileScanner(
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
              final String code = barcodes.first.rawValue!;
              setState(() {
                _isScanning = false;
                _searchController.text = code;
              });
              _searchProduct(code);
            }
          },
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () => setState(() => _isScanning = false),
              icon: const Icon(Icons.close),
              label: const Text('Cancel Scan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildManualEntry(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Lookup by Serial Number or QR Code',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Serial Number',
              hintText: 'e.g. BAT-2026-000123',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.numbers),
            ),
            onSubmitted: (value) => _searchProduct(value),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: isLoading ? null : () => _searchProduct(_searchController.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Search', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('OR', style: TextStyle(color: Colors.grey)),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: isLoading ? null : () => setState(() => _isScanning = true),
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Scan QR Code'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
