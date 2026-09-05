import 'package:flutter/material.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../theme/app_theme.dart';
import '../repository/shipment_repository.dart';

class ShipmentSellerCard extends StatelessWidget {
  final List<SellerModel> sellers;
  final bool isLoading;
  final String? loadError;
  final int? selectedSellerId;
  final ValueChanged<int> onSelected;

  const ShipmentSellerCard({
    super.key,
    required this.sellers,
    required this.isLoading,
    this.loadError,
    required this.selectedSellerId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Recipient Seller / Shop',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191C1E),
            ),
          ),
          const SizedBox(height: 8),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (loadError != null)
            Text(
              loadError!,
              style: const TextStyle(color: AppTheme.error, fontSize: 13),
            )
          else if (sellers.isEmpty)
            const Text(
              'No sellers available. Create one first.',
              style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            )
          else
            DropdownButtonFormField<int>(
              isExpanded: true,
              initialValue: selectedSellerId,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
              hint: const Text('Select seller'),
              items: sellers
                  .map(
                    (seller) => DropdownMenuItem<int>(
                      value: seller.id,
                      child: Text('${seller.shopName} (${seller.userName})'),
                    ),
                  )
                  .toList(),
              onChanged: (id) {
                if (id != null) onSelected(id);
              },
            ),
        ],
      ),
    );
  }
}
